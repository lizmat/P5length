use v6.d;

proto sub length(|) is export {*}
multi sub length(--> Int:D) { length(CALLER::LEXICAL::<$_>) }
multi sub length(Any:U $type) { $type }
multi sub length(Any:D $string --> Int:D) { length($string.Str) }
multi sub length(Str:D $string --> Int:D) { $string.chars }

=begin pod

=head1 NAME

Raku port of Perl's length() built-in

=head1 SYNOPSIS

  use P5length; # exports length()

  say length("foobar"); # 6
  say length(Str);      # Str

  $_ = "foobar";
  say length;           # 6

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<length> built-in
as closely as possible in the Raku Programming Language.

=head1 ORIGINAL PERL 5 DOCUMENTATION

    length EXPR
    length  Returns the length in characters of the value of EXPR. If EXPR is
            omitted, returns the length of $_. If EXPR is undefined, returns
            "undef".

            This function cannot be used on an entire array or hash to find
            out how many elements these have. For that, use "scalar @array"
            and "scalar keys %hash", respectively.

            Like all Perl character operations, length() normally deals in
            logical characters, not physical bytes. For how many bytes a
            string encoded as UTF-8 would take up, use
            "length(Encode::encode_utf8(EXPR))" (you'll have to "use Encode"
            first). See Encode and perlunicode.

=head1 PORTING CAVEATS

=head2 Characters vs codepoints

Since the Perl documentation mentions C<characters> rather than codepoints,
C<length> will return the number of characters, as seen using Normalization
Form Grapheme (NFG).

=head2 Handling of type objects

C<length> in Perl is supposed to return C<undef> when given C<undef>.  Since
undefined values are type objects in Raku, and it looks like C<length> is
simply returning what it was given in the undefined case, it felt appropriate
to simply return the given type object rather than C<Nil>.

=head2 $_ no longer accessible from caller's scope

In future language versions of Raku, it will become impossible to access the
C<$_> variable of the caller's scope, because it will not have been marked as
a dynamic variable.  So please consider changing:

    length;

to either:

    length($_);

or, using the subroutine as a method syntax, with the prefix C<.> shortcut
to use that scope's C<$_> as the invocant:

    .&length;

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

Source can be located at: https://github.com/lizmat/P5length . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021, 2023 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4

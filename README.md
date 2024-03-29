[![Actions Status](https://github.com/lizmat/P5length/workflows/test/badge.svg)](https://github.com/lizmat/P5length/actions)

NAME
====

Raku port of Perl's length() built-in

SYNOPSIS
========

    use P5length; # exports length()

    say length("foobar"); # 6
    say length(Str);      # Str

    $_ = "foobar";
    say length;           # 6

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `length` built-in as closely as possible in the Raku Programming Language.

ORIGINAL PERL 5 DOCUMENTATION
=============================

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

PORTING CAVEATS
===============

Characters vs codepoints
------------------------

Since the Perl documentation mentions `characters` rather than codepoints, `length` will return the number of characters, as seen using Normalization Form Grapheme (NFG).

Handling of type objects
------------------------

`length` in Perl is supposed to return `undef` when given `undef`. Since undefined values are type objects in Raku, and it looks like `length` is simply returning what it was given in the undefined case, it felt appropriate to simply return the given type object rather than `Nil`.

$_ no longer accessible from caller's scope
-------------------------------------------

In future language versions of Raku, it will become impossible to access the `$_` variable of the caller's scope, because it will not have been marked as a dynamic variable. So please consider changing:

    length;

to either:

    length($_);

or, using the subroutine as a method syntax, with the prefix `.` shortcut to use that scope's `$_` as the invocant:

    .&length;

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

Source can be located at: https://github.com/lizmat/P5length . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2020, 2021, 2023 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


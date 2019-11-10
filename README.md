NAME
====

P5length - Implement Perl's length() built-in

SYNOPSIS
========

    use P5length; # exports length()

    say length("foobar"); # 6
    say length(Str);      # Str

    $_ = "foobar";
    say length;           # 6

DESCRIPTION
===========

This module tries to mimic the behaviour of the `length` function of Perl as closely as possible.

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

Since the Perl documentation mentions `characters` rather than codepoints, `length` will return the number of characters, as seen using Normalization Form Grapheme (NFG).

`length` in Perl is supposed to return `undef` when given `undef`. Since undefined values are type objects in Raku, and it looks like `length` is simply returning what it was given in the undefined case, it felt appropriate to simply return the given type object rather than `Nil`.

AUTHOR
======

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/P5length . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018-2019 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


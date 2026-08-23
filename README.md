[![Actions Status](https://github.com/lizmat/P5length/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/P5length/actions) [![Actions Status](https://github.com/lizmat/P5length/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/P5length/actions) [![Actions Status](https://github.com/lizmat/P5length/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/P5length/actions)

NAME
====

Raku port of Perl's length() built-in

SYNOPSIS
========

```raku
use P5length; # exports length()

say length("foobar"); # 6
say length(Str);      # Str

$_ = "foobar";
say .length;           # 6
```

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

With the arrival of RakuAST, it has become impossible to access the topic variable (`$_`) of the caller's scope. So Perl's idiom of calling `length` without arguments has become impossible. Code such as:

```raku
say length;
```

should be changed to either:

```raku
say length($_);
```

or, using the subroutine as a method syntax, with the prefix `.` shortcut to use that scope's `$_` as the invocant:

```raku
say .&length;
```

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/P5length . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2020, 2021, 2023, 2026 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


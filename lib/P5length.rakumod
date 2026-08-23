use v6.d;

proto sub length(|) is export {*}
multi sub length(--> Int:D) {
    die "Calling 'length' on caller's topic variable is no longer possible,
     please use '.&length' syntax instead".naive-word-wrapper;
}
multi sub length(Any:U $type) { $type }
multi sub length(Any:D $value  --> Int:D) { $value.Str.chars }
multi sub length(Str:D $string --> Int:D) { $string.chars    }

# vim: expandtab shiftwidth=4

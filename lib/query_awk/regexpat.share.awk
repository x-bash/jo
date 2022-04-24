# a.b\\.c.d
# 'a."b.c".d.'"$1"

function selector_normalize_arr( selector, arr,     e, l, _ ){
    # print "selector:" selector
    if ( selector ~ /^\./ ) selector = "1" selector
    gsub(/\\\\/, "\002", selector)
    gsub(/\\\./, "\003", selector)
    l = split(selector, arr, /\./)
    for (j=1; j<=l; ++j) {
        e = arr[j]
        gsub("\002", "\\\\", e)
        gsub("\003", ".", e)

        # SPECIAL_LINE_BEGIN
        gsub("**", ".*", e)
        gsub("*", "[^\001]*", e)

        _ = (_ == "") ? q( e ) : _ S q( e )
        # SPECIAL_LINE_END

    }

    return _
}

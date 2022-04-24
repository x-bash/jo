# a.b\\.c.d
# 'a."b.c".d.'"$1"

function selector_normalize_arr( selector, arr,     e, l ){
    # print "selector:" selector
    if ( selector ~ /^\./ ) selector = "1" selector
    gsub(/\\\\/, "\002", selector)
    gsub(/\\\./, "\003", selector)
    l = split(selector, arr, /\./)
    for (j=1; j<=l; ++j) {
        e = arr[j]
        gsub("\002", "\\\\", e)
        gsub("\003", ".", e)
        arr[j] = q( e )    # quote
    }

    return l
}

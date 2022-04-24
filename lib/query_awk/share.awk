


function selector_arr_join( sep, arrl, arr,     i, _ ){
    if (arrl == 0)  return ""
    # "1""LICENSE"
    for (i=1; i<=arrl; ++i) _ = _ sep arr[i]
    return _
}

function selector_normalize( selector,      arrl, arr){
    arrl = selector_normalize_arr( selector, arr )
    return selector_arr_join( S, arrl, arr )
}


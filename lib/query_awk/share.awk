


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

# a."b.c".d => a.b\\.c.d
function handle_argument(argstr,       e ){
    argvl = split(argstr, argv, "\001")
    patarrl = selector_normalize_arr( argv[1], patarr )
    for (i=2; i<=argvl; ++i)    argv[ i-1 ] = selector_normalize( argv[i] );
    argvl = argvl - 1
}

INPUT==0{
    if ($0 == "---") {
        handle_argument( argstr )
        INPUT=1
        next
    }
    argstr = argstr $0
}

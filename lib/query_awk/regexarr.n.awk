INPUT==0{
    if ($0 != "---") {
        argstr = argstr $0
    } else {
        INPUT=1
        handle_argument( argstr )
        for (i=1; i<=patarrl; ++i) {
            e = patarr[ i ]
            gsub(/\*/, "[^\001]+", e)
            patarr[i] = e
        }
    }
    next
}

INPUT==1{
    if ( jiter_regexarr_parse( obj, $0, patarrl, patarr ) == false )    next
    for (i=1; i<=argvl; ++i) {
        print obj[ argv[i] ]
    }
}

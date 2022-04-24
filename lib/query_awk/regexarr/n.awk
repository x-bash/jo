INPUT==1{
    if ( jiter_regexarr_parse( obj, $0, patarrl, patarr ) == false )    next
    for (i=1; i<=argvl; ++i) {
        if (obj[ argv[i] ]!="") print obj[ argv[i] ]
    }
    delete obj
}

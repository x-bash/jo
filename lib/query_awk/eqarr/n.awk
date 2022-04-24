INPUT==1{
    if ( jiter_eqarr_parse( obj, $0, patarrl, patarr ) == false )    next
    for (i=1; i<=argvl; ++i) {
        print jstr1(obj[ argv[i] ])
    }
    exit(0)
}

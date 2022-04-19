function handle_argument(       e ){
    argvl = split(argstr, argv, "\001")

    patstr = argv[1]
    prefix_arrl = split(patstr, prefix_arr, /\./)

    for (i=2; i<=argvl; ++i) {
        e = argv[i]
        gsub("\.", S, e)
        patarr[ i-1 ] = e
    }
    patarrl = argvl - 1
}

INPUT==0{
    if ($0 == "---") {
        handle_argument( argstr )
        INPUT=1
        next
    }
    argstr = argstr $0
}

INPUT==1{
    if ( jiter_eqarr_parse( obj, $0, prefix_arrl, prefix_arr ) == false )    next
    for (i=1; i<=patarrl; ++i) {
        e = obj[ patarr[i] ]
        if (e == "") continue
        print e
    }
}

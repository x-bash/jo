function handle_argument(argstr,       e ){
    argvl = split(argstr, argv, "\001")

    patstr = argv[1]

    patarrl = split(patstr, patarr, /\./  )
    for (j=1; j<=patarrl; ++j){
        patarr[j] = q(patarr[j])
    }

    for (i=2; i<=argvl; ++i) {
        e = argv[i]
        gsub(".", S, e)
        patarr[ i-1 ] = e
    }

    # patarrl = argvl - 1
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
    jiter_eqarr_print( $0, patarrl, patarr, "", "\n")
}

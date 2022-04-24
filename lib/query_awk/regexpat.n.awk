INPUT==1{
    if ( jiter_target_rmatch( obj, $0, patarrl ) == false )    next
    for (i=1; i<=argvl; ++i) {
        print obj[ argv[i] ]
    }
}

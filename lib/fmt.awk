
# Section: fmt
function jiter_print( obj, item ){
    if (item ~ /^$/)    return
    if (item ~ /^:$/) {
        printf( "%s ", item )
        JITER_LAST_KP = item
    } else if (item ~ /^,$/) {
        printf( "%s\n", item )
    } else if (item ~ /^[tfn"0-9+-]/)  #"        # (item !~ /^[\{\}\[\]]$/)
    {
        if ( JITER_LAST_KP != "" ) {
            printf( "%s", item )
            JITER_LAST_KP = ""
        } else {
            printf( "%s%s" ,JITER_PRINT_INDENT, item )
        }
    } else if (item ~ /^[\[\{]$/) { # }
        printf("%s\n",item)
        JITER_LAST_KP = ""
        JITER_LEVEL ++
        obj[ JITER_LEVEL T_LEN T_LEN ] = JITER_PRINT_INDENT
        obj[ JITER_LEVEL ] = JITER_STATE

        JITER_PRINT_INDENT = JITER_PRINT_INDENT INDENT
        JITER_STATE = item
    } else {
        JITER_PRINT_INDENT = obj[ JITER_LEVEL T_LEN T_LEN ]
        JITER_STATE = obj[ JITER_LEVEL ]
        JITER_LEVEL --
        printf("\n%s%s", JITER_PRINT_INDENT, item)
    }
}
# EndSection

# Section: color
function jiter_print_color( obj, item ){
    if (item ~ /^$/)    return
    if (item ~ /^:$/) {
        printf( "%s ", item )
        JITER_LAST_KP = item
    } else if (item ~ /^,$/) {
        printf( "%s\n", item )
    } else if (item ~ /^[tfn"0-9+-]/)  #"        # (item !~ /^[\{\}\[\]]$/)
    {
        if ( JITER_LAST_KP != "" ) {
            printf( "%s", item )
            JITER_LAST_KP = ""
        } else {
            printf( "%s%s" ,JITER_PRINT_INDENT, item )
        }
    } else if (item ~ /^[\[\{]$/) { # }
        printf("%s\n",item)
        JITER_LAST_KP = ""
        JITER_LEVEL ++
        obj[ JITER_LEVEL T_LEN T_LEN ] = JITER_PRINT_INDENT
        obj[ JITER_LEVEL ] = JITER_STATE

        JITER_PRINT_INDENT = JITER_PRINT_INDENT INDENT
        JITER_STATE = item
    } else {
        JITER_PRINT_INDENT = obj[ JITER_LEVEL T_LEN T_LEN ]
        JITER_STATE = obj[ JITER_LEVEL ]
        JITER_LEVEL --
        printf("\n%s%s", JITER_PRINT_INDENT, item)
    }
}
# EndSection

BEGIN{
    T_LEN = "\003"
    T_DICT= "{"

    if (INDENT == "")  INDENT = "  "
    if ( int(INDENT) > 0 ) {
        INDENT = sprintf("%" int(INDENT) "s", "")
    }
}

{
    if (COLOR != "") {
        jiter_print( _, $0 )
        # jiter_print_color( _, $0 )
    } else {
        jiter_print( _, $0 )
    }
}

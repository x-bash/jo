
# Section: fmt
function jiter_print( obj, item ){
    if (item ~ /^$/)    return
    if (item ~ /^[,:]$/) {
        printf( item )
        return
    }
    if (item ~ /^[tfn"0-9+-]/)   #"        # (item !~ /^[\{\}\[\]]$/)
    {
        if ( JITER_LAST_KP != "" ) {
            if ( JITER_CURLEN == 1 )        printf( "\n%s%s: %s",   JITER_PRINT_INDENT, JITER_LAST_KP, item )
            else                            printf( ",\n%s%s: %s",  JITER_PRINT_INDENT, JITER_LAST_KP, item )
            JITER_LAST_KP = ""
        } else {
            JITER_CURLEN = JITER_CURLEN + 1
            if (JITER_STATE != T_DICT) {
                if ( JITER_CURLEN == 1 )    printf( "\n%s%s",   JITER_PRINT_INDENT, item )
                else                        printf( ",\n%s%s",  JITER_PRINT_INDENT, item )
            } else {
                JITER_LAST_KP = item
            }
        }
    } else if (item ~ /^[\[\{]$/) { # }
        printf(" %s\n", item)
        if ( JITER_STATE != T_DICT )    JITER_CURLEN = JITER_CURLEN + 1     # T_DICT len inc in key parsing

        JITER_LEVEL ++
        obj[ JITER_LEVEL T_LEN ] = JITER_CURLEN
        obj[ JITER_LEVEL T_LEN T_LEN ] = JITER_PRINT_INDENT
        obj[ JITER_LEVEL ] = JITER_STATE

        JITER_CURLEN = 0
        JITER_PRINT_INDENT = JITER_PRINT_INDENT INDENT
        JITER_STATE = item
    } else {
        JITER_CURLEN = obj[ JITER_LEVEL T_LEN ]
        JITER_PRINT_INDENT = obj[ JITER_LEVEL T_LEN T_LEN ]
        JITER_STATE = obj[ JITER_LEVEL ]
        JITER_LEVEL --
    }
}
# EndSection

# Section: color
function jiter_print_color( obj, item ){
    if (item ~ /^$/)    return
    if (item ~ /^[,:]$/) {
        printf( item )
        return
    }
    if (item ~ /^[tfn"0-9+-]/)   #"        # (item !~ /^[\{\}\[\]]$/)
    {
        if ( JITER_LAST_KP != "" ) {
            if ( JITER_CURLEN == 1 )        printf( "\n%s%s: %s",   JITER_PRINT_INDENT, JITER_LAST_KP, item )
            else                            printf( ",\n%s%s: %s",  JITER_PRINT_INDENT, JITER_LAST_KP, item )
            JITER_LAST_KP = ""
        } else {
            JITER_CURLEN = JITER_CURLEN + 1
            if (JITER_STATE != T_DICT) {
                if ( JITER_CURLEN == 1 )    printf( "\n%s%s",   JITER_PRINT_INDENT, item )
                else                        printf( ",\n%s%s",  JITER_PRINT_INDENT, item )
            } else {
                JITER_LAST_KP = item
            }
        }
    } else if (item ~ /^[\[\{]$/) {
        printf(" %s\n", item)
        if ( JITER_STATE != T_DICT )    JITER_CURLEN = JITER_CURLEN + 1     # T_DICT len inc in key parsing

        JITER_LEVEL ++
        obj[ JITER_LEVEL T_LEN ] = JITER_CURLEN
        obj[ JITER_LEVEL T_LEN T_LEN ] = JITER_PRINT_INDENT
        obj[ JITER_LEVEL ] = JITER_STATE

        JITER_CURLEN = 0
        JITER_PRINT_INDENT = JITER_PRINT_INDENT INDENT
        JITER_STATE = item
    } else {
        JITER_CURLEN = obj[ JITER_LEVEL T_LEN ]
        JITER_PRINT_INDENT = obj[ JITER_LEVEL T_LEN T_LEN ]
        JITER_STATE = obj[ JITER_LEVEL ]
        JITER_LEVEL --
    }
}
# EndSection

BEGIN{
    T_LEN = "\003"

    if (INDENT == "")  INDENT = "  "
    if ( int(INDENT) > 0 ) {
        INDENT = sprintf("%" int(INDENT) s, "")
    }
}

{
    if (COLOR != "") {
        jiter_print_color( _, $0 )
    } else {
        jiter_print( _, $0 )
    }
}

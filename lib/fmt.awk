
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
            printf( "%s%s", JITER_PRINT_INDENT, item )
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

BEGIN {
    TH_END          = "\033[0m"

    TH_RED          = "\033[31m"
    TH_YELLOW       = "\033[31m"
    TH_BLUE         = "\033[31m"

    TH_GREEN        = ""

    TH_BOLD         = "\033[1m"
    TH_DIM          = ""


    JO_TH_COLON     = ":"
    JO_TH_COMMA     = TH_DIM "," TH_END
    JO_TH_LBOX      = TH_BOLD "[" TH_END
    JO_TH_RBOX      = TH_BOLD "]" TH_END
    JO_TH_LCURLY    = TH_BOLD "{" TH_END
    JO_TH_RCURLY    = TH_BOLD "}" TH_END

    JO_TH_TRUE      = TH_BLUE "true" TH_END
    JO_TH_FALSE     = TH_RED "false" TH_END
    JO_TH_NULL      = TH_DIM "null" TH_END

    JO_TH_LNUMBER   = ""
    JO_TH_RNUMBER   = ""

    JO_TH_LSTRING   = TH_GREEN
    JO_TH_RSTRING   = TH_END
}

function jiter_print_colorize_value( value ){
    if (value == "true")        return JO_TH_TRUE
    if (value == "false")       return JO_TH_FALSe
    if (value == "null")        return JO_TH_NULL
    if (value ~ /^"/)           return JO_TH_LSTRING value JO_TH_RSTRING
    return JO_TH_LNUMBER value JO_TH_RNUMBER
}

function jiter_print_color( obj, item ){
    if (item ~ /^$/)    return
    if (item ~ /^:$/) {
        printf( "%s ",  JO_TH_COLON )
        JITER_LAST_KP = item
    } else if (item ~ /^,$/) {
        printf( "%s\n", JO_TH_COMMA )
    } else if (item ~ /^[tfn"0-9+-]/)  #"        # (item !~ /^[\{\}\[\]]$/)
    {
        if ( JITER_LAST_KP != "" ) {
            printf( "%s", jiter_print_colorize_value(item) )
            JITER_LAST_KP = ""
        } else {
            printf( "%s%s", JITER_PRINT_INDENT, jiter_print_colorize_value(item) )
        }
    } else if (item ~ /^[\[\{]$/) { # }
        if (item == "[")    printf("%s\n", JO_TH_LBOX)
        else                printf("%s\n", JO_TH_LCURLY)
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
        if (item == "]")    printf("\n%s%s", JITER_PRINT_INDENT, JO_TH_RBOX)
        else                printf("\n%s%s", JITER_PRINT_INDENT, JO_TH_RCURLY)
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
        # jiter_print( _, $0 )
        jiter_print_color( _, $0 )
    } else {
        jiter_print( _, $0 )
    }
}

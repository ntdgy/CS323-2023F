%{
    #define YYSTYPE char *
    #include "lex.yy.c"
    int yyerror(char* s);
    int ipv4Count = 0;
    int ipv6Count = 0;
    int isipV6 = 0;
%}

%token X
%token DOT
%token COLON

%%
IPv4: 
    | Part {
        $$ = $1; 
        if(ipv4Count==4) 
            printf("IPv4"); 
        else if(isipV6==1&&ipv6Count==8) 
            printf("IPv6");
        else printf("Invalid");
        }
    ;
Part: Num DOT { $$ = strcat($1, $2);ipv4Count++; }
    | Part Num {$$ = strcat($1, $2); ipv4Count++;}
    | Part Part { $$ = strcat($1, $2);}
    | Num {$$ = $1;ipv6Count++;}
    | COLON Part {yyerror("Invalid"); exit(1);}

Num: X { 
    // reject leading 0 but accept 0
     if (strlen($1) > 4) {
        yyerror("Invalid");
        exit(1); 
     }
    if (isipV6 == 1) {
        $$ = $1;
    }else if (strlen($1) > 1 && $1[0] == '0') {
        yyerror("Invalid");
        exit(1);
    // judge is satify ipv6 format
    }
    // ipv4 x must be 0-255
     else if (atoi($1) > 255) {
        yyerror("IPv4 x must be 0-255");
        exit(1);
    } else {
        $$ = $1;
    }
    }
    | X COLON {
        if (strlen($1) > 4) {
        yyerror("Invalid");
        exit(1); 
     }
        isipV6 = 1;
        $$ = $1;
        ipv6Count++;
    }
    ;
%%

int yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
    return 1;
}
int main() {
    yyparse();
}

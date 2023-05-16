%{
    #include "y.tab.h" 
    #include <stdlib.h>
    void yyerror(char*); 
%}

%%

[01]+               {   
                        yylval = strtol(yytext, NULL, 2); 
                        return INTEGER; 
                    }

[-+()=/*\n]         { return *yytext; }

[ \t]               ; 

.                   yyerror("invalid character");

%% 

int yywrap(void) {
    return 1; 
}

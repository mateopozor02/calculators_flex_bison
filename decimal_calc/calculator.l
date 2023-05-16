%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(char*); 
%}

%%

[0-9]+              {
                        yylval.ival = atoi(yytext); 
                        return INTEGER; 
                    }

[0-9]+\.[0-9]+      {
                        yylval.fval = atof(yytext);
                        return FLOAT;
                    }

[-+()/*\n]          { return *yytext; }

[ \t]               ; 

.                   yyerror("invalid character"); 

%%

int yywrap(void){
    return 1; 
}

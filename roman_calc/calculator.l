%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <string.h>
    void yyerror(char*); 
    int romanToInteger(char*); 
%}

ROMAN "M"|"CM"|"D"|"CD"|"C"|"XC"|"L"|"XL"|"X"|"IX"|"V"|"IV"|"I"

%%

{ROMAN}+            {
                        yylval = romanToInteger(yytext); 
                        return ROMAN_NUM; 
                    }  

[-+()/*\n]          { return *yytext; }

[ \t]   ; 

.                   yyerror("Invalid character"); 

%%

int romanToInteger(char* str) {
    int length = strlen(str); 
    int result = 0; 

    for (int i = 0; i < length; i++){
        switch (str[i]) {
            case 'M':
                result += 1000;
                break; 
            case 'D':
                result += 500; 
                break;
            case 'C':
                if (i + 1 < length && str[i+1] == 'M' || str[i+1] == 'D'){
                    result -= 100; 
                } else {
                    result += 100; 
                }
                break; 
            case 'L':
                result += 50; 
                break; 
            case 'X':
                if (i + 1 < length && str[i+1] == 'C' || str[i+1] == 'L'){
                    result -= 10; 
                } else {
                    result += 10; 
                }
                break; 
            case 'V':
                result += 5; 
                break; 
            case 'I':
                if (i + 1 < length && str[i+1] == 'X' || str[i+1] == 'V'){
                    result -= 1; 
                } else {
                    result += 1; 
                }
                break; 
            default:
                return -1; 
        }
    }
    return result; 
}

int yywrap(void){
    return 1; 
}
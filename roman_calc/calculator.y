%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char*); 
    int yylex(void); 
    char** intToRoman(int);
%}

%token ROMAN_NUM
%left '+' '-'
%left '*' '/' 

%%

program: 
        program expr '\n'           {
                                        printf("El resultado es: "); 
                                        char** result = intToRoman($2);  
                                        
                                        for (int i = 0; result[i] != NULL; i++){
                                            printf("%s", result[i]); 
                                        }
                                        printf("\n"); 
                                        free(result); 
                                    }
        | 
        ; 

expr: 
        ROMAN_NUM                   { $$ = $1; }
        | expr '+' expr             { $$ = $1 + $3; }
        | expr '-' expr             { $$ = $1 + $3; }
        | expr '*' expr             { $$ = $1 * $3; }
        | expr '/' expr             {
                                        if ($3 == 0){
                                            yyerror("Division by 0 is undefined."); 
                                            exit(0); 
                                        } else
                                            $$ = $1 / $3; 
                                    }
        | '(' expr ')'              { $$ = $2; }
        ; 

%%

void yyerror(char* str){
    fprintf(stderr, "%s\n", str); 
}

char** intToRoman(int number) {
    char* symbols[] = {"I", "IV", "V", "IX", "X", "XL", "L", "XC", "C", "CD",
                        "D", "CM", "M"};
    int values[] = {1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000};
    int i = 12;

    char** result = malloc(sizeof(char*) * 20); 
    int resIndex = 0;

    while (number > 0) {
        while (values[i] <= number) {
            result[resIndex] = symbols[i];
            number -= values[i];
            resIndex++;
        }
        i--;
    }
    result[resIndex] = NULL;  

    return result;
}

int main(void) {
    freopen("file.txt", "r", stdin); 
    yyparse(); 
}
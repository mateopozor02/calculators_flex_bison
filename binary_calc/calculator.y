%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char*); 
    int yylex(void); 
    void toBinary(int); 
%}

%token INTEGER
%left '+' '-'
%left '*' '/'

%%

program:
        program expr '\n'       {   
                                    printf("El resultado es: "); 
                                    toBinary($2); 
                                    printf("\n");  
                                }
        |
        ; 

expr:
        INTEGER                 { $$ = $1; }
        | expr '+' expr         { $$ = $1 + $3; }
        | expr '-' expr         { $$ = $1 - $3; }
        | expr '*' expr         { $$ = $1 * $3; }
        | expr '/' expr         {
                                    if ($3 == 0){
                                        yyerror("Division by 0 is not defined"); 
                                        exit(0); 
                                    } else 
                                        $$ = $1 / $3; 
                                }
        | '(' expr ')'          { $$ = $2; }
        ; 

%%

void yyerror(char* str){
    fprintf(stderr, "%s\n", str); 
}

int main(void){
    freopen("file.txt", "r", stdin); 
    yyparse(); 
}

void toBinary(int number){
    int binary[32]; 
    int i = 0; 

    while (number != 0){
        int digit = number % 2; 
        number = number / 2; 
        binary[i] = digit; 
        i++; 
    }

    for (int j = i - 1; j >= 0; j--){
        printf("%d", binary[j]); 
    }
}
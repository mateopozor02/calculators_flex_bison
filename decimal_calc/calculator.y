%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char*); 
    int yylex(void); 
%}

%union {
    int ival;
    float fval;
}

%token <ival> INTEGER; 
%token <fval> FLOAT; 

%type <fval> expr

%left '+' '-'
%left '*' '/'


%%

program: 
        program expr '\n'       { 
                                    printf("El resultado es: "); 
                                    printf("%f\n", $2); 
                                }
        | 
        ; 

expr: 
        INTEGER                 { $$ = $1; }
        | FLOAT                 { $$ = $1; }
        | expr '+' expr         { $$ = $1 + $3; }
        | expr '-' expr         { $$ = $1 - $3; }
        | expr '*' expr         { $$ = $1 * $3; }
        | expr '/' expr         { if ($3 == 0){
                                    yyerror("Division by zero is undefined."); 
                                    exit(0); 
                                } else
                                    $$ = $1 / $3; }
        | '(' expr ')'          { $$ = $2; }
        ; 

%%

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s); 
}

int main(void) {
    freopen("file.txt", "r", stdin); 
    yyparse(); 
}
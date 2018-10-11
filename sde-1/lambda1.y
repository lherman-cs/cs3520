%{
int yyerror(char *s);
int yylex(void);

int code;
%}

%token LAMBDA
%token LPARENS
%token RPARENS
%token DOT
%token VARIABLE
%token NUMBER
%token FUNCTION
%token UNKNOWN

%%
expression: VARIABLE {code = 0;}
    | constant {code = 1;}
    | LPARENS expression expression RPARENS {code = 2;}
    | LPARENS LAMBDA VARIABLE DOT expression RPARENS {code = 3;}
;

constant: NUMBER | FUNCTION
;
%%
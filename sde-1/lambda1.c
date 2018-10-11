#include <ctype.h>
#include <stdio.h>
#include "lambda1.tab.c"
#include "lex.yy.c"
#include "yyerror1.c"

const char *msg[] = {"variable", "constant", "combination", "abstraction"};
const char *success_msg = "Parse for syntactically correct lambda-calculus expression was successful:";
const char *failed_msg = "Sorry, Charlie: Not everybody can be a lambda expression!";

extern int code;
extern int yyparse(void);

int main(){
    if(yyparse() == 0){
        printf("\n%s\n\n", success_msg);
        printf("The overall expression is a %s\n\n", msg[code]);
    }
    else {
        printf("\n%s\n\n", failed_msg);
    }
}
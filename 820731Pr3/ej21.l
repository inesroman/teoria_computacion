 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 21.
%{
#include "y.tab.h"
int b = 10;
int num;
int suma;
int pot;
%}
%x detbase
%%
"b"[ \t]*"=" {BEGIN(detbase); return(BASE);}
<detbase>[2-9]|10 {b = atoi(yytext);}
<detbase>\n {BEGIN(INITIAL); return(EOL);}
"+"	{return(ADD);}
"-"	{return(SUB);}
"*"	{return(MUL);}
"/"	{return(DIV);}
"("	{return(OP);}
")"	{return(CP);}
[0-9]+	{yylval = atoi(yytext); return(NUMBER);}
[0-9]+b	{
    num = atoi(yytext);
    suma = 0;
    pot = 1;
    while(num != 0){
        suma = suma + (num%10)*pot;
        num = num/10;
        pot = pot*b;
    }
    yylval = suma;
    return(NUMBER);
}
\n	{return(EOL);}
<*>[ \t]	{/* ignorar espacios */}
<*>.	{return(yytext[0]); /* caracter inesperado */}
%%
 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 23.
%{
#include "y.tab.h"
int acum = 0;
%}
%%
"+"	{return(ADD);}
"-"	{return(SUB);}
"*"	{return(MUL);}
"/"	{return(DIV);}
"("	{return(OP);}
")"	{return(CP);}
[0-9]+	{yylval = atoi(yytext); return(NUMBER);}
"acum" {return(OAC);}
"acum"[ \t]*":=" {return(DAC);}
\n	{return(EOL);}
[ \t]	{/* ignorar espacios */}
.	{return(yytext[0]); /* caracter inesperado */}
%%
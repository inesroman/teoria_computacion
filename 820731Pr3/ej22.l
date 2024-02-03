 //Inés Román Gracia, NIP: 820731. Práctica 3: ejercicio 22.
%{
#include "y.tab.h"
%}
%x detbase
%x fin
%%
"b"[ \t]*"=" {BEGIN(detbase);}
<detbase>[2-9]|10 {yylval = atoi(yytext); return(BASE);}
<detbase>\n {BEGIN(INITIAL); return(EOL);}
"+"	{return(ADD);}
"-"	{return(SUB);}
"*"	{return(MUL);}
"/"	{return(DIV);}
"("	{return(OP);}
")"	{return(CP);}
[0-9]+	{yylval = atoi(yytext); return(NUMBER);}
; {BEGIN(fin);}
<fin>\n {BEGIN(INITIAL); return(EOL);}
<fin>b[ \t]*\n {BEGIN(INITIAL); return(EOLB);}
<*>[ \t]	{/* ignorar espacios */}
<*>.	{return(yytext[0]); /* caracter inesperado */}
%%

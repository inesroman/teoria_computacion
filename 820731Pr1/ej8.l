 // Inés Román Gracia 820731. Práctica 1: ejercicio 8.
VECESN	E*N
MUL6	({VECESN}{6})*E*
MUL3	({VECESN}{3})*E*

%%

I{MUL6}F	{printf("--%s--", yytext);}
I{MUL3}F	{printf("-%s-", yytext);}
I{VECESN}*E*F	{printf("*%s*", yytext);}

%%

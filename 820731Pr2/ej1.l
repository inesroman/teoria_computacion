 //Inés Román Gracia, NIP: 820731. Práctica 2: ejercicio 1.

%x comentario
%x comillas
%x simples
%%

"/*"	BEGIN(comentario);
<comentario>[^*\n]*
<comentario>"*"+[^*/\n]*
<comentario>\n
<comentario>"*"+"/" BEGIN(INITIAL);

["]	{printf("%s", yytext); BEGIN(comillas);}	
<comillas>["]	{printf("%s", yytext); BEGIN(INITIAL);}

"//" {BEGIN(simples);}
<simples>.
<simples>\n {printf("\n"); BEGIN(INITIAL);}

%%

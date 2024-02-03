 //Inés Román Gracia, NIP: 820731. Práctica 4.
%{
#include<string.h>
#include "y.tab.h"
%}

%%
[0-9]+ {yylval.nombre = strdup(yytext); return(ES);}
, {return(CM);}
"->" {return(FL);}
";"\n {return(EOL);}
\n
.
%%
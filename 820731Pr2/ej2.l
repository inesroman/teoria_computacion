 //Inés Román Gracia, NIP: 820731. Práctica 2: ejercicio 1.

%{
    int capa = 1;
    int dimension = 0;
%}

%x linea

%%

#####   {BEGIN(linea); capa = 1;}
<linea>[0-9]+ {capa = atoi(yytext)*capa;}
<linea>.
<linea>\n   {BEGIN(INITIAL); dimension += capa;}
\n
.

%%

int main() {
    int error = yylex();
    if(error == 0) {
        printf("D: %d\n", dimension);
    }
    return error;
}
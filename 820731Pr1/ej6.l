 // Inés Román Gracia 820731. Práctica 1: ejercicio 6.
%{
    int l = 0,  // número de líneas
	b = 0,  // número de líneas en blanco
	c = 0,  // número de caracteres
    d = 0,  // número de líneas que contienen algún dígito
	v = 0;	// número de líneas que empiezan por vocal
%}

%%

^[^0-9]*[0-9]			{d++; int s = strlen(yytext); c += s;}
^[aeiouAEIOU]	{v++; c++;}
^[ ]*\n				    {b++; l++;}
\n						{l++;}
.						{c++;}

%%

int main() {
    int error = yylex();
    if(error == 0) {
        printf("\nTL:%d\n", l);
        printf("TB:%d\n", b);
        printf("TC:%d\n", c);
        printf("TD:%d\n", d);
        printf("TV:%d\n", v);
    }
    return error;
}

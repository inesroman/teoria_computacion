  // Inés Román Gracia, NIP: 820731. Práctica 2: ejercicio 3.

%{
    int caracter, digito;
    int b = 0;
    int t = 0;
%}

%x dominio
%x bit
%x tinyurl

%%

<*>"#".*\n
"http://"     BEGIN(dominio);

<dominio>"bit.ly"     BEGIN(bit);
<bit>[A-Za-z0-9]* {
    caracter = 0;
    digito = 0;
    for(int i = 0; i < yyleng; i++){
        if(isalpha(yytext[i])){
            caracter++;
        }
        else if(isalnum(yytext[i])){
            digito++;
        }
    }
    if(caracter % 3 == 0 && digito % 2 != 0){
        b++;
    }
}
<bit>"http://"  BEGIN(dominio);

<dominio>"tinyurl.com"    BEGIN(tinyurl);
<tinyurl>[A-Za-z0-9]* {
    caracter = 0;
    digito = 0;
    for(int i = 0; i < yyleng; i++){
        if(isalpha(yytext[i])){
            caracter++;
        }
        else if(isalnum(yytext[i])){
            digito++;
        }
    }
    if(caracter % 3 != 0 && digito % 2 == 0){
        t++;
    }
}
<tinyurl>"http://"  BEGIN(dominio);

<*>.
<*>\n

%%

int main() {
    int error = yylex();
    if(error == 0) {
        printf("TB: %d\n", b);
        printf("TT: %d\n", t);
    }
    return error;
}
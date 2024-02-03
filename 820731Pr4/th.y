 //Inés Román Gracia, NIP: 820731. Práctica 4.
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define PALOS 3
#define DIM 27 //DIMENSION DE LA MATRIZ DE ADYACENCIA
#define BUFF 4000

//Variables auxiliares usadas como índices para obtener la matriz de adyaciencia:
int vi = 0;
int vj = 0;
char* ei;
char* ej;

//tabla de adyacencia
char* tablaTr[DIM][DIM];

//inicializa una tabla cuadrada DIM x DIM con la cadena vacia
void iniTabla(char* tabla[DIM][DIM]) {
	for (int i = 0; i < DIM; i++) {
		for (int j = 0; j < DIM; j++) {
			tabla[i][j] = "";
		}
	}
}

/*
 * Calcula la multiplicacion simbolica de matrices 
 * cuadradas DIM x DIM: res = t1*t2
 *
 * CUIDADO: res DEBE SER UNA TABLA DISTINTA A t1 y t2
 * Por ejemplo, NO SE DEBE USAR en la forma:
 *           multiplicar(pot, t, pot); //mal
 */
void multiplicar(char* t1[DIM][DIM], char* t2[DIM][DIM], char* res[DIM][DIM]) {
	for (int i = 0; i < DIM; i++) {
		for (int j = 0; j < DIM; j++) {
			res[i][j] = (char*) calloc(BUFF, sizeof(char));
			for (int k = 0; k < DIM; k++) {
				if (strcmp(t1[i][k],"")!=0 && strcmp(t2[k][j],"") != 0) {
					strcat(strcat(res[i][j],t1[i][k]),"-");
					strcat(res[i][j],t2[k][j]);
				}
			}
		}
	}
}


/* 
 *Copia la tabla orig en la tabla copia
*/
void copiar(char* orig[DIM][DIM], char* copia[DIM][DIM]) {
	for (int i = 0; i < DIM; i++) {
		for (int j = 0; j < DIM; j++) {
			copia[i][j] = strdup(orig[i][j]);
		}
	}
}

//Funcion que traduce los estados del automata a un numero entero
//en base 10 para utilizar en la obtencion de la matriz de adyacencia
int indice(char* s){
	return strtol(s, NULL, 3);
}

%}

  //nuevo tipo de dato para yylval
%union{
	char* nombre;
}

%token ES CM FL EOL //PONER TODOS LOS TOKENS DE LA GRAMATICA, POR EJEMPLO, ID
%start	inicio		//variable inicial 

%type<nombre> ES	//lista de tokens y variables que su valor semantico,
                    //recogido mediante yylval, es 'nombre' (ver union anterior).
					//Para estos tokens, yylval será de tipo char* en lugar de int.

%%
inicio: S 
	;
S: /* nada */
	| A EOL S
	;
A: ES CM ES FL ES{
		ei = $1;
		vi = strtol(ei, NULL, 3);
		ej = $5;
		vj = strtol(ej, NULL, 3);
		tablaTr[vi][vj] = $3;
	}
	;
%%

int yyerror(char* s){
	printf("%s\n");
	return -1;
}

int main() {

	//inicializar tabla de adyacencia
	iniTabla(tablaTr);

	//nodo inicial
	char* estadoIni = "000";
	
	//indice inicial
	int indIni = strtol(estadoIni, NULL, 3);

	//nodo final
	char* estadoFin = "111";

	//indice final
	int indFin = strtol(estadoFin, NULL, 3);

	int error = yyparse();

	if (error == 0) {
		//matriz para guardar la potencia
		char* pot[DIM][DIM];
		copiar(tablaTr,pot);
		//calcular movimientos de estadoIni a estadoFin
		//calculando las potencias sucesivas de tablaTr
		char* res[DIM][DIM];
		copiar(tablaTr,res);
		while(strcmp(res[indIni][indFin], "") == 0){
			multiplicar(tablaTr, pot, res);
			copiar(res,pot);
		}
		printf("Nodo inicial  : %s\n", estadoIni);
		printf("Movimientos   : %s\n", res[indIni][indFin]);
		printf("Nodo final    : %s\n", estadoFin);
	}

	return error;
}

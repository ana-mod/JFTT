%{
# include <stdio.h>
int yywrap();
int yylex();
int NL=0;
int NW=0;
%}
%%
#.*(\\\n)*.*\n		; //usuwa komentarze z łamaczem linii
^[[:blank:]]+		; //usuwa spacje z poczatku
[ \t]+			{printf(" "); NW++;} //zamienia tabulacje na pojedyncza spacje, powtorzenia spacji 						na pojedyncza spacje, konkatenacje tych dwoch na pojedyncza spacje
[[:blank:]]+$		; //usuwa spacje z konca
[\n]{2,}			printf("\n");
\n			{printf("\n"); NL++;}
%%
int yywrap () {
	printf ("---\n\%d\n",NL);
	printf ("---\n\%d\n",NW+NL);
	return 1;
}
int main() {
	return yylex ();
}

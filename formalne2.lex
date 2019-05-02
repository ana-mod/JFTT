//usuwa komentarze z kodu html
%{
# include <stdio.h>
int yylex();
int comment=0;
%}
%%
"<!--"		{comment=1;}
.		if(comment){;} else {printf("%s", yytext);}
"-->"		{if(comment) {comment=0;} else printf("-->");}	
%%
int main(){
return yylex();
}

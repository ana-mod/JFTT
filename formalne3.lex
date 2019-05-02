//kalkulator
%{
#include<math.h>

int stack[100];
int last=-1;

int isEmpty() 
{
	if(last==-1) return 1;
	else return 0;
}

int isFull()
{
	if(last==99) return 1;
	else return 0;
}

int push(int value)
{
	if(!isFull()) 
	{
		last++;
		stack[last]=value;
		return 1;	
	}
	else return 0;
}

int pop()
{
	if(!isEmpty())
	{
		return stack[last--];
	}
	else return -1;
}

int err = 0;
int op = 0; //operators number
int no = 0; //operand number

int reset()
{
	last=-1;
	op=0;
	no=0;
}


%}

%%
-?[1-9]+[0-9]*|0			{push(atoi(yytext)); no++;}
"+"					{push(pop()+pop()); op++;}
"-"					{int num=pop(); push(pop()-num); op++;}
"/"					{int num=pop(); if(num==0) {printf("nie można przez 0"); err=1; reset();} else push(pop()/num); op++;}
"*"					{push(pop()*pop()); op++;}
"%"					{int num=pop(); if(num==0) {printf("nie można przez 0"); err=1; reset();} else push(pop()%num); op++;}
"^"					{push(pow(pop(),pop())); op++;}
\n					{if(err == 1) {printf("\n");}
					else if(op < no - 1) {printf("za mało operatorów\n");} 
					else if(no <= op) {printf("za mało argumentów\n");} 
					else if(err == 0) {printf("= %d\n", pop());} err=0; reset();}
[[:blank:]]				;
.					{printf("%s? Don't know her", yytext); err = 1;}
%%

int main(){
return yylex();
}

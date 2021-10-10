%{
#include <stdio.h>
#include <math.h>
%}

%token NUMBER
%token ADD SUB MUL DIV 
%token MOD 
%token POW FAC 
%token FRONT BACK
%token COMMA
%token FLCM BLCM FGCD BGCD
%token ABS
%token EOL

%%

calclist:/*註解*/
  |calclist exp EOL{printf ("=%d\n",$2);}
  ;
  
exp:factor {$$ = $1;}
  |exp ADD factor{$$=$1+$3;}
  |exp SUB factor{$$=$1-$3;}
  ;

factor:term {$$=$1;}
  |factor MUL term{$$=$1*$3;}
  |factor DIV term{$$=$1/$3;}
  |factor MOD term{$$=$1%$3;}
  |FGCD NUMBER COMMA NUMBER BGCD{$$=gcd($2, $4);}
  |FLCM NUMBER COMMA NUMBER BLCM{$$=lcm($2, $4);}
  ;

term:power {$$=$1;}
  |term POW power{$$=pow($1, $3);}
  ;

power:factorial {$$=$1;}
  |NUMBER FAC{$$=fac($1);}
//  |FGCD NUMBER BACK FAC{$$=fac($2);}
  ;

factorial:paren {$$=$1;}
  |FRONT exp BACK{$$=$2;}
  |FRONT SUB exp BACK{$$=-$3;}
  ;

paren:NUMBER {$$=$1;}
  |ABS factorial {$$=$2>=0?$2:-$2;}
  ;
%%

fac(int num)
{
  int i;
  int factorialSum = 1;
  for(i = 1; i <= num; i++)
    factorialSum *= i;
  return factorialSum;
}

int gcd(int numB, int numS)
{
  int temp = numB;
  numB = (numB  > numS) ? numB : numS;
  numS = (numB == numS) ? temp : numS;

  int remainder;
  while(numS != 0)
  {
    remainder = numB % numS;
    numB = numS;
    numS = remainder;
  }
  return numB;
}

int lcm(int numB, int numS)
{
  return (numB * numS / gcd(numB, numS));
}

main(int argc,char **argv){
	yyparse();
}

yyerror(char *s)
{
 fprintf(stderr,"error:%s\n",s);
}

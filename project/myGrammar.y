%{
#include <stdio.h>
#include <math.h>
%}

%token NUMBER
%token ADD SUB MUL DIV ABS POW MOD FAC
%token FRONT BACK FLCM BLCM FGCD BGCD
%token COMMA EOL

%%

calclist:/**/
    | calclist exp EOL {printf("= %d\n", $2);}
    ;

exp:factor {$$=$1;}
    |exp ADD factor{$$=$1+$3;}
    |exp SUB factor{$$=$1-$3;}
    ;

factor:term {$$=$1;}
    |factor MUL term{$$=$1*$3;}
    |factor DIV term{$$=$1/$3;}
    |factor MOD term{$$=$1%$3;}
    ;

term:power {$$=$1;}
    |term POW power{$$=pow($1,$3);}
    ;

power:fact {$$=$1;}
    |NUMBER FAC {$$=factorial($2);}
    ;

fact:paren {$$=$1;}
    |FRONT exp BACK{$$=$2;}
    |FRONT SUB NUMBER BACK {$$=-$3;}
    |FGCD NUMBER COMMA NUMBER BGCD {$$=gcd($2, $4);}
    |FLCM NUMBER COMMA NUMBER BLCM {$$=lcm($2, $4);}
    ;

paren:NUMBER {$$=$1;}
    |ABS power {$$=$2>=0?$2:-$2;}
    ;
%%

int factorial(int num)
{
    int i, factorialSum = 1;
    for(i = 1; i <= num; i++)
        factorialSum *= i;
    return factorialSum;
}

int gcd(int numB, int numS)
{
    int remainder;
    if (numB < numS)
    {
        int temp = numB;
        numB = numS;
        numS = temp;
    }
    while(numS != 0)
    {
        remainder = numB % numS;
        numB = numS;
        numS = remainder;
    }
    return numB;
}

int lcm(int a, int b)
{
    return (a * b / gcd(a, b));
}

int main(int argc, char **argv)
{
    yyparse();
}

int yyerror(char *s)
{
    fprintf(stderr, "error:%s\n", s);
}
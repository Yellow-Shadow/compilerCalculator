%{
#include "finalGrammar.tab.h"
%}

%%

"+"   	{return ADD;}
"-"   	{return SUB;}
"*"   	{return MUL;}
"/"   	{return DIV;}
"|"   	{return ABS;}

"%"	    {return MOD;}
"^"     {return POW;}
"!"     {return FAC;}

"("     {return FRONT;}
")"     {return BACK;}

","     {return COMMA;}

"["     {return FLCM;}
"]"     {return BLCM;}

"{"     {return FGCD;}
"}"     {return BGCD;}

[0-9]+ 	{yylval=atoi(yytext);return NUMBER;}
\n  	{return EOL;}
[ \t] 	{/*空白忽略*/}
. 	{printf("非法字符 %c\n",*yytext);}

%%
/* CS 155 Flex Demo     */
/* 23-Feb-2022 spfestin */
/* Note: This is for class demo purposes only */

%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
int lineno = 1;
void ret_print(char *token_type);
void yyerror();
%}

RESERVED "PROCEDURE"|"VAR"|"INTEGER"|"REAL"|"BOOLEAN"|"STRINGN"|"WRITELN"|"NOT"|"OR"|"DIV"|"MOD"|"AND"|"IF"|"THEN"|"ELSE"|"WHILE"|"DO"|"FOR"|"TO"|"DOWNTO"|":="|"BEGIN"|"END"
IDENT	    [a-zA-Z][a-zA-Z0-9]*
NUMBER	  [0-9]+|[0-9]+"."[0-9]+ 
PLUS     "+"
MINUS "\-"
TIMES "*"
DIVIDE   "/"
EQUAL "\="
LESS_THAN_GREATER_THAN  "<>"
LESS_THAN   "<"
LESS_THAN_EQUAL   "<="
GREATER_THAN   ">"
GREATER_THAN_EQUAL   ">="
COMMA ","
SEMICOLON   ";"
COLON "\:"
OPEN_PARENTHESIS  "\("
CLOSE_PARENTHESIS "\)"
QUOTATION_MARK "\""
STRING   {QUOTATION_MARK}.*{QUOTATION_MARK}


%%

{RESERVED}	   { ret_print("RESERVED"); }
{IDENT}	       { ret_print("IDENT");}
{NUMBER}	       { ret_print("NUMBER");}
{PLUS} 	       { ret_print("PLUS"); }
{MINUS} 	       { ret_print("MINUS"); }
{TIMES}	         { ret_print("TIMES"); }
{DIVIDE}	         { ret_print("DIVIDE"); }
{EQUAL}	         { ret_print("EQUAL"); }
{LESS_THAN_GREATER_THAN}	         { ret_print("LESS_THAN_GREATER_THAN"); }
{LESS_THAN}	         { ret_print("LESS_THAN"); }
{LESS_THAN_EQUAL}	         { ret_print("LESS_THAN_EQUAL"); }
{GREATER_THAN}	         { ret_print("GREATER_THAN"); }
{GREATER_THAN_EQUAL}	         { ret_print("GREATER_THAN_EQUAL"); }
{COMMA}	         { ret_print("COMMA"); }
{SEMICOLON}	         { ret_print("SEMICOLON"); }
{COLON}	         { ret_print("COLON"); }
{OPEN_PARENTHESIS}	         { ret_print("OPEN_PARENTHESIS"); }
{CLOSE_PARENTHESIS}         { ret_print("CLOSE_PARENTHESIS"); }
{STRING}	         { ret_print("STRING"); }
{QUOTATION_MARK}  { ret_print("QUOTATION_MARK"); }

"\n"         { lineno++;}
[ \t\r\f]+	 /* eat up whitespace */
.	           { yyerror("Unrecognized character");}
%%

void ret_print(char *token_type){
   printf("L%d: [%s, %s]\n", lineno, token_type, yytext);
}

void yyerror(char *message){
   printf("L%d: lexical error %s\n", lineno, yytext);
   exit(1);
}

int main(int argc, char *argv[]){
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
   return 0;
}

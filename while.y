%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include "sym_table.h"

	void printSymTable(void) ;
	void set_type(int);
	void add_id(int);
	void check_type(int s_id, int i_id);
	int l=0;
	// label generating function
	int label()
	{	
		l++;
		return l;	
	}
	
	extern sym_table table[];
	
%}
//CAB- close angle bracket
//OAB - open angle brscket
//CBO-curly bracket open
//CBC-curly bracket close
//SBC-simple bracket open
//SBO-simple bracket close
//RP-relational operator
//HINCLUDE-hash include
//LIBNAME-library name
//INCOP-increment operator
//DICOP-dicrement operator
//NEQ-Not equalto
//error-verbose function is used to enable debugging for yacc

%token HINCLUDE LIBNAME SEMI CBO CBC SBO SBC COMMA INT MAIN EQ  AMP WHILE INCOP PLUS DECOP LE LEQ  GE GEQ NEQ DEQ MINUS CHAR DOUBLE FLOAT PRINTF SCANF

%union
{
	int index;
	int typeval;
	char code[1000];
}


%token<index> STRING
%token<index> ID
%token<index> NUM
%type<typeval> type


%error-verbose
%{
    void yyerror(const char *);
    int yylex(void);
    int sym[26];
    extern FILE *yyin;
    
%}

%%
start: header  main ;
 	
header: HINCLUDE LE LIBNAME GE ;

main: INT MAIN SBO SBC CBO body CBC {printf("Intermediate code:\n%scall __exit\n\n", $<code>6);};

body: stmt  body {strcpy($<code>$, $<code>1); strcat($<code>$, $<code>2);}
     | {$<code>$[0] = '\0';};
   
stmt: decl SEMI {strcpy($<code>$, $<code>1);}
	| assgn SEMI  {strcpy($<code>$, $<code>1);}
	| ctrlstmt  {strcpy($<code>$, $<code>1);}
	| pstmt SEMI {strcpy($<code>$, $<code>1);}
	| sstmt SEMI {strcpy($<code>$, $<code>1);}
 ;

pstmt: PRINTF SBO STRING COMMA ID SBC {check_type($3, $5); sprintf($<code>$, "call __printf, %s\n", table[$5].value);};

sstmt: SCANF SBO STRING COMMA  AMP ID SBC {check_type($3,$6); sprintf($<code>$, "call __scanf, %s\n", table[$6].value);};

decl : type names {set_type($1); strcpy($<code>$, $<code>2);};

type : INT {$$=0;} | FLOAT {$$=1;} | DOUBLE {$$=2;} | CHAR {$$=3;};

names : name COMMA names  {strcpy ($<code>$, $<code>1); strcat($<code>$, $<code>3);}
	| name  {strcpy($<code>$, $<code>1);};

name : ID  {add_id($1); $<code>$[0] = '\0';} | 
	ID EQ NUM {
			add_id($1);
			sprintf($<code>$, "mov @%s, %s\n", table[$1].value, table[$3].value);
		  };

assgn : ID EQ NUM { sprintf($<code>$, "mov @%s, #%s\n", table[$1].value, table[$3].value);}
	| ID EQ ID { sprintf($<code>$, "mov @%s, @%s\n", table[$1].value, table[$3].value);}
	| ID INCOP { sprintf($<code>$, "add @%s, @%s, #1\n", table[$1].value, table[$1].value);}
	|ID DECOP { sprintf($<code>$, "sub @%s, @%s, #1\n", table[$1].value, table[$1].value);};

ctrlstmt : WHILE SBO relstmt SBC CBO body CBC 
		{
			int begin=label();
			int end=label();
			sprintf($<code>$, "l%d:\n%s l%d\n%s\nb l%d\nl%d:\n", begin, $<code>3, end, $<code>6, begin, end);
			
		}
 	|
 	WHILE SBO relstmt SBC stmt 
		{
			int begin=label();
			int end=label();
			sprintf($<code>$, "l%d:\n%s l%d\n%s\nb l%d\nl%d:\n", begin, $<code>3, end, $<code>5, begin, end);
			
		};
	
relstmt: ID relop ID {sprintf($<code>$, "cmp @%s, @%s\n%s", table[$1].value, table[$3].value, $<code>2);}
	| ID relop NUM  {sprintf($<code>$, "cmp @%s, #%s\n%s", table[$1].value, table[$3].value, $<code>2);};

relop : LE    {sprintf($<code>$, "b.ge ");}
	|LEQ  {sprintf($<code>$, "b.geq ");}
	|GE   {sprintf($<code>$, "b.le ");}
	|GEQ  {sprintf($<code>$, "b.leq ");}
	|NEQ  {sprintf($<code>$, "b.eq ");}
	|DEQ  {sprintf($<code>$, "b.ne ");};
	
%%



void yyerror(const char *s) 
{
    printf("error:%s\n", s);
    exit(-1);
}

int iDs[1024];
int iDIndex=0;

void add_id(int id)
{
	iDs[iDIndex] = id;
	iDIndex++;
}


void set_type(int type)
{
	//printf("setting type:%d\n", type);
	int i;
	
	for (i=0; i < iDIndex; i++) {
		table[iDs[i]].type = type;
	}
	iDIndex=0;
}

void check_type(int s_id, int i_id)
{
	//printf("%d %d\n", s_id, i_id);
	if ((table[i_id].type == 0) &&
		(strcmp("\"%d\"", table[s_id].value) != 0)) {
		printf("expecting %%d but got %s at line %d\n", table[s_id].value, table[s_id].line_number);
		exit(-1);
	}
	if ((table[i_id].type == 1) &&
		(strcmp("\"%f\"", table[s_id].value) != 0)) {
		printf("expecting %%f but got %s at line %d\n", table[s_id].value, table[s_id].line_number);
		exit(-1);
	}
	if ((table[i_id].type == 2) &&
		(strcmp("\"%e\"", table[s_id].value) != 0)) {
		printf("expecting %%e but got %s at line %d\n", table[s_id].value, table[s_id].line_number);
		exit(-1);
	}
	if ((table[i_id].type == 3) &&
		(strcmp("\"%s\"", table[s_id].value) != 0)) {
		printf("expecting %%s but got %s at line %d\n", table[s_id].value, table[s_id].line_number);
		exit(-1);
	}
}



int main(void)
 {
 	
	yyin=fopen("input1.c","r");
	yyparse();
	fclose(yyin);
	printf("Symbol table:\n");
	printSymTable();
	printf("Successfully parsed the given program\n");
	return 0;
}


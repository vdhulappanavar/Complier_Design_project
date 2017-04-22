lex while.l
yacc -d while.y
gcc lex.yy.c y.tab.c -ll -ly -g

rm parser.tab.c
bison parser.y
flex scanner.lex
g++ lex.yy.c -ll

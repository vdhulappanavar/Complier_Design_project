/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    HINCLUDE = 258,
    LIBNAME = 259,
    SEMI = 260,
    CBO = 261,
    CBC = 262,
    SBO = 263,
    SBC = 264,
    COMMA = 265,
    INT = 266,
    MAIN = 267,
    EQ = 268,
    AMP = 269,
    WHILE = 270,
    INCOP = 271,
    PLUS = 272,
    DECOP = 273,
    LE = 274,
    LEQ = 275,
    GE = 276,
    GEQ = 277,
    NEQ = 278,
    DEQ = 279,
    MINUS = 280,
    CHAR = 281,
    DOUBLE = 282,
    FLOAT = 283,
    PRINTF = 284,
    SCANF = 285,
    STRING = 286,
    ID = 287,
    NUM = 288
  };
#endif
/* Tokens.  */
#define HINCLUDE 258
#define LIBNAME 259
#define SEMI 260
#define CBO 261
#define CBC 262
#define SBO 263
#define SBC 264
#define COMMA 265
#define INT 266
#define MAIN 267
#define EQ 268
#define AMP 269
#define WHILE 270
#define INCOP 271
#define PLUS 272
#define DECOP 273
#define LE 274
#define LEQ 275
#define GE 276
#define GEQ 277
#define NEQ 278
#define DEQ 279
#define MINUS 280
#define CHAR 281
#define DOUBLE 282
#define FLOAT 283
#define PRINTF 284
#define SCANF 285
#define STRING 286
#define ID 287
#define NUM 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 39 "while.y" /* yacc.c:1909  */

	int index;
	int typeval;
	char code[1000];

#line 126 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

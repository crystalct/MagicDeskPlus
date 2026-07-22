/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "mon_parse.y"

/* -*- C -*-
 *
 * mon_parse.y - Parser for the VICE built-in monitor.
 *
 * Written by
 *  Daniel Sladic <sladic@eecg.toronto.edu>
 *  Andreas Boose <viceteam@t-online.de>
 *  Thomas Giesel <skoe@directbox.com>
 *
 * This file is part of VICE, the Versatile Commodore Emulator.
 * See README for copyright notice.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 *  02111-1307  USA.
 *
 */

#include "vice.h"

#ifdef __GNUC__
#undef alloca
#define        alloca(n)       __builtin_alloca (n)
#else /* not __GNUC__ */
#ifdef HAVE_ALLOCA_H
#include <alloca.h>
#else  /* Not HAVE_ALLOCA_H  */
char *alloca();
#endif /* HAVE_ALLOCA_H.  */
#endif /* __GNUC__ */

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "asm.h"
#include "console.h"
#include "drive.h"
#include "interrupt.h"
#include "lib.h"
#include "machine.h"
#include "mon_breakpoint.h"
#include "mon_command.h"
#include "mon_disassemble.h"
#include "mon_drive.h"
#include "mon_file.h"
#include "mon_memmap.h"
#include "mon_memory.h"
#include "mon_register.h"
#include "mon_util.h"
#include "montypes.h"
#include "tapeport.h"
#include "resources.h"
#include "types.h"
#include "uimon.h"
#include "vsync.h"
#include "mon_profile.h"

#define join_ints(x,y) (LO16_TO_HI16(x)|y)
#define separate_int1(x) (HI16_TO_LO16(x))
#define separate_int2(x) (LO16(x))

static int yyerror(char *s);
static int temp;
static int resolve_datatype(unsigned guess_type, const char *num);
static int resolve_range(enum t_memspace memspace, MON_ADDR range[2],
                         const char *num);

/* Defined in the lexer */
extern int new_cmd, opt_asm;
extern int cur_len, last_len;

void free_buffer(void);
void make_buffer(char *str);
int yylex(void);

void set_yydebug(int val);

#define ERR_ILLEGAL_INPUT 1     /* Generic error as returned by yacc.  */
#define ERR_RANGE_BAD_START 2
#define ERR_RANGE_BAD_END 3
#define ERR_BAD_CMD 4
#define ERR_EXPECT_CHECKNUM 5
#define ERR_EXPECT_END_CMD 6
#define ERR_MISSING_CLOSE_PAREN 7
#define ERR_INCOMPLETE_COND_OP 8
#define ERR_EXPECT_FILENAME 9
#define ERR_ADDR_TOO_BIG 10
#define ERR_IMM_TOO_BIG 11
#define ERR_EXPECT_STRING 12
#define ERR_UNDEFINED_LABEL 13
#define ERR_EXPECT_DEVICE_NUM 14
#define ERR_EXPECT_ADDRESS 15
#define ERR_INVALID_REGISTER 16

#define BAD_ADDR (new_addr(e_invalid_space, 0))
#define CHECK_ADDR(x) ((x) == addr_mask(x))

/* set to YYDEBUG 1 to get parser debugging via "yydebug" command, requires to
   set_yydebug(1) in monitor.c:monitor_init */
#ifdef DEBUG
#define YYDEBUG 1
#else
#define YYDEBUG 0
#endif


#line 193 "mon_parse.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_MON_PARSE_H_INCLUDED
# define YY_YY_MON_PARSE_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    H_NUMBER = 258,                /* H_NUMBER  */
    D_NUMBER = 259,                /* D_NUMBER  */
    O_NUMBER = 260,                /* O_NUMBER  */
    B_NUMBER = 261,                /* B_NUMBER  */
    CONVERT_OP = 262,              /* CONVERT_OP  */
    B_DATA = 263,                  /* B_DATA  */
    H_RANGE_GUESS = 264,           /* H_RANGE_GUESS  */
    D_NUMBER_GUESS = 265,          /* D_NUMBER_GUESS  */
    O_NUMBER_GUESS = 266,          /* O_NUMBER_GUESS  */
    B_NUMBER_GUESS = 267,          /* B_NUMBER_GUESS  */
    BAD_CMD = 268,                 /* BAD_CMD  */
    MEM_OP = 269,                  /* MEM_OP  */
    IF = 270,                      /* IF  */
    MEM_COMP = 271,                /* MEM_COMP  */
    MEM_DISK8 = 272,               /* MEM_DISK8  */
    MEM_DISK9 = 273,               /* MEM_DISK9  */
    MEM_DISK10 = 274,              /* MEM_DISK10  */
    MEM_DISK11 = 275,              /* MEM_DISK11  */
    EQUALS = 276,                  /* EQUALS  */
    TRAIL = 277,                   /* TRAIL  */
    CMD_SEP = 278,                 /* CMD_SEP  */
    LABEL_ASGN_COMMENT = 279,      /* LABEL_ASGN_COMMENT  */
    CMD_LOG = 280,                 /* CMD_LOG  */
    CMD_LOGNAME = 281,             /* CMD_LOGNAME  */
    CMD_SIDEFX = 282,              /* CMD_SIDEFX  */
    CMD_DUMMY = 283,               /* CMD_DUMMY  */
    CMD_RETURN = 284,              /* CMD_RETURN  */
    CMD_BLOCK_READ = 285,          /* CMD_BLOCK_READ  */
    CMD_BLOCK_WRITE = 286,         /* CMD_BLOCK_WRITE  */
    CMD_UP = 287,                  /* CMD_UP  */
    CMD_DOWN = 288,                /* CMD_DOWN  */
    CMD_LOAD = 289,                /* CMD_LOAD  */
    CMD_BASICLOAD = 290,           /* CMD_BASICLOAD  */
    CMD_SAVE = 291,                /* CMD_SAVE  */
    CMD_VERIFY = 292,              /* CMD_VERIFY  */
    CMD_BVERIFY = 293,             /* CMD_BVERIFY  */
    CMD_IGNORE = 294,              /* CMD_IGNORE  */
    CMD_HUNT = 295,                /* CMD_HUNT  */
    CMD_FILL = 296,                /* CMD_FILL  */
    CMD_MOVE = 297,                /* CMD_MOVE  */
    CMD_GOTO = 298,                /* CMD_GOTO  */
    CMD_REGISTERS = 299,           /* CMD_REGISTERS  */
    CMD_READSPACE = 300,           /* CMD_READSPACE  */
    CMD_WRITESPACE = 301,          /* CMD_WRITESPACE  */
    CMD_RADIX = 302,               /* CMD_RADIX  */
    CMD_MEM_DISPLAY = 303,         /* CMD_MEM_DISPLAY  */
    CMD_BREAK = 304,               /* CMD_BREAK  */
    CMD_TRACE = 305,               /* CMD_TRACE  */
    CMD_IO = 306,                  /* CMD_IO  */
    CMD_BRMON = 307,               /* CMD_BRMON  */
    CMD_COMPARE = 308,             /* CMD_COMPARE  */
    CMD_DUMP = 309,                /* CMD_DUMP  */
    CMD_UNDUMP = 310,              /* CMD_UNDUMP  */
    CMD_EXIT = 311,                /* CMD_EXIT  */
    CMD_DELETE = 312,              /* CMD_DELETE  */
    CMD_CONDITION = 313,           /* CMD_CONDITION  */
    CMD_COMMAND = 314,             /* CMD_COMMAND  */
    CMD_ASSEMBLE = 315,            /* CMD_ASSEMBLE  */
    CMD_DISASSEMBLE = 316,         /* CMD_DISASSEMBLE  */
    CMD_NEXT = 317,                /* CMD_NEXT  */
    CMD_STEP = 318,                /* CMD_STEP  */
    CMD_PRINT = 319,               /* CMD_PRINT  */
    CMD_DEVICE = 320,              /* CMD_DEVICE  */
    CMD_HELP = 321,                /* CMD_HELP  */
    CMD_WATCH = 322,               /* CMD_WATCH  */
    CMD_DISK = 323,                /* CMD_DISK  */
    CMD_QUIT = 324,                /* CMD_QUIT  */
    CMD_CHDIR = 325,               /* CMD_CHDIR  */
    CMD_BANK = 326,                /* CMD_BANK  */
    CMD_LOAD_LABELS = 327,         /* CMD_LOAD_LABELS  */
    CMD_SAVE_LABELS = 328,         /* CMD_SAVE_LABELS  */
    CMD_ADD_LABEL = 329,           /* CMD_ADD_LABEL  */
    CMD_DEL_LABEL = 330,           /* CMD_DEL_LABEL  */
    CMD_SHOW_LABELS = 331,         /* CMD_SHOW_LABELS  */
    CMD_CLEAR_LABELS = 332,        /* CMD_CLEAR_LABELS  */
    CMD_RECORD = 333,              /* CMD_RECORD  */
    CMD_MON_STOP = 334,            /* CMD_MON_STOP  */
    CMD_PLAYBACK = 335,            /* CMD_PLAYBACK  */
    CMD_CHAR_DISPLAY = 336,        /* CMD_CHAR_DISPLAY  */
    CMD_SPRITE_DISPLAY = 337,      /* CMD_SPRITE_DISPLAY  */
    CMD_TEXT_DISPLAY = 338,        /* CMD_TEXT_DISPLAY  */
    CMD_SCREENCODE_DISPLAY = 339,  /* CMD_SCREENCODE_DISPLAY  */
    CMD_ENTER_DATA = 340,          /* CMD_ENTER_DATA  */
    CMD_ENTER_BIN_DATA = 341,      /* CMD_ENTER_BIN_DATA  */
    CMD_KEYBUF = 342,              /* CMD_KEYBUF  */
    CMD_BLOAD = 343,               /* CMD_BLOAD  */
    CMD_BSAVE = 344,               /* CMD_BSAVE  */
    CMD_SCREEN = 345,              /* CMD_SCREEN  */
    CMD_UNTIL = 346,               /* CMD_UNTIL  */
    CMD_CPU = 347,                 /* CMD_CPU  */
    CMD_YYDEBUG = 348,             /* CMD_YYDEBUG  */
    CMD_BACKTRACE = 349,           /* CMD_BACKTRACE  */
    CMD_SCREENSHOT = 350,          /* CMD_SCREENSHOT  */
    CMD_PWD = 351,                 /* CMD_PWD  */
    CMD_DIR = 352,                 /* CMD_DIR  */
    CMD_MKDIR = 353,               /* CMD_MKDIR  */
    CMD_RMDIR = 354,               /* CMD_RMDIR  */
    CMD_RESOURCE_GET = 355,        /* CMD_RESOURCE_GET  */
    CMD_RESOURCE_SET = 356,        /* CMD_RESOURCE_SET  */
    CMD_LOAD_RESOURCES = 357,      /* CMD_LOAD_RESOURCES  */
    CMD_SAVE_RESOURCES = 358,      /* CMD_SAVE_RESOURCES  */
    CMD_ATTACH = 359,              /* CMD_ATTACH  */
    CMD_DETACH = 360,              /* CMD_DETACH  */
    CMD_MON_RESET = 361,           /* CMD_MON_RESET  */
    CMD_TAPECTRL = 362,            /* CMD_TAPECTRL  */
    CMD_TAPEOFFS = 363,            /* CMD_TAPEOFFS  */
    CMD_CARTFREEZE = 364,          /* CMD_CARTFREEZE  */
    CMD_UPDB = 365,                /* CMD_UPDB  */
    CMD_JPDB = 366,                /* CMD_JPDB  */
    CMD_CPUHISTORY = 367,          /* CMD_CPUHISTORY  */
    CMD_MEMMAPZAP = 368,           /* CMD_MEMMAPZAP  */
    CMD_MEMMAPSHOW = 369,          /* CMD_MEMMAPSHOW  */
    CMD_MEMMAPSAVE = 370,          /* CMD_MEMMAPSAVE  */
    CMD_COMMENT = 371,             /* CMD_COMMENT  */
    CMD_LIST = 372,                /* CMD_LIST  */
    CMD_STOPWATCH = 373,           /* CMD_STOPWATCH  */
    RESET = 374,                   /* RESET  */
    CMD_EXPORT = 375,              /* CMD_EXPORT  */
    CMD_AUTOSTART = 376,           /* CMD_AUTOSTART  */
    CMD_AUTOLOAD = 377,            /* CMD_AUTOLOAD  */
    CMD_MAINCPU_TRACE = 378,       /* CMD_MAINCPU_TRACE  */
    CMD_WARP = 379,                /* CMD_WARP  */
    CMD_PROFILE = 380,             /* CMD_PROFILE  */
    FLAT = 381,                    /* FLAT  */
    GRAPH = 382,                   /* GRAPH  */
    FUNC = 383,                    /* FUNC  */
    DEPTH = 384,                   /* DEPTH  */
    DISASS = 385,                  /* DISASS  */
    PROFILE_CONTEXT = 386,         /* PROFILE_CONTEXT  */
    CLEAR = 387,                   /* CLEAR  */
    CMD_LABEL_ASGN = 388,          /* CMD_LABEL_ASGN  */
    L_PAREN = 389,                 /* L_PAREN  */
    R_PAREN = 390,                 /* R_PAREN  */
    ARG_IMMEDIATE = 391,           /* ARG_IMMEDIATE  */
    REG_A = 392,                   /* REG_A  */
    REG_X = 393,                   /* REG_X  */
    REG_Y = 394,                   /* REG_Y  */
    COMMA = 395,                   /* COMMA  */
    INST_SEP = 396,                /* INST_SEP  */
    L_BRACKET = 397,               /* L_BRACKET  */
    R_BRACKET = 398,               /* R_BRACKET  */
    LESS_THAN = 399,               /* LESS_THAN  */
    REG_U = 400,                   /* REG_U  */
    REG_S = 401,                   /* REG_S  */
    REG_PC = 402,                  /* REG_PC  */
    REG_PCR = 403,                 /* REG_PCR  */
    REG_B = 404,                   /* REG_B  */
    REG_C = 405,                   /* REG_C  */
    REG_D = 406,                   /* REG_D  */
    REG_E = 407,                   /* REG_E  */
    REG_H = 408,                   /* REG_H  */
    REG_L = 409,                   /* REG_L  */
    REG_AF = 410,                  /* REG_AF  */
    REG_BC = 411,                  /* REG_BC  */
    REG_DE = 412,                  /* REG_DE  */
    REG_HL = 413,                  /* REG_HL  */
    REG_IX = 414,                  /* REG_IX  */
    REG_IY = 415,                  /* REG_IY  */
    REG_SP = 416,                  /* REG_SP  */
    REG_IXH = 417,                 /* REG_IXH  */
    REG_IXL = 418,                 /* REG_IXL  */
    REG_IYH = 419,                 /* REG_IYH  */
    REG_IYL = 420,                 /* REG_IYL  */
    PLUS = 421,                    /* PLUS  */
    MINUS = 422,                   /* MINUS  */
    STRING = 423,                  /* STRING  */
    FILENAME = 424,                /* FILENAME  */
    R_O_L = 425,                   /* R_O_L  */
    R_O_L_Q = 426,                 /* R_O_L_Q  */
    OPCODE = 427,                  /* OPCODE  */
    LABEL = 428,                   /* LABEL  */
    BANKNAME = 429,                /* BANKNAME  */
    CPUTYPE = 430,                 /* CPUTYPE  */
    MON_REGISTER = 431,            /* MON_REGISTER  */
    COND_OP = 432,                 /* COND_OP  */
    RADIX_TYPE = 433,              /* RADIX_TYPE  */
    INPUT_SPEC = 434,              /* INPUT_SPEC  */
    CMD_CHECKPT_ON = 435,          /* CMD_CHECKPT_ON  */
    CMD_CHECKPT_OFF = 436,         /* CMD_CHECKPT_OFF  */
    TOGGLE = 437,                  /* TOGGLE  */
    MASK = 438                     /* MASK  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define H_NUMBER 258
#define D_NUMBER 259
#define O_NUMBER 260
#define B_NUMBER 261
#define CONVERT_OP 262
#define B_DATA 263
#define H_RANGE_GUESS 264
#define D_NUMBER_GUESS 265
#define O_NUMBER_GUESS 266
#define B_NUMBER_GUESS 267
#define BAD_CMD 268
#define MEM_OP 269
#define IF 270
#define MEM_COMP 271
#define MEM_DISK8 272
#define MEM_DISK9 273
#define MEM_DISK10 274
#define MEM_DISK11 275
#define EQUALS 276
#define TRAIL 277
#define CMD_SEP 278
#define LABEL_ASGN_COMMENT 279
#define CMD_LOG 280
#define CMD_LOGNAME 281
#define CMD_SIDEFX 282
#define CMD_DUMMY 283
#define CMD_RETURN 284
#define CMD_BLOCK_READ 285
#define CMD_BLOCK_WRITE 286
#define CMD_UP 287
#define CMD_DOWN 288
#define CMD_LOAD 289
#define CMD_BASICLOAD 290
#define CMD_SAVE 291
#define CMD_VERIFY 292
#define CMD_BVERIFY 293
#define CMD_IGNORE 294
#define CMD_HUNT 295
#define CMD_FILL 296
#define CMD_MOVE 297
#define CMD_GOTO 298
#define CMD_REGISTERS 299
#define CMD_READSPACE 300
#define CMD_WRITESPACE 301
#define CMD_RADIX 302
#define CMD_MEM_DISPLAY 303
#define CMD_BREAK 304
#define CMD_TRACE 305
#define CMD_IO 306
#define CMD_BRMON 307
#define CMD_COMPARE 308
#define CMD_DUMP 309
#define CMD_UNDUMP 310
#define CMD_EXIT 311
#define CMD_DELETE 312
#define CMD_CONDITION 313
#define CMD_COMMAND 314
#define CMD_ASSEMBLE 315
#define CMD_DISASSEMBLE 316
#define CMD_NEXT 317
#define CMD_STEP 318
#define CMD_PRINT 319
#define CMD_DEVICE 320
#define CMD_HELP 321
#define CMD_WATCH 322
#define CMD_DISK 323
#define CMD_QUIT 324
#define CMD_CHDIR 325
#define CMD_BANK 326
#define CMD_LOAD_LABELS 327
#define CMD_SAVE_LABELS 328
#define CMD_ADD_LABEL 329
#define CMD_DEL_LABEL 330
#define CMD_SHOW_LABELS 331
#define CMD_CLEAR_LABELS 332
#define CMD_RECORD 333
#define CMD_MON_STOP 334
#define CMD_PLAYBACK 335
#define CMD_CHAR_DISPLAY 336
#define CMD_SPRITE_DISPLAY 337
#define CMD_TEXT_DISPLAY 338
#define CMD_SCREENCODE_DISPLAY 339
#define CMD_ENTER_DATA 340
#define CMD_ENTER_BIN_DATA 341
#define CMD_KEYBUF 342
#define CMD_BLOAD 343
#define CMD_BSAVE 344
#define CMD_SCREEN 345
#define CMD_UNTIL 346
#define CMD_CPU 347
#define CMD_YYDEBUG 348
#define CMD_BACKTRACE 349
#define CMD_SCREENSHOT 350
#define CMD_PWD 351
#define CMD_DIR 352
#define CMD_MKDIR 353
#define CMD_RMDIR 354
#define CMD_RESOURCE_GET 355
#define CMD_RESOURCE_SET 356
#define CMD_LOAD_RESOURCES 357
#define CMD_SAVE_RESOURCES 358
#define CMD_ATTACH 359
#define CMD_DETACH 360
#define CMD_MON_RESET 361
#define CMD_TAPECTRL 362
#define CMD_TAPEOFFS 363
#define CMD_CARTFREEZE 364
#define CMD_UPDB 365
#define CMD_JPDB 366
#define CMD_CPUHISTORY 367
#define CMD_MEMMAPZAP 368
#define CMD_MEMMAPSHOW 369
#define CMD_MEMMAPSAVE 370
#define CMD_COMMENT 371
#define CMD_LIST 372
#define CMD_STOPWATCH 373
#define RESET 374
#define CMD_EXPORT 375
#define CMD_AUTOSTART 376
#define CMD_AUTOLOAD 377
#define CMD_MAINCPU_TRACE 378
#define CMD_WARP 379
#define CMD_PROFILE 380
#define FLAT 381
#define GRAPH 382
#define FUNC 383
#define DEPTH 384
#define DISASS 385
#define PROFILE_CONTEXT 386
#define CLEAR 387
#define CMD_LABEL_ASGN 388
#define L_PAREN 389
#define R_PAREN 390
#define ARG_IMMEDIATE 391
#define REG_A 392
#define REG_X 393
#define REG_Y 394
#define COMMA 395
#define INST_SEP 396
#define L_BRACKET 397
#define R_BRACKET 398
#define LESS_THAN 399
#define REG_U 400
#define REG_S 401
#define REG_PC 402
#define REG_PCR 403
#define REG_B 404
#define REG_C 405
#define REG_D 406
#define REG_E 407
#define REG_H 408
#define REG_L 409
#define REG_AF 410
#define REG_BC 411
#define REG_DE 412
#define REG_HL 413
#define REG_IX 414
#define REG_IY 415
#define REG_SP 416
#define REG_IXH 417
#define REG_IXL 418
#define REG_IYH 419
#define REG_IYL 420
#define PLUS 421
#define MINUS 422
#define STRING 423
#define FILENAME 424
#define R_O_L 425
#define R_O_L_Q 426
#define OPCODE 427
#define LABEL 428
#define BANKNAME 429
#define CPUTYPE 430
#define MON_REGISTER 431
#define COND_OP 432
#define RADIX_TYPE 433
#define INPUT_SPEC 434
#define CMD_CHECKPT_ON 435
#define CMD_CHECKPT_OFF 436
#define TOGGLE 437
#define MASK 438

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 123 "mon_parse.y"

    MON_ADDR a;
    MON_ADDR range[2];
    int i;
    REG_ID reg;
    CONDITIONAL cond_op;
    cond_node_t *cond_node;
    RADIXTYPE rt;
    ACTION action;
    char *str;
    asm_mode_addr_info_t mode;

#line 625 "mon_parse.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_MON_PARSE_H_INCLUDED  */
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_H_NUMBER = 3,                   /* H_NUMBER  */
  YYSYMBOL_D_NUMBER = 4,                   /* D_NUMBER  */
  YYSYMBOL_O_NUMBER = 5,                   /* O_NUMBER  */
  YYSYMBOL_B_NUMBER = 6,                   /* B_NUMBER  */
  YYSYMBOL_CONVERT_OP = 7,                 /* CONVERT_OP  */
  YYSYMBOL_B_DATA = 8,                     /* B_DATA  */
  YYSYMBOL_H_RANGE_GUESS = 9,              /* H_RANGE_GUESS  */
  YYSYMBOL_D_NUMBER_GUESS = 10,            /* D_NUMBER_GUESS  */
  YYSYMBOL_O_NUMBER_GUESS = 11,            /* O_NUMBER_GUESS  */
  YYSYMBOL_B_NUMBER_GUESS = 12,            /* B_NUMBER_GUESS  */
  YYSYMBOL_BAD_CMD = 13,                   /* BAD_CMD  */
  YYSYMBOL_MEM_OP = 14,                    /* MEM_OP  */
  YYSYMBOL_IF = 15,                        /* IF  */
  YYSYMBOL_MEM_COMP = 16,                  /* MEM_COMP  */
  YYSYMBOL_MEM_DISK8 = 17,                 /* MEM_DISK8  */
  YYSYMBOL_MEM_DISK9 = 18,                 /* MEM_DISK9  */
  YYSYMBOL_MEM_DISK10 = 19,                /* MEM_DISK10  */
  YYSYMBOL_MEM_DISK11 = 20,                /* MEM_DISK11  */
  YYSYMBOL_EQUALS = 21,                    /* EQUALS  */
  YYSYMBOL_TRAIL = 22,                     /* TRAIL  */
  YYSYMBOL_CMD_SEP = 23,                   /* CMD_SEP  */
  YYSYMBOL_LABEL_ASGN_COMMENT = 24,        /* LABEL_ASGN_COMMENT  */
  YYSYMBOL_CMD_LOG = 25,                   /* CMD_LOG  */
  YYSYMBOL_CMD_LOGNAME = 26,               /* CMD_LOGNAME  */
  YYSYMBOL_CMD_SIDEFX = 27,                /* CMD_SIDEFX  */
  YYSYMBOL_CMD_DUMMY = 28,                 /* CMD_DUMMY  */
  YYSYMBOL_CMD_RETURN = 29,                /* CMD_RETURN  */
  YYSYMBOL_CMD_BLOCK_READ = 30,            /* CMD_BLOCK_READ  */
  YYSYMBOL_CMD_BLOCK_WRITE = 31,           /* CMD_BLOCK_WRITE  */
  YYSYMBOL_CMD_UP = 32,                    /* CMD_UP  */
  YYSYMBOL_CMD_DOWN = 33,                  /* CMD_DOWN  */
  YYSYMBOL_CMD_LOAD = 34,                  /* CMD_LOAD  */
  YYSYMBOL_CMD_BASICLOAD = 35,             /* CMD_BASICLOAD  */
  YYSYMBOL_CMD_SAVE = 36,                  /* CMD_SAVE  */
  YYSYMBOL_CMD_VERIFY = 37,                /* CMD_VERIFY  */
  YYSYMBOL_CMD_BVERIFY = 38,               /* CMD_BVERIFY  */
  YYSYMBOL_CMD_IGNORE = 39,                /* CMD_IGNORE  */
  YYSYMBOL_CMD_HUNT = 40,                  /* CMD_HUNT  */
  YYSYMBOL_CMD_FILL = 41,                  /* CMD_FILL  */
  YYSYMBOL_CMD_MOVE = 42,                  /* CMD_MOVE  */
  YYSYMBOL_CMD_GOTO = 43,                  /* CMD_GOTO  */
  YYSYMBOL_CMD_REGISTERS = 44,             /* CMD_REGISTERS  */
  YYSYMBOL_CMD_READSPACE = 45,             /* CMD_READSPACE  */
  YYSYMBOL_CMD_WRITESPACE = 46,            /* CMD_WRITESPACE  */
  YYSYMBOL_CMD_RADIX = 47,                 /* CMD_RADIX  */
  YYSYMBOL_CMD_MEM_DISPLAY = 48,           /* CMD_MEM_DISPLAY  */
  YYSYMBOL_CMD_BREAK = 49,                 /* CMD_BREAK  */
  YYSYMBOL_CMD_TRACE = 50,                 /* CMD_TRACE  */
  YYSYMBOL_CMD_IO = 51,                    /* CMD_IO  */
  YYSYMBOL_CMD_BRMON = 52,                 /* CMD_BRMON  */
  YYSYMBOL_CMD_COMPARE = 53,               /* CMD_COMPARE  */
  YYSYMBOL_CMD_DUMP = 54,                  /* CMD_DUMP  */
  YYSYMBOL_CMD_UNDUMP = 55,                /* CMD_UNDUMP  */
  YYSYMBOL_CMD_EXIT = 56,                  /* CMD_EXIT  */
  YYSYMBOL_CMD_DELETE = 57,                /* CMD_DELETE  */
  YYSYMBOL_CMD_CONDITION = 58,             /* CMD_CONDITION  */
  YYSYMBOL_CMD_COMMAND = 59,               /* CMD_COMMAND  */
  YYSYMBOL_CMD_ASSEMBLE = 60,              /* CMD_ASSEMBLE  */
  YYSYMBOL_CMD_DISASSEMBLE = 61,           /* CMD_DISASSEMBLE  */
  YYSYMBOL_CMD_NEXT = 62,                  /* CMD_NEXT  */
  YYSYMBOL_CMD_STEP = 63,                  /* CMD_STEP  */
  YYSYMBOL_CMD_PRINT = 64,                 /* CMD_PRINT  */
  YYSYMBOL_CMD_DEVICE = 65,                /* CMD_DEVICE  */
  YYSYMBOL_CMD_HELP = 66,                  /* CMD_HELP  */
  YYSYMBOL_CMD_WATCH = 67,                 /* CMD_WATCH  */
  YYSYMBOL_CMD_DISK = 68,                  /* CMD_DISK  */
  YYSYMBOL_CMD_QUIT = 69,                  /* CMD_QUIT  */
  YYSYMBOL_CMD_CHDIR = 70,                 /* CMD_CHDIR  */
  YYSYMBOL_CMD_BANK = 71,                  /* CMD_BANK  */
  YYSYMBOL_CMD_LOAD_LABELS = 72,           /* CMD_LOAD_LABELS  */
  YYSYMBOL_CMD_SAVE_LABELS = 73,           /* CMD_SAVE_LABELS  */
  YYSYMBOL_CMD_ADD_LABEL = 74,             /* CMD_ADD_LABEL  */
  YYSYMBOL_CMD_DEL_LABEL = 75,             /* CMD_DEL_LABEL  */
  YYSYMBOL_CMD_SHOW_LABELS = 76,           /* CMD_SHOW_LABELS  */
  YYSYMBOL_CMD_CLEAR_LABELS = 77,          /* CMD_CLEAR_LABELS  */
  YYSYMBOL_CMD_RECORD = 78,                /* CMD_RECORD  */
  YYSYMBOL_CMD_MON_STOP = 79,              /* CMD_MON_STOP  */
  YYSYMBOL_CMD_PLAYBACK = 80,              /* CMD_PLAYBACK  */
  YYSYMBOL_CMD_CHAR_DISPLAY = 81,          /* CMD_CHAR_DISPLAY  */
  YYSYMBOL_CMD_SPRITE_DISPLAY = 82,        /* CMD_SPRITE_DISPLAY  */
  YYSYMBOL_CMD_TEXT_DISPLAY = 83,          /* CMD_TEXT_DISPLAY  */
  YYSYMBOL_CMD_SCREENCODE_DISPLAY = 84,    /* CMD_SCREENCODE_DISPLAY  */
  YYSYMBOL_CMD_ENTER_DATA = 85,            /* CMD_ENTER_DATA  */
  YYSYMBOL_CMD_ENTER_BIN_DATA = 86,        /* CMD_ENTER_BIN_DATA  */
  YYSYMBOL_CMD_KEYBUF = 87,                /* CMD_KEYBUF  */
  YYSYMBOL_CMD_BLOAD = 88,                 /* CMD_BLOAD  */
  YYSYMBOL_CMD_BSAVE = 89,                 /* CMD_BSAVE  */
  YYSYMBOL_CMD_SCREEN = 90,                /* CMD_SCREEN  */
  YYSYMBOL_CMD_UNTIL = 91,                 /* CMD_UNTIL  */
  YYSYMBOL_CMD_CPU = 92,                   /* CMD_CPU  */
  YYSYMBOL_CMD_YYDEBUG = 93,               /* CMD_YYDEBUG  */
  YYSYMBOL_CMD_BACKTRACE = 94,             /* CMD_BACKTRACE  */
  YYSYMBOL_CMD_SCREENSHOT = 95,            /* CMD_SCREENSHOT  */
  YYSYMBOL_CMD_PWD = 96,                   /* CMD_PWD  */
  YYSYMBOL_CMD_DIR = 97,                   /* CMD_DIR  */
  YYSYMBOL_CMD_MKDIR = 98,                 /* CMD_MKDIR  */
  YYSYMBOL_CMD_RMDIR = 99,                 /* CMD_RMDIR  */
  YYSYMBOL_CMD_RESOURCE_GET = 100,         /* CMD_RESOURCE_GET  */
  YYSYMBOL_CMD_RESOURCE_SET = 101,         /* CMD_RESOURCE_SET  */
  YYSYMBOL_CMD_LOAD_RESOURCES = 102,       /* CMD_LOAD_RESOURCES  */
  YYSYMBOL_CMD_SAVE_RESOURCES = 103,       /* CMD_SAVE_RESOURCES  */
  YYSYMBOL_CMD_ATTACH = 104,               /* CMD_ATTACH  */
  YYSYMBOL_CMD_DETACH = 105,               /* CMD_DETACH  */
  YYSYMBOL_CMD_MON_RESET = 106,            /* CMD_MON_RESET  */
  YYSYMBOL_CMD_TAPECTRL = 107,             /* CMD_TAPECTRL  */
  YYSYMBOL_CMD_TAPEOFFS = 108,             /* CMD_TAPEOFFS  */
  YYSYMBOL_CMD_CARTFREEZE = 109,           /* CMD_CARTFREEZE  */
  YYSYMBOL_CMD_UPDB = 110,                 /* CMD_UPDB  */
  YYSYMBOL_CMD_JPDB = 111,                 /* CMD_JPDB  */
  YYSYMBOL_CMD_CPUHISTORY = 112,           /* CMD_CPUHISTORY  */
  YYSYMBOL_CMD_MEMMAPZAP = 113,            /* CMD_MEMMAPZAP  */
  YYSYMBOL_CMD_MEMMAPSHOW = 114,           /* CMD_MEMMAPSHOW  */
  YYSYMBOL_CMD_MEMMAPSAVE = 115,           /* CMD_MEMMAPSAVE  */
  YYSYMBOL_CMD_COMMENT = 116,              /* CMD_COMMENT  */
  YYSYMBOL_CMD_LIST = 117,                 /* CMD_LIST  */
  YYSYMBOL_CMD_STOPWATCH = 118,            /* CMD_STOPWATCH  */
  YYSYMBOL_RESET = 119,                    /* RESET  */
  YYSYMBOL_CMD_EXPORT = 120,               /* CMD_EXPORT  */
  YYSYMBOL_CMD_AUTOSTART = 121,            /* CMD_AUTOSTART  */
  YYSYMBOL_CMD_AUTOLOAD = 122,             /* CMD_AUTOLOAD  */
  YYSYMBOL_CMD_MAINCPU_TRACE = 123,        /* CMD_MAINCPU_TRACE  */
  YYSYMBOL_CMD_WARP = 124,                 /* CMD_WARP  */
  YYSYMBOL_CMD_PROFILE = 125,              /* CMD_PROFILE  */
  YYSYMBOL_FLAT = 126,                     /* FLAT  */
  YYSYMBOL_GRAPH = 127,                    /* GRAPH  */
  YYSYMBOL_FUNC = 128,                     /* FUNC  */
  YYSYMBOL_DEPTH = 129,                    /* DEPTH  */
  YYSYMBOL_DISASS = 130,                   /* DISASS  */
  YYSYMBOL_PROFILE_CONTEXT = 131,          /* PROFILE_CONTEXT  */
  YYSYMBOL_CLEAR = 132,                    /* CLEAR  */
  YYSYMBOL_CMD_LABEL_ASGN = 133,           /* CMD_LABEL_ASGN  */
  YYSYMBOL_L_PAREN = 134,                  /* L_PAREN  */
  YYSYMBOL_R_PAREN = 135,                  /* R_PAREN  */
  YYSYMBOL_ARG_IMMEDIATE = 136,            /* ARG_IMMEDIATE  */
  YYSYMBOL_REG_A = 137,                    /* REG_A  */
  YYSYMBOL_REG_X = 138,                    /* REG_X  */
  YYSYMBOL_REG_Y = 139,                    /* REG_Y  */
  YYSYMBOL_COMMA = 140,                    /* COMMA  */
  YYSYMBOL_INST_SEP = 141,                 /* INST_SEP  */
  YYSYMBOL_L_BRACKET = 142,                /* L_BRACKET  */
  YYSYMBOL_R_BRACKET = 143,                /* R_BRACKET  */
  YYSYMBOL_LESS_THAN = 144,                /* LESS_THAN  */
  YYSYMBOL_REG_U = 145,                    /* REG_U  */
  YYSYMBOL_REG_S = 146,                    /* REG_S  */
  YYSYMBOL_REG_PC = 147,                   /* REG_PC  */
  YYSYMBOL_REG_PCR = 148,                  /* REG_PCR  */
  YYSYMBOL_REG_B = 149,                    /* REG_B  */
  YYSYMBOL_REG_C = 150,                    /* REG_C  */
  YYSYMBOL_REG_D = 151,                    /* REG_D  */
  YYSYMBOL_REG_E = 152,                    /* REG_E  */
  YYSYMBOL_REG_H = 153,                    /* REG_H  */
  YYSYMBOL_REG_L = 154,                    /* REG_L  */
  YYSYMBOL_REG_AF = 155,                   /* REG_AF  */
  YYSYMBOL_REG_BC = 156,                   /* REG_BC  */
  YYSYMBOL_REG_DE = 157,                   /* REG_DE  */
  YYSYMBOL_REG_HL = 158,                   /* REG_HL  */
  YYSYMBOL_REG_IX = 159,                   /* REG_IX  */
  YYSYMBOL_REG_IY = 160,                   /* REG_IY  */
  YYSYMBOL_REG_SP = 161,                   /* REG_SP  */
  YYSYMBOL_REG_IXH = 162,                  /* REG_IXH  */
  YYSYMBOL_REG_IXL = 163,                  /* REG_IXL  */
  YYSYMBOL_REG_IYH = 164,                  /* REG_IYH  */
  YYSYMBOL_REG_IYL = 165,                  /* REG_IYL  */
  YYSYMBOL_PLUS = 166,                     /* PLUS  */
  YYSYMBOL_MINUS = 167,                    /* MINUS  */
  YYSYMBOL_STRING = 168,                   /* STRING  */
  YYSYMBOL_FILENAME = 169,                 /* FILENAME  */
  YYSYMBOL_R_O_L = 170,                    /* R_O_L  */
  YYSYMBOL_R_O_L_Q = 171,                  /* R_O_L_Q  */
  YYSYMBOL_OPCODE = 172,                   /* OPCODE  */
  YYSYMBOL_LABEL = 173,                    /* LABEL  */
  YYSYMBOL_BANKNAME = 174,                 /* BANKNAME  */
  YYSYMBOL_CPUTYPE = 175,                  /* CPUTYPE  */
  YYSYMBOL_MON_REGISTER = 176,             /* MON_REGISTER  */
  YYSYMBOL_COND_OP = 177,                  /* COND_OP  */
  YYSYMBOL_RADIX_TYPE = 178,               /* RADIX_TYPE  */
  YYSYMBOL_INPUT_SPEC = 179,               /* INPUT_SPEC  */
  YYSYMBOL_CMD_CHECKPT_ON = 180,           /* CMD_CHECKPT_ON  */
  YYSYMBOL_CMD_CHECKPT_OFF = 181,          /* CMD_CHECKPT_OFF  */
  YYSYMBOL_TOGGLE = 182,                   /* TOGGLE  */
  YYSYMBOL_MASK = 183,                     /* MASK  */
  YYSYMBOL_184_ = 184,                     /* '+'  */
  YYSYMBOL_185_ = 185,                     /* '-'  */
  YYSYMBOL_186_ = 186,                     /* '*'  */
  YYSYMBOL_187_ = 187,                     /* '/'  */
  YYSYMBOL_188_ = 188,                     /* '('  */
  YYSYMBOL_189_ = 189,                     /* ')'  */
  YYSYMBOL_190_ = 190,                     /* '@'  */
  YYSYMBOL_191_ = 191,                     /* ':'  */
  YYSYMBOL_YYACCEPT = 192,                 /* $accept  */
  YYSYMBOL_top_level = 193,                /* top_level  */
  YYSYMBOL_command_list = 194,             /* command_list  */
  YYSYMBOL_end_cmd = 195,                  /* end_cmd  */
  YYSYMBOL_command = 196,                  /* command  */
  YYSYMBOL_machine_state_rules = 197,      /* machine_state_rules  */
  YYSYMBOL_register_mod = 198,             /* register_mod  */
  YYSYMBOL_symbol_table_rules = 199,       /* symbol_table_rules  */
  YYSYMBOL_asm_rules = 200,                /* asm_rules  */
  YYSYMBOL_201_1 = 201,                    /* $@1  */
  YYSYMBOL_memory_rules = 202,             /* memory_rules  */
  YYSYMBOL_checkpoint_rules = 203,         /* checkpoint_rules  */
  YYSYMBOL_checkpoint_control_rules = 204, /* checkpoint_control_rules  */
  YYSYMBOL_monitor_state_rules = 205,      /* monitor_state_rules  */
  YYSYMBOL_monitor_misc_rules = 206,       /* monitor_misc_rules  */
  YYSYMBOL_disk_rules = 207,               /* disk_rules  */
  YYSYMBOL_cmd_file_rules = 208,           /* cmd_file_rules  */
  YYSYMBOL_data_entry_rules = 209,         /* data_entry_rules  */
  YYSYMBOL_monitor_debug_rules = 210,      /* monitor_debug_rules  */
  YYSYMBOL_rest_of_line = 211,             /* rest_of_line  */
  YYSYMBOL_opt_rest_of_line = 212,         /* opt_rest_of_line  */
  YYSYMBOL_rest_of_line_or_quoted = 213,   /* rest_of_line_or_quoted  */
  YYSYMBOL_filename = 214,                 /* filename  */
  YYSYMBOL_device_num = 215,               /* device_num  */
  YYSYMBOL_mem_op = 216,                   /* mem_op  */
  YYSYMBOL_opt_mem_op = 217,               /* opt_mem_op  */
  YYSYMBOL_register = 218,                 /* register  */
  YYSYMBOL_reg_list = 219,                 /* reg_list  */
  YYSYMBOL_reg_asgn = 220,                 /* reg_asgn  */
  YYSYMBOL_checkpt_num = 221,              /* checkpt_num  */
  YYSYMBOL_opt_context_num = 222,          /* opt_context_num  */
  YYSYMBOL_address_opt_range = 223,        /* address_opt_range  */
  YYSYMBOL_address_range = 224,            /* address_range  */
  YYSYMBOL_opt_address = 225,              /* opt_address  */
  YYSYMBOL_address = 226,                  /* address  */
  YYSYMBOL_opt_sep = 227,                  /* opt_sep  */
  YYSYMBOL_memspace = 228,                 /* memspace  */
  YYSYMBOL_memloc = 229,                   /* memloc  */
  YYSYMBOL_memaddr = 230,                  /* memaddr  */
  YYSYMBOL_expression = 231,               /* expression  */
  YYSYMBOL_opt_if_cond_expr = 232,         /* opt_if_cond_expr  */
  YYSYMBOL_cond_expr = 233,                /* cond_expr  */
  YYSYMBOL_cond_operand = 234,             /* cond_operand  */
  YYSYMBOL_data_list = 235,                /* data_list  */
  YYSYMBOL_data_element = 236,             /* data_element  */
  YYSYMBOL_hunt_list = 237,                /* hunt_list  */
  YYSYMBOL_hunt_element = 238,             /* hunt_element  */
  YYSYMBOL_value = 239,                    /* value  */
  YYSYMBOL_d_number = 240,                 /* d_number  */
  YYSYMBOL_opt_d_number = 241,             /* opt_d_number  */
  YYSYMBOL_guess_default = 242,            /* guess_default  */
  YYSYMBOL_number = 243,                   /* number  */
  YYSYMBOL_assembly_instr_list = 244,      /* assembly_instr_list  */
  YYSYMBOL_assembly_instruction = 245,     /* assembly_instruction  */
  YYSYMBOL_post_assemble = 246,            /* post_assemble  */
  YYSYMBOL_asm_operand_mode = 247,         /* asm_operand_mode  */
  YYSYMBOL_index_reg = 248,                /* index_reg  */
  YYSYMBOL_index_ureg = 249                /* index_ureg  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  352
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1981

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  192
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  58
/* YYNRULES -- Number of rules.  */
#define YYNRULES  360
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  738

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   438


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     188,   189,   186,   184,     2,   185,     2,   187,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,   191,     2,
       2,     2,     2,     2,   190,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   118,   119,   120,   121,   122,   123,   124,
     125,   126,   127,   128,   129,   130,   131,   132,   133,   134,
     135,   136,   137,   138,   139,   140,   141,   142,   143,   144,
     145,   146,   147,   148,   149,   150,   151,   152,   153,   154,
     155,   156,   157,   158,   159,   160,   161,   162,   163,   164,
     165,   166,   167,   168,   169,   170,   171,   172,   173,   174,
     175,   176,   177,   178,   179,   180,   181,   182,   183
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   189,   189,   190,   191,   194,   195,   198,   199,   200,
     203,   204,   205,   206,   207,   208,   209,   210,   211,   212,
     213,   214,   215,   218,   220,   222,   224,   226,   228,   230,
     232,   234,   236,   238,   240,   242,   244,   246,   248,   250,
     252,   254,   256,   258,   260,   262,   264,   266,   268,   270,
     272,   274,   276,   278,   280,   282,   284,   286,   288,   293,
     297,   300,   302,   304,   307,   312,   317,   319,   321,   323,
     325,   327,   329,   331,   333,   335,   339,   346,   345,   348,
     350,   352,   356,   358,   360,   362,   364,   366,   368,   370,
     372,   374,   376,   378,   380,   382,   384,   386,   388,   390,
     392,   394,   398,   407,   410,   414,   417,   426,   429,   438,
     443,   445,   447,   449,   451,   453,   455,   457,   459,   461,
     463,   467,   469,   474,   481,   489,   496,   508,   512,   514,
     532,   534,   536,   538,   540,   542,   544,   548,   550,   552,
     554,   556,   558,   560,   562,   564,   566,   568,   570,   572,
     574,   576,   578,   580,   582,   584,   586,   588,   590,   592,
     594,   596,   598,   600,   602,   604,   606,   608,   610,   612,
     614,   616,   618,   620,   622,   624,   626,   630,   632,   634,
     636,   638,   640,   642,   644,   646,   648,   650,   652,   654,
     656,   658,   660,   662,   664,   666,   668,   670,   672,   676,
     678,   680,   684,   686,   690,   698,   701,   702,   705,   708,
     709,   712,   713,   716,   717,   720,   721,   724,   730,   738,
     739,   742,   746,   747,   750,   751,   754,   755,   758,   759,
     761,   765,   766,   769,   774,   779,   789,   790,   793,   794,
     795,   796,   797,   800,   802,   827,   828,   829,   830,   831,
     832,   833,   836,   837,   839,   844,   846,   848,   850,   854,
     860,   867,   880,   894,   895,   898,   899,   902,   903,   906,
     907,   908,   911,   912,   915,   916,   917,   918,   921,   922,
     925,   926,   927,   930,   931,   932,   933,   934,   937,   938,
     939,   942,   952,   953,   956,   963,   974,   985,   993,  1012,
    1018,  1026,  1034,  1036,  1038,  1039,  1040,  1041,  1042,  1043,
    1044,  1046,  1048,  1050,  1052,  1053,  1054,  1055,  1056,  1057,
    1058,  1059,  1060,  1061,  1062,  1063,  1064,  1065,  1066,  1067,
    1068,  1069,  1070,  1072,  1073,  1088,  1092,  1096,  1100,  1104,
    1108,  1112,  1116,  1120,  1132,  1147,  1151,  1155,  1159,  1163,
    1167,  1171,  1175,  1179,  1191,  1196,  1204,  1205,  1206,  1207,
    1211
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "H_NUMBER", "D_NUMBER",
  "O_NUMBER", "B_NUMBER", "CONVERT_OP", "B_DATA", "H_RANGE_GUESS",
  "D_NUMBER_GUESS", "O_NUMBER_GUESS", "B_NUMBER_GUESS", "BAD_CMD",
  "MEM_OP", "IF", "MEM_COMP", "MEM_DISK8", "MEM_DISK9", "MEM_DISK10",
  "MEM_DISK11", "EQUALS", "TRAIL", "CMD_SEP", "LABEL_ASGN_COMMENT",
  "CMD_LOG", "CMD_LOGNAME", "CMD_SIDEFX", "CMD_DUMMY", "CMD_RETURN",
  "CMD_BLOCK_READ", "CMD_BLOCK_WRITE", "CMD_UP", "CMD_DOWN", "CMD_LOAD",
  "CMD_BASICLOAD", "CMD_SAVE", "CMD_VERIFY", "CMD_BVERIFY", "CMD_IGNORE",
  "CMD_HUNT", "CMD_FILL", "CMD_MOVE", "CMD_GOTO", "CMD_REGISTERS",
  "CMD_READSPACE", "CMD_WRITESPACE", "CMD_RADIX", "CMD_MEM_DISPLAY",
  "CMD_BREAK", "CMD_TRACE", "CMD_IO", "CMD_BRMON", "CMD_COMPARE",
  "CMD_DUMP", "CMD_UNDUMP", "CMD_EXIT", "CMD_DELETE", "CMD_CONDITION",
  "CMD_COMMAND", "CMD_ASSEMBLE", "CMD_DISASSEMBLE", "CMD_NEXT", "CMD_STEP",
  "CMD_PRINT", "CMD_DEVICE", "CMD_HELP", "CMD_WATCH", "CMD_DISK",
  "CMD_QUIT", "CMD_CHDIR", "CMD_BANK", "CMD_LOAD_LABELS",
  "CMD_SAVE_LABELS", "CMD_ADD_LABEL", "CMD_DEL_LABEL", "CMD_SHOW_LABELS",
  "CMD_CLEAR_LABELS", "CMD_RECORD", "CMD_MON_STOP", "CMD_PLAYBACK",
  "CMD_CHAR_DISPLAY", "CMD_SPRITE_DISPLAY", "CMD_TEXT_DISPLAY",
  "CMD_SCREENCODE_DISPLAY", "CMD_ENTER_DATA", "CMD_ENTER_BIN_DATA",
  "CMD_KEYBUF", "CMD_BLOAD", "CMD_BSAVE", "CMD_SCREEN", "CMD_UNTIL",
  "CMD_CPU", "CMD_YYDEBUG", "CMD_BACKTRACE", "CMD_SCREENSHOT", "CMD_PWD",
  "CMD_DIR", "CMD_MKDIR", "CMD_RMDIR", "CMD_RESOURCE_GET",
  "CMD_RESOURCE_SET", "CMD_LOAD_RESOURCES", "CMD_SAVE_RESOURCES",
  "CMD_ATTACH", "CMD_DETACH", "CMD_MON_RESET", "CMD_TAPECTRL",
  "CMD_TAPEOFFS", "CMD_CARTFREEZE", "CMD_UPDB", "CMD_JPDB",
  "CMD_CPUHISTORY", "CMD_MEMMAPZAP", "CMD_MEMMAPSHOW", "CMD_MEMMAPSAVE",
  "CMD_COMMENT", "CMD_LIST", "CMD_STOPWATCH", "RESET", "CMD_EXPORT",
  "CMD_AUTOSTART", "CMD_AUTOLOAD", "CMD_MAINCPU_TRACE", "CMD_WARP",
  "CMD_PROFILE", "FLAT", "GRAPH", "FUNC", "DEPTH", "DISASS",
  "PROFILE_CONTEXT", "CLEAR", "CMD_LABEL_ASGN", "L_PAREN", "R_PAREN",
  "ARG_IMMEDIATE", "REG_A", "REG_X", "REG_Y", "COMMA", "INST_SEP",
  "L_BRACKET", "R_BRACKET", "LESS_THAN", "REG_U", "REG_S", "REG_PC",
  "REG_PCR", "REG_B", "REG_C", "REG_D", "REG_E", "REG_H", "REG_L",
  "REG_AF", "REG_BC", "REG_DE", "REG_HL", "REG_IX", "REG_IY", "REG_SP",
  "REG_IXH", "REG_IXL", "REG_IYH", "REG_IYL", "PLUS", "MINUS", "STRING",
  "FILENAME", "R_O_L", "R_O_L_Q", "OPCODE", "LABEL", "BANKNAME", "CPUTYPE",
  "MON_REGISTER", "COND_OP", "RADIX_TYPE", "INPUT_SPEC", "CMD_CHECKPT_ON",
  "CMD_CHECKPT_OFF", "TOGGLE", "MASK", "'+'", "'-'", "'*'", "'/'", "'('",
  "')'", "'@'", "':'", "$accept", "top_level", "command_list", "end_cmd",
  "command", "machine_state_rules", "register_mod", "symbol_table_rules",
  "asm_rules", "$@1", "memory_rules", "checkpoint_rules",
  "checkpoint_control_rules", "monitor_state_rules", "monitor_misc_rules",
  "disk_rules", "cmd_file_rules", "data_entry_rules",
  "monitor_debug_rules", "rest_of_line", "opt_rest_of_line",
  "rest_of_line_or_quoted", "filename", "device_num", "mem_op",
  "opt_mem_op", "register", "reg_list", "reg_asgn", "checkpt_num",
  "opt_context_num", "address_opt_range", "address_range", "opt_address",
  "address", "opt_sep", "memspace", "memloc", "memaddr", "expression",
  "opt_if_cond_expr", "cond_expr", "cond_operand", "data_list",
  "data_element", "hunt_list", "hunt_element", "value", "d_number",
  "opt_d_number", "guess_default", "number", "assembly_instr_list",
  "assembly_instruction", "post_assemble", "asm_operand_mode", "index_reg",
  "index_ureg", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-428)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-238)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    1425,   348,  -428,  -428,     2,     3,    68,    84,   477,   348,
     348,   387,   387,     3,     3,     3,     3,     3,   325,  1151,
    1151,  1151,  1406,   299,    49,  1176,  1224,  1224,  1406,  1151,
       3,     3,   477,  1028,   325,   325,  1766,  1248,   387,   387,
     348,  1303,    98,  1224,   -84,   477,   -76,   399,   407,   407,
    1766,   420,  1303,  1303,     3,   477,     3,  1248,  1248,  1248,
    1248,  1766,   477,   -84,     3,     3,  1406,  1248,   186,   477,
     477,     3,   477,   -70,   -76,   -76,   -56,   -41,     3,     3,
       3,   348,   387,   -12,   387,   477,  1052,  1801,  1295,   477,
     387,     3,   -70,  1346,   410,   477,     3,     3,   107,   148,
     440,   124,  1791,  1028,  1028,   150,  1582,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,
    -428,   129,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,   348,  -428,   -21,   125,  -428,
    -428,  -428,  -428,  -428,  -428,   477,  -428,  -428,  -428,   477,
     477,  -428,   477,  -428,  -428,   962,   962,  -428,  -428,   348,
    -428,   348,   865,   865,   936,   865,   865,  -428,  -428,  -428,
    -428,  -428,   387,  -428,  -428,  -428,   -12,   -12,   -12,  -428,
    -428,  -428,   -12,   -12,  -428,   477,   -12,  -428,   135,   522,
    -428,   158,   477,  -428,   -12,  -428,   477,  -428,   559,  -428,
    -428,   151,  1151,  -428,  1151,  -428,   477,   -12,   477,   477,
    -428,   519,  -428,   477,   149,    14,   356,  -428,   477,  -428,
     348,  -428,   348,   125,  -428,   477,  -428,  -428,   477,  -428,
    1151,   477,  -428,  -428,   477,   477,  -428,   444,   477,   -12,
     477,   -12,   -12,   477,   -12,  -428,   477,  -428,   477,   477,
    -428,   477,  -428,   477,  -428,   477,  -428,   477,  -428,   477,
     838,  -428,   477,   865,   865,  -428,   477,  -428,   477,   477,
    -428,  -428,  -428,   387,  -428,  -428,   477,   477,   477,   477,
      20,   477,   477,   348,   125,  -428,   348,   348,  -428,   348,
    -428,  -428,   477,  1052,  -428,  1363,  -428,  -428,   348,   -12,
     477,   598,  -428,   477,  -428,   477,  -428,  -428,  1330,  1330,
     477,  -428,   477,  -428,   780,   780,  1766,  1766,   780,  1766,
     477,  -428,  1766,  1116,  1801,    55,    59,  1820,  1801,    61,
    -428,    66,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,  -428,    71,  -428,  -428,   477,
    -428,   477,  -428,  -428,  -428,     7,  -428,   348,   348,   348,
     348,  -428,  -428,  -428,  -428,  -428,    95,  1096,   125,   125,
    -428,   584,   584,  1383,  1556,   584,  1199,  -428,   348,   801,
    1766,  1581,   838,  1766,  -428,  1801,  1801,   357,  -428,  -428,
    -428,  1151,  -428,  -428,   163,   163,  -428,  1766,  -428,  -428,
    -428,   476,   477,    21,  -428,    43,  -428,   125,   125,  -428,
    -428,  -428,   163,  -428,  -428,  -428,  -428,    56,  -428,     3,
    -428,     3,    45,  -428,    51,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,   909,  -428,  -428,  -428,  1727,  1707,
    -428,  -428,  -428,  -428,   348,  -428,  -428,  -428,  -428,   477,
    -428,  -428,   125,  -428,   125,   125,   125,  -428,  -428,   477,
     995,   995,   886,   348,  -428,  -428,  -428,  -428,  1801,  -428,
    1801,  -428,  -428,  -428,   477,   482,  -428,   477,   477,   477,
     477,  -428,   607,    88,   104,   106,   109,   117,   126,   -65,
    -428,    75,  -428,  -428,  -428,  -428,   544,    67,  -428,   137,
     693,   143,   145,  -131,  -428,    75,    75,  1834,  -428,  -428,
    -428,  -428,   -64,   -64,  -428,  -428,   477,  1766,   477,  -428,
    -428,   477,   477,  -428,   477,   477,  -428,   477,   125,  -428,
    -428,   130,  -428,  -428,  -428,  -428,  -428,   909,   477,  -428,
    -428,   477,   476,   477,   477,   477,   476,    90,  -428,   115,
    -428,  -428,  -428,   477,   128,   147,   477,  -428,  -428,   477,
     477,   477,   477,   477,   477,  -428,   838,  -428,   477,  -428,
     477,   125,  -428,  -428,  -428,  -428,  -428,  -428,  -428,   696,
    -428,   696,  -428,   477,   125,   477,   477,  -428,   780,  -428,
    -428,  -428,  -428,  -428,   477,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,   153,   -98,  -428,    75,  -428,   141,    75,   726,
    -132,    75,    75,   796,   155,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,  -428,  -428,   113,  -428,  -428,
    -428,    22,    74,   157,  -428,  -428,    43,    43,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,   995,
     995,  -428,  -428,  -428,  -428,   477,  -428,    99,   161,   166,
    -428,  -428,   165,    75,   177,  -428,  -101,   180,   184,   188,
     189,   199,  -428,  -428,  1748,  -428,  -428,  -428,  -428,  -428,
     696,  -428,   696,  -428,  -428,  -428,  -428,  -428,  -428,  -428,
     204,  -428,   203,  -428,  -428,   207,  -428,  -428,  -428,  -428,
    -428,   476,  -428,   995,   995,   216,  -428,  -428,   -67,  -428,
     696,  -428,   696,  -428,  -428,   995,   995,  -428,   696,  -428,
     696,   477,   995,  -428,  -428,   696,   477,  -428
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int16 yydefact[] =
{
       0,     0,    22,     4,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   207,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   237,     0,     0,     0,     0,     0,     0,
       0,     0,   207,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   314,     0,     0,     0,     2,     5,    10,    60,
      11,    13,    12,    14,    15,    16,    17,    18,    19,    20,
      21,     0,   283,   285,   286,   284,   281,   282,   280,   238,
     239,   240,   241,   242,   217,     0,   273,     0,     0,   251,
     287,   272,     9,     8,     7,     0,   126,   210,   209,     0,
       0,   122,     0,   124,    45,     0,     0,   236,    52,     0,
      54,     0,     0,     0,     0,     0,     0,   223,   274,   276,
     277,   275,     0,   222,   229,   235,   237,   237,   237,   233,
     243,   244,   237,   237,    28,     0,   237,    61,     0,     0,
     220,     0,     0,   129,   237,    88,     0,   226,   237,   214,
     103,   215,     0,   109,     0,    29,     0,   237,     0,     0,
     134,     9,   117,     0,     0,     0,     0,    81,     0,    50,
       0,    48,     0,     0,   130,     0,   205,   139,     0,   107,
       0,     0,   133,   208,     0,     0,    23,     0,     0,   237,
       0,   237,   237,     0,   237,    72,     0,    74,     0,     0,
     200,     0,    90,     0,    92,     0,    94,     0,    96,     0,
       0,   203,     0,     0,     0,    56,     0,   105,     0,     0,
      31,   204,   144,     0,   146,   206,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   155,     0,     0,   158,     0,
     160,   162,     0,     0,    33,     0,    97,    98,     0,   237,
       0,     9,   191,     0,   211,     0,   167,   132,     0,     0,
       0,   135,     0,    58,   279,   225,     0,     0,     0,     0,
       0,   169,     0,     0,     0,   315,     0,     0,     0,   316,
     317,   318,   319,   320,   323,   326,   327,   328,   329,   330,
     331,   332,   321,   324,   322,   325,   295,   291,   111,     0,
     113,     0,     1,     6,     3,     0,   218,     0,     0,     0,
       0,   141,   125,   127,   121,   123,   237,     0,     0,     0,
     212,   237,   237,   182,     0,   237,     0,   114,     0,     0,
       0,     0,     0,     0,    27,     0,     0,     0,    63,    62,
     128,     0,    87,   213,   253,   253,    30,     0,    46,    47,
     116,     0,     0,     0,    79,     0,    80,     0,     0,   138,
     131,   140,   253,   137,   142,    25,    24,     0,    65,     0,
      67,     0,     0,    69,     0,    71,    73,   199,   201,    89,
      91,    93,    95,   266,     0,   264,   265,   143,     0,     0,
      57,   104,    32,   149,     0,   145,   147,   148,   151,     0,
     153,   154,     0,   194,     0,     0,     0,   161,   164,     0,
       0,     0,     0,     0,   165,   192,   166,   195,     0,   197,
       0,   136,    59,   278,     0,     0,   224,     0,     0,     0,
       0,   168,     0,     0,     0,     0,     0,     0,     0,     0,
     294,     0,   356,   357,   360,   359,     0,   339,   358,     0,
       0,     0,     0,     0,   333,     0,     0,     0,   110,   112,
     250,   249,   245,   246,   247,   248,     0,     0,     0,    53,
      55,     0,     0,   183,     0,     0,   188,     0,     0,   271,
     270,     0,   268,   269,   228,   230,   234,     0,     0,   221,
     219,     0,     0,     0,     0,     0,     0,     0,   259,     0,
     258,   260,   120,     0,   293,   292,     0,    51,    49,     0,
       0,     0,     0,     0,     0,   202,     0,   180,     0,   185,
       0,     0,   152,   193,   156,   157,   159,   163,    34,     0,
      39,     0,    99,     0,     0,     0,     0,   170,     0,   171,
     173,   174,   176,   175,     0,    75,   304,   305,   306,   307,
     308,   309,   300,     0,   341,     0,   337,   335,     0,     0,
       0,     0,     0,     0,   354,   340,   342,   296,   297,   298,
     343,   299,   334,   189,   231,   190,   177,   178,   181,   186,
     187,   115,    85,   267,    84,    82,    86,   252,   102,   108,
      83,     0,     0,     0,   118,   119,     0,   290,    78,   106,
      26,    64,    66,    68,    70,   263,   179,   184,   150,     0,
       0,   100,   101,   196,   198,     0,    76,     0,     0,     0,
     338,   336,     0,     0,     0,   349,     0,     0,     0,     0,
       0,     0,   257,   256,     0,   255,   254,   288,   289,    35,
       0,    40,     0,   172,   310,   303,   311,   312,   313,   301,
       0,   351,     0,   347,   345,     0,   350,   352,   353,   344,
     355,     0,   262,     0,     0,     0,   348,   346,     0,    36,
       0,    41,     0,   302,   261,     0,     0,    37,     0,    42,
       0,     0,     0,    38,    43,     0,     0,    44
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -428,  -428,  -428,    -6,   263,  -428,  -428,  -428,  -428,  -428,
    -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,  -428,   -34,
     280,    50,   803,   481,  -428,   -13,   -16,  -428,    -7,   581,
    -428,    44,    38,  -298,   320,   419,   714,  -276,  -428,   641,
    -357,  -427,  -428,     0,  -183,  -428,  -147,  -428,    10,  -428,
    -428,   666,  -428,  -392,  -428,  -428,   174,  -120
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
       0,   105,   106,   146,   107,   108,   109,   110,   111,   405,
     112,   113,   114,   115,   116,   117,   118,   119,   120,   228,
     276,   234,   149,   303,   201,   202,   136,   189,   190,   172,
     475,   196,   197,   516,   198,   517,   137,   179,   180,   138,
     543,   549,   550,   434,   435,   531,   532,   139,   304,   474,
     140,   181,   554,   121,   556,   347,   497,   498
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
     151,   153,   154,   142,   147,   158,   160,   188,   510,   613,
     231,   675,   614,   555,   204,   402,   184,   187,   193,   195,
     200,   203,   205,   682,   143,   144,   210,   212,   173,   262,
     230,   217,   219,   221,   676,   224,   227,   229,   544,   232,
     668,   236,   704,   173,   173,   173,   245,   247,   669,   250,
     142,   252,   254,   256,   258,   559,   261,   176,   182,   183,
     265,   267,   270,   271,   272,   705,   274,   207,   724,   142,
     602,   143,   144,   521,   522,   603,   285,   525,   288,   290,
     291,   218,   294,   296,   297,   142,   226,   302,   306,   307,
     143,   144,   311,   313,   321,   233,  -232,   348,   350,   142,
     275,   253,   255,   257,   259,   536,   143,   144,   142,   536,
     643,   268,   279,   173,   173,   637,   142,  -232,  -232,   641,
     143,   144,   359,   360,   277,   278,   142,   280,   157,   143,
     144,   142,   361,   122,   123,   124,   125,   143,   144,   362,
     126,   127,   128,   363,   364,   322,   365,   143,   144,   142,
     352,   354,   143,   144,   157,   356,   386,   683,   685,   142,
     122,   123,   124,   125,   401,   393,   377,   126,   127,   128,
     143,   144,   148,   129,   130,   131,   132,   133,   542,   384,
     143,   144,  -237,   388,   145,   389,   390,   142,   449,   553,
     392,   357,   358,   359,   360,   491,   511,   492,   493,   643,
     396,   505,   398,   399,   494,   495,   506,   400,   143,   144,
     404,   507,   406,   492,   493,   102,   686,   409,   563,   410,
     494,   495,   411,   596,   564,   413,   496,   192,   414,   415,
     560,   416,   418,   607,   420,   157,   694,   423,   695,   597,
     425,   598,   426,   427,   599,   428,   394,   429,   395,   430,
     150,   431,   600,   432,   687,   688,   437,   696,   697,   698,
     440,   601,   441,   442,   642,   684,   152,   443,   226,   646,
     445,   446,   447,   448,   412,   450,   451,   608,   453,   357,
     358,   359,   360,   611,   718,   612,   457,   458,   647,   310,
     643,   546,   643,   667,   464,   681,   699,   465,   529,   466,
     142,   700,   467,   469,   471,   461,   472,   671,   701,   357,
     358,   359,   360,   530,   481,   129,   130,   131,   132,   133,
     703,   143,   144,   706,   473,   476,   167,   707,   479,   168,
     312,   708,   709,   134,   356,   169,   170,   171,   710,   177,
     177,   177,   185,   508,   715,   509,   716,   547,   206,   177,
     717,   122,   123,   124,   125,   723,   216,   142,   126,   127,
     128,   269,   519,   520,   129,   130,   131,   132,   133,   353,
     242,   188,   300,   129,   130,   131,   132,   133,   143,   144,
     540,   260,   537,   655,   633,   548,   266,   622,   142,     0,
    -237,  -237,  -237,  -237,     0,     0,   552,  -237,  -237,  -237,
     142,   557,   558,  -237,  -237,  -237,  -237,  -237,   147,   143,
     144,   142,   524,     0,     0,   129,   130,   131,   132,   133,
       0,   143,   144,   129,   130,   131,   132,   133,   565,     0,
     159,   161,   143,   144,     0,   541,   129,   130,   131,   132,
     133,   142,     0,   572,     0,   142,   573,     0,   574,   575,
     576,     0,     0,   577,   578,   580,   582,   220,   222,     0,
       0,     0,   143,   144,     0,     0,   143,   144,   587,   589,
       0,   590,   591,   592,   593,   134,   595,   570,   142,   122,
     123,   124,   125,   142,     0,     0,   126,   127,   128,     0,
       0,     0,   129,   130,   131,   132,   133,     0,     0,   143,
     144,   286,   287,   289,   143,   144,   583,   295,     0,   298,
     623,     0,   625,     0,     0,   626,   627,     0,   628,   629,
    -223,   630,   631,   142,   134,   632,   548,   157,   -77,   305,
     548,   634,   635,   134,     0,   636,   135,   638,   639,   640,
       0,  -223,  -223,   644,   143,   144,     0,   645,     0,     0,
     648,     0,     0,   649,   650,   651,   652,   653,   654,     0,
    -227,     0,   656,  -237,   657,   658,   314,   315,   316,     0,
     317,   318,   319,   235,  -227,  -237,   148,   661,   662,   663,
     664,  -227,  -227,     0,   157,  -232,     0,     0,   666,     0,
       0,   378,     0,   243,     0,   379,   380,   381,   665,  -212,
       0,   382,   383,     0,     0,   385,  -232,  -232,   142,     0,
     546,   588,     0,   391,   213,   214,   215,   380,  -237,     0,
    -212,  -212,   320,     0,     0,     0,   397,   548,     0,   143,
     144,   594,     0,     0,   403,     0,   477,   478,     0,   480,
       0,     0,   482,   371,   372,   374,   375,   376,     0,     0,
     155,   156,   134,   689,   691,     0,   417,     0,   419,   693,
     421,   422,   387,   424,     0,   604,   547,   141,     0,     0,
     606,     0,     0,     0,   610,   141,   141,     0,     0,   615,
     616,   223,   492,   493,   349,   351,     0,   518,     0,   494,
     495,     0,   444,     0,   177,   548,   527,     0,     0,   157,
     534,     0,     0,   538,     0,     0,   141,   719,   721,     0,
       0,   605,   129,   130,   131,   132,   133,   545,   463,   727,
     729,     0,   284,     0,   157,   733,   734,   468,   470,     0,
     737,     0,     0,   178,   178,   178,   186,   191,     0,   178,
       0,     0,   186,   178,   438,   439,     0,   141,     0,     0,
     186,   178,   292,   293,     0,   225,     0,     0,   568,   177,
       0,   237,   239,   241,   186,   244,   246,   248,   346,     0,
       0,   178,   178,   178,   178,   186,   355,     0,     0,   670,
     186,   178,   672,   674,   168,   677,   678,   680,     0,     0,
     169,   170,   171,     0,     0,     0,   366,   367,     0,     0,
     368,   141,   369,     0,   122,   123,   124,   125,     0,     0,
       0,   126,   127,   128,     0,     0,   162,   163,   164,   165,
     166,   141,   141,     0,     0,   141,     0,   141,     0,     0,
       0,   492,   493,   208,   209,     0,     0,   624,   494,   495,
       0,   122,   123,   124,   125,     0,     0,   702,   126,   127,
     128,   238,   240,   566,     0,     0,     0,   249,     0,   251,
     609,   407,     0,   408,   492,   493,   370,   263,   264,   168,
       0,   494,   495,     0,   273,   169,   170,   171,     0,   579,
     581,   281,   282,   283,     0,     0,   141,   142,   141,   122,
     123,   124,   125,   673,   299,   174,   126,   127,   128,   308,
     309,     0,   129,   130,   131,   132,   133,     0,   143,   144,
     142,     0,  -237,  -237,  -237,  -237,   178,     0,   178,  -237,
    -237,  -237,     0,     0,   452,     0,   436,   454,   455,     0,
     456,   143,   144,     0,   492,   493,     0,   373,     0,   462,
     168,   494,   495,   679,   178,     0,   169,   170,   171,   141,
       0,     0,   141,   141,     0,   141,   566,     0,     0,   459,
       0,     0,     0,     0,   141,   122,   123,   124,   125,   529,
       0,     0,   126,   127,   128,     0,     0,     0,   129,   130,
     131,   132,   133,     0,   530,     0,     0,     0,     0,   489,
     490,     0,     0,   503,   504,     0,   142,     0,   512,   513,
     514,   515,     0,     0,   712,     0,   433,     0,     0,   460,
       0,  -237,  -237,  -237,  -237,  -237,     0,   143,   144,   528,
       0,     0,     0,   141,   141,   141,   141,     0,     0,   211,
     186,   186,   168,   186,     0,     0,   186,     0,   169,   170,
     171,     0,     0,     0,   141,   533,     0,     0,   436,   157,
     143,   144,   539,   142,     0,   122,   123,   124,   125,   175,
       0,     0,   126,   127,   128,     0,     0,   551,     0,     0,
     357,   358,   359,   360,   143,   144,     0,  -237,   690,   692,
       0,   186,     0,     0,     0,   571,     0,     0,   178,     0,
     186,     0,     0,     0,   186,     0,     0,   186,     0,   122,
     123,   124,   125,     0,   584,   178,   126,   127,   128,     0,
     141,   186,   129,   130,   131,   132,   133,     0,     0,   122,
     123,   124,   125,     0,     0,     0,   126,   127,   128,   141,
       0,     0,   720,   722,   585,   157,   586,     0,   134,     0,
       0,     0,     0,     0,   728,   730,   357,   358,   359,   360,
     135,   735,   186,   178,   122,   123,   124,   125,     0,     0,
     174,   126,   127,   128,     0,     0,     0,   129,   130,   131,
     132,   133,     0,   621,     0,     0,   178,   142,     0,   122,
     123,   124,   125,     0,     0,   174,   126,   127,   128,     0,
       0,     0,   129,   130,   131,   132,   133,   533,   143,   144,
     526,     0,   122,   123,   124,   125,     0,     0,   551,   126,
     127,   128,   551,     0,     0,   129,   130,   131,   132,   133,
       0,     0,   561,     0,   562,   142,     0,  -216,  -216,  -216,
    -216,   186,   436,  -216,  -216,  -216,  -216,     0,   199,     0,
    -216,  -216,  -216,  -216,  -216,     0,   143,   144,     0,   142,
       0,   122,   123,   124,   125,     0,     0,   174,   126,   127,
     128,     0,     0,     0,   129,   130,   131,   132,   133,   175,
     143,   144,   483,   484,   485,   486,   487,   488,     0,     0,
     357,   358,   359,   360,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   659,     0,   660,   142,     0,     0,  -237,
       0,     0,     0,     0,   142,  -237,  -237,  -237,     0,   551,
       0,  -237,  -237,  -237,  -237,  -237,     0,   143,   144,   129,
     130,   131,   132,   133,   175,   143,   144,     0,     0,     0,
       0,   142,     0,  -237,  -237,  -237,  -237,     0,     0,     0,
    -237,  -237,  -237,     0,     0,     0,     0,   301,     0,   175,
     168,     0,   143,   144,   194,     0,   169,   170,   171,     0,
       0,     0,     0,     0,     0,     0,     0,   168,   143,   144,
       0,     0,   175,   169,   170,   171,     0,   551,     0,   129,
     130,   131,   132,   133,  -212,     0,  -212,  -212,  -212,  -212,
       0,     0,  -212,  -212,  -212,  -212,     0,  -216,   186,  -212,
    -212,  -212,  -212,  -212,   713,     0,   714,   142,     0,   122,
     123,   124,   125,     0,     0,     0,   126,   127,   128,     0,
       0,   175,   129,   130,   131,   132,   133,     0,   143,   144,
       0,     0,     1,     0,   725,   157,   726,     0,     2,     0,
       0,     0,   731,     0,   732,     0,     0,     3,     0,   736,
       4,     5,     6,     7,     8,     9,    10,    11,    12,    13,
      14,    15,    16,    17,    18,    19,    20,    21,    22,    23,
     157,     0,    24,    25,    26,    27,    28,     0,    29,    30,
      31,    32,    33,    34,    35,    36,    37,    38,    39,    40,
      41,    42,    43,    44,    45,    46,    47,    48,    49,    50,
      51,    52,    53,    54,    55,    56,    57,    58,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    68,    69,    70,
      71,    72,    73,    74,    75,    76,    77,    78,    79,    80,
      81,    82,    83,    84,    85,    86,    87,    88,    89,    90,
      91,    92,    93,    94,     0,    95,    96,    97,    98,    99,
     100,     0,     0,     0,     0,     0,  -212,   523,   101,   122,
     123,   124,   125,     0,     0,   174,   126,   127,   128,     0,
       0,     0,   129,   130,   131,   132,   133,     0,     0,   175,
       0,     0,     0,     0,   122,   123,   124,   125,     0,     1,
     535,   126,   127,   128,     0,     2,     0,   102,     0,     0,
       0,     0,     0,     0,     0,   103,   104,     4,     5,     6,
       7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
      17,    18,    19,    20,    21,    22,    23,     0,     0,    24,
      25,    26,    27,    28,     0,    29,    30,    31,    32,    33,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43,
      44,    45,    46,    47,    48,    49,    50,    51,    52,    53,
      54,    55,    56,    57,    58,    59,    60,    61,    62,    63,
      64,    65,    66,    67,    68,    69,    70,    71,    72,    73,
      74,    75,    76,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    86,    87,    88,    89,    90,    91,    92,    93,
      94,     0,    95,    96,    97,    98,    99,   100,   569,     0,
     122,   123,   124,   125,     0,   101,   174,   126,   127,   128,
       0,     0,     0,   129,   130,   131,   132,   133,   567,   175,
     122,   123,   124,   125,     0,     0,     0,   126,   127,   128,
       0,     0,     0,   129,   130,   131,   132,   133,     0,     0,
       0,   122,   123,   124,   125,     0,     0,     0,   126,   127,
     128,     0,   103,   104,   129,   130,   131,   132,   133,   122,
     123,   124,   125,     0,     0,     0,   126,   127,   128,     0,
       0,     0,   129,   130,   131,   132,   133,     0,     0,     0,
       0,     0,     0,     0,   122,   123,   124,   125,     0,     0,
       0,   126,   127,   128,   122,   123,   124,   125,     0,     0,
       0,   126,   127,   128,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   122,   123,   124,   125,     0,     0,     0,
     126,   127,   128,     0,     0,     0,     0,   122,   123,   124,
     125,     0,     0,     0,   126,   127,   128,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     175,     0,   711,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     175,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   175,     0,     0,     0,   323,     0,   324,   325,     0,
       0,   326,     0,   327,     0,   328,     0,     0,     0,   175,
     329,   330,   331,   332,   333,   334,   335,   336,   337,   338,
     339,   340,   341,   342,   343,   344,   345,   499,     0,     0,
     500,     0,     0,     0,     0,     0,     0,     0,     0,   501,
       0,   502,   617,   618,     0,     0,     0,     0,     0,   494,
     619,   620
};

static const yytype_int16 yycheck[] =
{
       6,     7,     8,     1,     1,    11,    12,    23,     1,   140,
      44,   143,   143,   405,    27,     1,    22,    23,    24,    25,
      26,    27,    28,     1,    22,    23,    32,    33,    18,    63,
      43,    37,    38,    39,   166,    41,    42,    43,   395,    45,
     138,    47,   143,    33,    34,    35,    52,    53,   146,    55,
       1,    57,    58,    59,    60,   412,    62,    19,    20,    21,
      66,    67,    68,    69,    70,   166,    72,    29,   135,     1,
     135,    22,    23,   371,   372,   140,    82,   375,    84,    85,
      86,    37,    88,    89,    90,     1,   170,    93,    94,    95,
      22,    23,    98,    99,   100,   171,     1,   103,   104,     1,
     170,    57,    58,    59,    60,   381,    22,    23,     1,   385,
     177,    67,   168,   103,   104,   542,     1,    22,    23,   546,
      22,    23,   186,   187,    74,    75,     1,   168,   140,    22,
      23,     1,   138,     3,     4,     5,     6,    22,    23,   145,
      10,    11,    12,   149,   150,    21,   152,    22,    23,     1,
       0,    22,    22,    23,   140,   176,    21,   135,     1,     1,
       3,     4,     5,     6,    15,    14,   172,    10,    11,    12,
      22,    23,   169,    16,    17,    18,    19,    20,    15,   185,
      22,    23,   168,   189,   182,   191,   192,     1,   168,   168,
     196,   184,   185,   186,   187,   140,   189,   138,   139,   177,
     206,   140,   208,   209,   145,   146,   140,   213,    22,    23,
     216,   140,   218,   138,   139,   172,   643,   223,   173,   225,
     145,   146,   228,   135,   173,   231,   167,   178,   234,   235,
     174,   237,   238,   166,   240,   140,   137,   243,   139,   135,
     246,   135,   248,   249,   135,   251,   202,   253,   204,   255,
     182,   257,   135,   259,   646,   647,   262,   158,   159,   160,
     266,   135,   268,   269,   174,   191,   182,   273,   170,   141,
     276,   277,   278,   279,   230,   281,   282,   140,   284,   184,
     185,   186,   187,   140,   711,   140,   292,   293,   141,   182,
     177,   134,   177,   140,   300,   140,   135,   303,   168,   305,
       1,   135,   308,   309,   310,   295,   312,   166,   143,   184,
     185,   186,   187,   183,   320,    16,    17,    18,    19,    20,
     143,    22,    23,   143,   314,   315,     1,   143,   318,     4,
     182,   143,   143,   176,   176,    10,    11,    12,   139,    19,
      20,    21,    22,   349,   140,   351,   143,   190,    28,    29,
     143,     3,     4,     5,     6,   139,    36,     1,    10,    11,
      12,   175,   368,   369,    16,    17,    18,    19,    20,   106,
      50,   387,    92,    16,    17,    18,    19,    20,    22,    23,
     387,    61,   382,   566,   531,   401,    66,   507,     1,    -1,
       3,     4,     5,     6,    -1,    -1,   402,    10,    11,    12,
       1,   407,   408,    16,    17,    18,    19,    20,     1,    22,
      23,     1,   374,    -1,    -1,    16,    17,    18,    19,    20,
      -1,    22,    23,    16,    17,    18,    19,    20,   434,    -1,
      11,    12,    22,    23,    -1,   391,    16,    17,    18,    19,
      20,     1,    -1,   449,    -1,     1,   452,    -1,   454,   455,
     456,    -1,    -1,   459,   460,   461,   462,    38,    39,    -1,
      -1,    -1,    22,    23,    -1,    -1,    22,    23,   474,   475,
      -1,   477,   478,   479,   480,   176,   482,   439,     1,     3,
       4,     5,     6,     1,    -1,    -1,    10,    11,    12,    -1,
      -1,    -1,    16,    17,    18,    19,    20,    -1,    -1,    22,
      23,    82,    83,    84,    22,    23,   462,    88,    -1,    90,
     516,    -1,   518,    -1,    -1,   521,   522,    -1,   524,   525,
       1,   527,   528,     1,   176,   531,   542,   140,   172,   119,
     546,   537,   538,   176,    -1,   541,   188,   543,   544,   545,
      -1,    22,    23,   549,    22,    23,    -1,   553,    -1,    -1,
     556,    -1,    -1,   559,   560,   561,   562,   563,   564,    -1,
       1,    -1,   568,   176,   570,   571,   126,   127,   128,    -1,
     130,   131,   132,   174,    15,   188,   169,   583,   584,   585,
     586,    22,    23,    -1,   140,     1,    -1,    -1,   594,    -1,
      -1,   172,    -1,   173,    -1,   176,   177,   178,   588,     1,
      -1,   182,   183,    -1,    -1,   186,    22,    23,     1,    -1,
     134,   129,    -1,   194,    33,    34,    35,   198,   174,    -1,
      22,    23,   182,    -1,    -1,    -1,   207,   643,    -1,    22,
      23,    24,    -1,    -1,   215,    -1,   316,   317,    -1,   319,
      -1,    -1,   322,   162,   163,   164,   165,   166,    -1,    -1,
       9,    10,   176,   659,   660,    -1,   237,    -1,   239,   665,
     241,   242,   140,   244,    -1,   491,   190,     1,    -1,    -1,
     496,    -1,    -1,    -1,   500,     9,    10,    -1,    -1,   505,
     506,    40,   138,   139,   103,   104,    -1,   367,    -1,   145,
     146,    -1,   273,    -1,   374,   711,   376,    -1,    -1,   140,
     380,    -1,    -1,   383,    -1,    -1,    40,   713,   714,    -1,
      -1,   167,    16,    17,    18,    19,    20,   397,   299,   725,
     726,    -1,    81,    -1,   140,   731,   732,   308,   309,    -1,
     736,    -1,    -1,    19,    20,    21,    22,    23,    -1,    25,
      -1,    -1,    28,    29,   263,   264,    -1,    81,    -1,    -1,
      36,    37,    86,    87,    -1,    41,    -1,    -1,   438,   439,
      -1,    47,    48,    49,    50,    51,    52,    53,   102,    -1,
      -1,    57,    58,    59,    60,    61,   135,    -1,    -1,   605,
      66,    67,   608,   609,     4,   611,   612,   613,    -1,    -1,
      10,    11,    12,    -1,    -1,    -1,   155,   156,    -1,    -1,
     159,   135,   161,    -1,     3,     4,     5,     6,    -1,    -1,
      -1,    10,    11,    12,    -1,    -1,    13,    14,    15,    16,
      17,   155,   156,    -1,    -1,   159,    -1,   161,    -1,    -1,
      -1,   138,   139,    30,    31,    -1,    -1,   517,   145,   146,
      -1,     3,     4,     5,     6,    -1,    -1,   673,    10,    11,
      12,    48,    49,   434,    -1,    -1,    -1,    54,    -1,    56,
     167,   220,    -1,   222,   138,   139,     1,    64,    65,     4,
      -1,   145,   146,    -1,    71,    10,    11,    12,    -1,   460,
     461,    78,    79,    80,    -1,    -1,   220,     1,   222,     3,
       4,     5,     6,   167,    91,     9,    10,    11,    12,    96,
      97,    -1,    16,    17,    18,    19,    20,    -1,    22,    23,
       1,    -1,     3,     4,     5,     6,   202,    -1,   204,    10,
      11,    12,    -1,    -1,   283,    -1,   260,   286,   287,    -1,
     289,    22,    23,    -1,   138,   139,    -1,     1,    -1,   298,
       4,   145,   146,   147,   230,    -1,    10,    11,    12,   283,
      -1,    -1,   286,   287,    -1,   289,   537,    -1,    -1,   293,
      -1,    -1,    -1,    -1,   298,     3,     4,     5,     6,   168,
      -1,    -1,    10,    11,    12,    -1,    -1,    -1,    16,    17,
      18,    19,    20,    -1,   183,    -1,    -1,    -1,    -1,   323,
     324,    -1,    -1,   327,   328,    -1,     1,    -1,   357,   358,
     359,   360,    -1,    -1,   684,    -1,   168,    -1,    -1,   295,
      -1,    16,    17,    18,    19,    20,    -1,    22,    23,   378,
      -1,    -1,    -1,   357,   358,   359,   360,    -1,    -1,     1,
     316,   317,     4,   319,    -1,    -1,   322,    -1,    10,    11,
      12,    -1,    -1,    -1,   378,   379,    -1,    -1,   382,   140,
      22,    23,   386,     1,    -1,     3,     4,     5,     6,   173,
      -1,    -1,    10,    11,    12,    -1,    -1,   401,    -1,    -1,
     184,   185,   186,   187,    22,    23,    -1,   168,   659,   660,
      -1,   367,    -1,    -1,    -1,   444,    -1,    -1,   374,    -1,
     376,    -1,    -1,    -1,   380,    -1,    -1,   383,    -1,     3,
       4,     5,     6,    -1,   463,   391,    10,    11,    12,    -1,
     444,   397,    16,    17,    18,    19,    20,    -1,    -1,     3,
       4,     5,     6,    -1,    -1,    -1,    10,    11,    12,   463,
      -1,    -1,   713,   714,   468,   140,   470,    -1,   176,    -1,
      -1,    -1,    -1,    -1,   725,   726,   184,   185,   186,   187,
     188,   732,   438,   439,     3,     4,     5,     6,    -1,    -1,
       9,    10,    11,    12,    -1,    -1,    -1,    16,    17,    18,
      19,    20,    -1,   507,    -1,    -1,   462,     1,    -1,     3,
       4,     5,     6,    -1,    -1,     9,    10,    11,    12,    -1,
      -1,    -1,    16,    17,    18,    19,    20,   531,    22,    23,
       1,    -1,     3,     4,     5,     6,    -1,    -1,   542,    10,
      11,    12,   546,    -1,    -1,    16,    17,    18,    19,    20,
      -1,    -1,   419,    -1,   421,     1,    -1,     3,     4,     5,
       6,   517,   566,     9,    10,    11,    12,    -1,    14,    -1,
      16,    17,    18,    19,    20,    -1,    22,    23,    -1,     1,
      -1,     3,     4,     5,     6,    -1,    -1,     9,    10,    11,
      12,    -1,    -1,    -1,    16,    17,    18,    19,    20,   173,
      22,    23,   156,   157,   158,   159,   160,   161,    -1,    -1,
     184,   185,   186,   187,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,   579,    -1,   581,     1,    -1,    -1,     4,
      -1,    -1,    -1,    -1,     1,    10,    11,    12,    -1,   643,
      -1,    16,    17,    18,    19,    20,    -1,    22,    23,    16,
      17,    18,    19,    20,   173,    22,    23,    -1,    -1,    -1,
      -1,     1,    -1,     3,     4,     5,     6,    -1,    -1,    -1,
      10,    11,    12,    -1,    -1,    -1,    -1,     1,    -1,   173,
       4,    -1,    22,    23,   178,    -1,    10,    11,    12,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,     4,    22,    23,
      -1,    -1,   173,    10,    11,    12,    -1,   711,    -1,    16,
      17,    18,    19,    20,     1,    -1,     3,     4,     5,     6,
      -1,    -1,     9,    10,    11,    12,    -1,   173,   684,    16,
      17,    18,    19,    20,   690,    -1,   692,     1,    -1,     3,
       4,     5,     6,    -1,    -1,    -1,    10,    11,    12,    -1,
      -1,   173,    16,    17,    18,    19,    20,    -1,    22,    23,
      -1,    -1,     7,    -1,   720,   140,   722,    -1,    13,    -1,
      -1,    -1,   728,    -1,   730,    -1,    -1,    22,    -1,   735,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
     140,    -1,    47,    48,    49,    50,    51,    -1,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   118,    -1,   120,   121,   122,   123,   124,
     125,    -1,    -1,    -1,    -1,    -1,   173,     1,   133,     3,
       4,     5,     6,    -1,    -1,     9,    10,    11,    12,    -1,
      -1,    -1,    16,    17,    18,    19,    20,    -1,    -1,   173,
      -1,    -1,    -1,    -1,     3,     4,     5,     6,    -1,     7,
       9,    10,    11,    12,    -1,    13,    -1,   172,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,   180,   181,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    44,    -1,    -1,    47,
      48,    49,    50,    51,    -1,    53,    54,    55,    56,    57,
      58,    59,    60,    61,    62,    63,    64,    65,    66,    67,
      68,    69,    70,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    81,    82,    83,    84,    85,    86,    87,
      88,    89,    90,    91,    92,    93,    94,    95,    96,    97,
      98,    99,   100,   101,   102,   103,   104,   105,   106,   107,
     108,   109,   110,   111,   112,   113,   114,   115,   116,   117,
     118,    -1,   120,   121,   122,   123,   124,   125,     1,    -1,
       3,     4,     5,     6,    -1,   133,     9,    10,    11,    12,
      -1,    -1,    -1,    16,    17,    18,    19,    20,     1,   173,
       3,     4,     5,     6,    -1,    -1,    -1,    10,    11,    12,
      -1,    -1,    -1,    16,    17,    18,    19,    20,    -1,    -1,
      -1,     3,     4,     5,     6,    -1,    -1,    -1,    10,    11,
      12,    -1,   180,   181,    16,    17,    18,    19,    20,     3,
       4,     5,     6,    -1,    -1,    -1,    10,    11,    12,    -1,
      -1,    -1,    16,    17,    18,    19,    20,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,     3,     4,     5,     6,    -1,    -1,
      -1,    10,    11,    12,     3,     4,     5,     6,    -1,    -1,
      -1,    10,    11,    12,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,     3,     4,     5,     6,    -1,    -1,    -1,
      10,    11,    12,    -1,    -1,    -1,    -1,     3,     4,     5,
       6,    -1,    -1,    -1,    10,    11,    12,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     173,    -1,   134,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     173,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,   173,    -1,    -1,    -1,   134,    -1,   136,   137,    -1,
      -1,   140,    -1,   142,    -1,   144,    -1,    -1,    -1,   173,
     149,   150,   151,   152,   153,   154,   155,   156,   157,   158,
     159,   160,   161,   162,   163,   164,   165,   137,    -1,    -1,
     140,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   149,
      -1,   151,   138,   139,    -1,    -1,    -1,    -1,    -1,   145,
     146,   147
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     7,    13,    22,    25,    26,    27,    28,    29,    30,
      31,    32,    33,    34,    35,    36,    37,    38,    39,    40,
      41,    42,    43,    44,    47,    48,    49,    50,    51,    53,
      54,    55,    56,    57,    58,    59,    60,    61,    62,    63,
      64,    65,    66,    67,    68,    69,    70,    71,    72,    73,
      74,    75,    76,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    86,    87,    88,    89,    90,    91,    92,    93,
      94,    95,    96,    97,    98,    99,   100,   101,   102,   103,
     104,   105,   106,   107,   108,   109,   110,   111,   112,   113,
     114,   115,   116,   117,   118,   120,   121,   122,   123,   124,
     125,   133,   172,   180,   181,   193,   194,   196,   197,   198,
     199,   200,   202,   203,   204,   205,   206,   207,   208,   209,
     210,   245,     3,     4,     5,     6,    10,    11,    12,    16,
      17,    18,    19,    20,   176,   188,   218,   228,   231,   239,
     242,   243,     1,    22,    23,   182,   195,     1,   169,   214,
     182,   195,   182,   195,   195,   231,   231,   140,   195,   227,
     195,   227,   214,   214,   214,   214,   214,     1,     4,    10,
      11,    12,   221,   240,     9,   173,   224,   226,   228,   229,
     230,   243,   224,   224,   195,   226,   228,   195,   218,   219,
     220,   228,   178,   195,   178,   195,   223,   224,   226,    14,
     195,   216,   217,   195,   217,   195,   226,   224,   214,   214,
     195,     1,   195,   221,   221,   221,   226,   195,   223,   195,
     227,   195,   227,   231,   195,   228,   170,   195,   211,   195,
     217,   211,   195,   171,   213,   174,   195,   228,   214,   228,
     214,   228,   226,   173,   228,   195,   228,   195,   228,   214,
     195,   214,   195,   223,   195,   223,   195,   223,   195,   223,
     226,   195,   211,   214,   214,   195,   226,   195,   223,   175,
     195,   195,   195,   214,   195,   170,   212,   213,   213,   168,
     168,   214,   214,   214,   231,   195,   227,   227,   195,   227,
     195,   195,   243,   243,   195,   227,   195,   195,   227,   214,
     212,     1,   195,   215,   240,   119,   195,   195,   214,   214,
     182,   195,   182,   195,   126,   127,   128,   130,   131,   132,
     182,   195,    21,   134,   136,   137,   140,   142,   144,   149,
     150,   151,   152,   153,   154,   155,   156,   157,   158,   159,
     160,   161,   162,   163,   164,   165,   243,   247,   195,   221,
     195,   221,     0,   196,    22,   231,   176,   184,   185,   186,
     187,   195,   195,   195,   195,   195,   231,   231,   231,   231,
       1,   215,   215,     1,   215,   215,   215,   195,   227,   227,
     227,   227,   227,   227,   195,   227,    21,   140,   195,   195,
     195,   227,   195,    14,   223,   223,   195,   227,   195,   195,
     195,    15,     1,   227,   195,   201,   195,   231,   231,   195,
     195,   195,   223,   195,   195,   195,   195,   227,   195,   227,
     195,   227,   227,   195,   227,   195,   195,   195,   195,   195,
     195,   195,   195,   168,   235,   236,   243,   195,   215,   215,
     195,   195,   195,   195,   227,   195,   195,   195,   195,   168,
     195,   195,   231,   195,   231,   231,   231,   195,   195,   243,
     228,   240,   231,   227,   195,   195,   195,   195,   227,   195,
     227,   195,   195,   240,   241,   222,   240,   226,   226,   240,
     226,   195,   226,   156,   157,   158,   159,   160,   161,   243,
     243,   140,   138,   139,   145,   146,   167,   248,   249,   137,
     140,   149,   151,   243,   243,   140,   140,   140,   195,   195,
       1,   189,   231,   231,   231,   231,   225,   227,   226,   195,
     195,   225,   225,     1,   224,   225,     1,   226,   231,   168,
     183,   237,   238,   243,   226,     9,   229,   235,   226,   243,
     220,   223,    15,   232,   232,   226,   134,   190,   218,   233,
     234,   243,   195,   168,   244,   245,   246,   195,   195,   232,
     174,   214,   214,   173,   173,   195,   227,     1,   226,     1,
     224,   231,   195,   195,   195,   195,   195,   195,   195,   227,
     195,   227,   195,   223,   231,   243,   243,   195,   129,   195,
     195,   195,   195,   195,    24,   195,   135,   135,   135,   135,
     135,   135,   135,   140,   248,   167,   248,   166,   140,   167,
     248,   140,   140,   140,   143,   248,   248,   138,   139,   146,
     147,   243,   249,   195,   226,   195,   195,   195,   195,   195,
     195,   195,   195,   238,   195,   195,   195,   233,   195,   195,
     195,   233,   174,   177,   195,   195,   141,   141,   195,   195,
     195,   195,   195,   195,   195,   236,   195,   195,   195,   228,
     228,   195,   195,   195,   195,   240,   195,   140,   138,   146,
     248,   166,   248,   167,   248,   143,   166,   248,   248,   147,
     248,   140,     1,   135,   191,     1,   233,   245,   245,   195,
     227,   195,   227,   195,   137,   139,   158,   159,   160,   135,
     135,   143,   248,   143,   143,   166,   143,   143,   143,   143,
     139,   134,   226,   228,   228,   140,   143,   143,   233,   195,
     227,   195,   227,   139,   135,   228,   228,   195,   227,   195,
     227,   228,   228,   195,   195,   227,   228,   195
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_uint8 yyr1[] =
{
       0,   192,   193,   193,   193,   194,   194,   195,   195,   195,
     196,   196,   196,   196,   196,   196,   196,   196,   196,   196,
     196,   196,   196,   197,   197,   197,   197,   197,   197,   197,
     197,   197,   197,   197,   197,   197,   197,   197,   197,   197,
     197,   197,   197,   197,   197,   197,   197,   197,   197,   197,
     197,   197,   197,   197,   197,   197,   197,   197,   197,   197,
     197,   198,   198,   198,   199,   199,   199,   199,   199,   199,
     199,   199,   199,   199,   199,   199,   199,   201,   200,   200,
     200,   200,   202,   202,   202,   202,   202,   202,   202,   202,
     202,   202,   202,   202,   202,   202,   202,   202,   202,   202,
     202,   202,   203,   203,   203,   203,   203,   203,   203,   203,
     204,   204,   204,   204,   204,   204,   204,   204,   204,   204,
     204,   205,   205,   205,   205,   205,   205,   205,   205,   205,
     205,   205,   205,   205,   205,   205,   205,   206,   206,   206,
     206,   206,   206,   206,   206,   206,   206,   206,   206,   206,
     206,   206,   206,   206,   206,   206,   206,   206,   206,   206,
     206,   206,   206,   206,   206,   206,   206,   206,   206,   206,
     206,   206,   206,   206,   206,   206,   206,   207,   207,   207,
     207,   207,   207,   207,   207,   207,   207,   207,   207,   207,
     207,   207,   207,   207,   207,   207,   207,   207,   207,   208,
     208,   208,   209,   209,   210,   211,   212,   212,   213,   214,
     214,   215,   215,   216,   216,   217,   217,   218,   218,   219,
     219,   220,   221,   221,   222,   222,   223,   223,   224,   224,
     224,   225,   225,   226,   226,   226,   227,   227,   228,   228,
     228,   228,   228,   229,   230,   231,   231,   231,   231,   231,
     231,   231,   232,   232,   233,   233,   233,   233,   233,   234,
     234,   234,   234,   235,   235,   236,   236,   237,   237,   238,
     238,   238,   239,   239,   240,   240,   240,   240,   241,   241,
     242,   242,   242,   243,   243,   243,   243,   243,   244,   244,
     244,   245,   246,   246,   247,   247,   247,   247,   247,   247,
     247,   247,   247,   247,   247,   247,   247,   247,   247,   247,
     247,   247,   247,   247,   247,   247,   247,   247,   247,   247,
     247,   247,   247,   247,   247,   247,   247,   247,   247,   247,
     247,   247,   247,   247,   247,   247,   247,   247,   247,   247,
     247,   247,   247,   247,   247,   247,   247,   247,   247,   247,
     247,   247,   247,   247,   247,   247,   248,   248,   248,   248,
     249
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     2,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     2,     3,     3,     5,     3,     2,     2,
       3,     2,     3,     2,     4,     6,     8,    10,    12,     4,
       6,     8,    10,    12,    14,     2,     3,     3,     2,     4,
       2,     4,     2,     4,     2,     4,     2,     3,     2,     3,
       1,     2,     3,     3,     5,     3,     5,     3,     5,     3,
       5,     3,     2,     3,     2,     4,     5,     0,     5,     3,
       3,     2,     5,     5,     5,     5,     5,     3,     2,     3,
       2,     3,     2,     3,     2,     3,     2,     2,     2,     4,
       5,     5,     5,     2,     3,     2,     5,     2,     5,     2,
       3,     2,     3,     2,     3,     5,     3,     2,     5,     5,
       4,     3,     2,     3,     2,     3,     2,     3,     3,     2,
       2,     3,     2,     2,     2,     2,     3,     3,     3,     2,
       3,     3,     3,     3,     2,     3,     2,     3,     3,     3,
       5,     3,     4,     3,     3,     2,     4,     4,     2,     4,
       2,     3,     2,     4,     3,     3,     3,     2,     3,     2,
       4,     4,     6,     4,     4,     4,     4,     5,     5,     5,
       4,     5,     3,     4,     5,     4,     5,     5,     4,     5,
       5,     2,     3,     4,     3,     3,     5,     3,     5,     3,
       2,     3,     4,     2,     2,     1,     1,     0,     1,     1,
       1,     1,     1,     2,     1,     1,     0,     1,     2,     3,
       1,     3,     1,     1,     1,     0,     1,     1,     3,     1,
       3,     2,     0,     1,     3,     1,     1,     0,     1,     1,
       1,     1,     1,     1,     1,     3,     3,     3,     3,     3,
       3,     1,     2,     0,     3,     3,     3,     3,     1,     1,
       1,     6,     4,     3,     1,     1,     1,     2,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     0,
       1,     1,     1,     1,     1,     1,     1,     1,     3,     3,
       2,     2,     1,     1,     2,     1,     3,     3,     3,     3,
       3,     5,     7,     5,     3,     3,     3,     3,     3,     3,
       5,     5,     5,     5,     0,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     2,     3,     3,     4,     3,     4,     2,
       3,     3,     3,     3,     5,     5,     6,     5,     6,     4,
       5,     5,     5,     5,     3,     5,     1,     1,     1,     1,
       1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* top_level: command_list  */
#line 189 "mon_parse.y"
                        { (yyval.i) = 0; }
#line 2641 "mon_parse.c"
    break;

  case 3: /* top_level: assembly_instruction TRAIL  */
#line 190 "mon_parse.y"
                                      { (yyval.i) = 0; }
#line 2647 "mon_parse.c"
    break;

  case 4: /* top_level: TRAIL  */
#line 191 "mon_parse.y"
                 { new_cmd = 1; asm_mode = 0;  (yyval.i) = 0; }
#line 2653 "mon_parse.c"
    break;

  case 9: /* end_cmd: error  */
#line 200 "mon_parse.y"
               { return ERR_EXPECT_END_CMD; }
#line 2659 "mon_parse.c"
    break;

  case 22: /* command: BAD_CMD  */
#line 215 "mon_parse.y"
                 { return ERR_BAD_CMD; }
#line 2665 "mon_parse.c"
    break;

  case 23: /* machine_state_rules: CMD_BANK end_cmd  */
#line 219 "mon_parse.y"
                     { mon_bank(e_default_space, NULL); }
#line 2671 "mon_parse.c"
    break;

  case 24: /* machine_state_rules: CMD_BANK memspace end_cmd  */
#line 221 "mon_parse.y"
                     { mon_bank((yyvsp[-1].i), NULL); }
#line 2677 "mon_parse.c"
    break;

  case 25: /* machine_state_rules: CMD_BANK BANKNAME end_cmd  */
#line 223 "mon_parse.y"
                     { mon_bank(e_default_space, (yyvsp[-1].str)); }
#line 2683 "mon_parse.c"
    break;

  case 26: /* machine_state_rules: CMD_BANK memspace opt_sep BANKNAME end_cmd  */
#line 225 "mon_parse.y"
                     { mon_bank((yyvsp[-3].i), (yyvsp[-1].str)); }
#line 2689 "mon_parse.c"
    break;

  case 27: /* machine_state_rules: CMD_GOTO address end_cmd  */
#line 227 "mon_parse.y"
                     { mon_jump((yyvsp[-1].a)); }
#line 2695 "mon_parse.c"
    break;

  case 28: /* machine_state_rules: CMD_GOTO end_cmd  */
#line 229 "mon_parse.y"
                     { mon_go(); }
#line 2701 "mon_parse.c"
    break;

  case 29: /* machine_state_rules: CMD_IO end_cmd  */
#line 231 "mon_parse.y"
                     { mon_display_io_regs(0); }
#line 2707 "mon_parse.c"
    break;

  case 30: /* machine_state_rules: CMD_IO address end_cmd  */
#line 233 "mon_parse.y"
                     { mon_display_io_regs((yyvsp[-1].a)); }
#line 2713 "mon_parse.c"
    break;

  case 31: /* machine_state_rules: CMD_CPU end_cmd  */
#line 235 "mon_parse.y"
                     { monitor_cpu_type_set(""); }
#line 2719 "mon_parse.c"
    break;

  case 32: /* machine_state_rules: CMD_CPU CPUTYPE end_cmd  */
#line 237 "mon_parse.y"
                     { monitor_cpu_type_set((yyvsp[-1].str)); }
#line 2725 "mon_parse.c"
    break;

  case 33: /* machine_state_rules: CMD_CPUHISTORY end_cmd  */
#line 239 "mon_parse.y"
                     { mon_cpuhistory(-1, e_invalid_space,  e_invalid_space, e_invalid_space, e_invalid_space, e_invalid_space); }
#line 2731 "mon_parse.c"
    break;

  case 34: /* machine_state_rules: CMD_CPUHISTORY opt_sep memspace end_cmd  */
#line 241 "mon_parse.y"
                     { mon_cpuhistory(-1, (yyvsp[-1].i), e_invalid_space, e_invalid_space, e_invalid_space, e_invalid_space); }
#line 2737 "mon_parse.c"
    break;

  case 35: /* machine_state_rules: CMD_CPUHISTORY opt_sep memspace opt_sep memspace end_cmd  */
#line 243 "mon_parse.y"
                     { mon_cpuhistory(-1, (yyvsp[-3].i), (yyvsp[-1].i), e_invalid_space, e_invalid_space, e_invalid_space); }
#line 2743 "mon_parse.c"
    break;

  case 36: /* machine_state_rules: CMD_CPUHISTORY opt_sep memspace opt_sep memspace opt_sep memspace end_cmd  */
#line 245 "mon_parse.y"
                     { mon_cpuhistory(-1, (yyvsp[-5].i), (yyvsp[-3].i), (yyvsp[-1].i), e_invalid_space, e_invalid_space); }
#line 2749 "mon_parse.c"
    break;

  case 37: /* machine_state_rules: CMD_CPUHISTORY opt_sep memspace opt_sep memspace opt_sep memspace opt_sep memspace end_cmd  */
#line 247 "mon_parse.y"
                     { mon_cpuhistory(-1, (yyvsp[-7].i), (yyvsp[-5].i), (yyvsp[-3].i),  (yyvsp[-1].i), e_invalid_space); }
#line 2755 "mon_parse.c"
    break;

  case 38: /* machine_state_rules: CMD_CPUHISTORY opt_sep memspace opt_sep memspace opt_sep memspace opt_sep memspace opt_sep memspace end_cmd  */
#line 249 "mon_parse.y"
                     { mon_cpuhistory(-1, (yyvsp[-9].i), (yyvsp[-7].i), (yyvsp[-5].i),  (yyvsp[-3].i), (yyvsp[-1].i)); }
#line 2761 "mon_parse.c"
    break;

  case 39: /* machine_state_rules: CMD_CPUHISTORY opt_sep d_number end_cmd  */
#line 251 "mon_parse.y"
                     { mon_cpuhistory((yyvsp[-1].i), e_invalid_space, e_invalid_space, e_invalid_space, e_invalid_space, e_invalid_space); }
#line 2767 "mon_parse.c"
    break;

  case 40: /* machine_state_rules: CMD_CPUHISTORY opt_sep d_number opt_sep memspace end_cmd  */
#line 253 "mon_parse.y"
                     { mon_cpuhistory((yyvsp[-3].i), (yyvsp[-1].i), e_invalid_space, e_invalid_space, e_invalid_space, e_invalid_space); }
#line 2773 "mon_parse.c"
    break;

  case 41: /* machine_state_rules: CMD_CPUHISTORY opt_sep d_number opt_sep memspace opt_sep memspace end_cmd  */
#line 255 "mon_parse.y"
                     { mon_cpuhistory((yyvsp[-5].i), (yyvsp[-3].i), (yyvsp[-1].i), e_invalid_space, e_invalid_space, e_invalid_space); }
#line 2779 "mon_parse.c"
    break;

  case 42: /* machine_state_rules: CMD_CPUHISTORY opt_sep d_number opt_sep memspace opt_sep memspace opt_sep memspace end_cmd  */
#line 257 "mon_parse.y"
                     { mon_cpuhistory((yyvsp[-7].i), (yyvsp[-5].i), (yyvsp[-3].i), (yyvsp[-1].i), e_invalid_space, e_invalid_space); }
#line 2785 "mon_parse.c"
    break;

  case 43: /* machine_state_rules: CMD_CPUHISTORY opt_sep d_number opt_sep memspace opt_sep memspace opt_sep memspace opt_sep memspace end_cmd  */
#line 259 "mon_parse.y"
                     { mon_cpuhistory((yyvsp[-9].i), (yyvsp[-7].i), (yyvsp[-5].i), (yyvsp[-3].i), (yyvsp[-1].i), e_invalid_space); }
#line 2791 "mon_parse.c"
    break;

  case 44: /* machine_state_rules: CMD_CPUHISTORY opt_sep d_number opt_sep memspace opt_sep memspace opt_sep memspace opt_sep memspace opt_sep memspace end_cmd  */
#line 261 "mon_parse.y"
                     { mon_cpuhistory((yyvsp[-11].i), (yyvsp[-9].i), (yyvsp[-7].i), (yyvsp[-5].i), (yyvsp[-3].i), (yyvsp[-1].i)); }
#line 2797 "mon_parse.c"
    break;

  case 45: /* machine_state_rules: CMD_RETURN end_cmd  */
#line 263 "mon_parse.y"
                     { mon_instruction_return(); }
#line 2803 "mon_parse.c"
    break;

  case 46: /* machine_state_rules: CMD_DUMP filename end_cmd  */
#line 265 "mon_parse.y"
                     { mon_write_snapshot((yyvsp[-1].str),0,0,0); /* FIXME */ }
#line 2809 "mon_parse.c"
    break;

  case 47: /* machine_state_rules: CMD_UNDUMP filename end_cmd  */
#line 267 "mon_parse.y"
                     { mon_read_snapshot((yyvsp[-1].str), 0); }
#line 2815 "mon_parse.c"
    break;

  case 48: /* machine_state_rules: CMD_STEP end_cmd  */
#line 269 "mon_parse.y"
                     { mon_instructions_step(-1); }
#line 2821 "mon_parse.c"
    break;

  case 49: /* machine_state_rules: CMD_STEP opt_sep expression end_cmd  */
#line 271 "mon_parse.y"
                     { mon_instructions_step((yyvsp[-1].i)); }
#line 2827 "mon_parse.c"
    break;

  case 50: /* machine_state_rules: CMD_NEXT end_cmd  */
#line 273 "mon_parse.y"
                     { mon_instructions_next(-1); }
#line 2833 "mon_parse.c"
    break;

  case 51: /* machine_state_rules: CMD_NEXT opt_sep expression end_cmd  */
#line 275 "mon_parse.y"
                     { mon_instructions_next((yyvsp[-1].i)); }
#line 2839 "mon_parse.c"
    break;

  case 52: /* machine_state_rules: CMD_UP end_cmd  */
#line 277 "mon_parse.y"
                     { mon_stack_up(-1); }
#line 2845 "mon_parse.c"
    break;

  case 53: /* machine_state_rules: CMD_UP opt_sep expression end_cmd  */
#line 279 "mon_parse.y"
                     { mon_stack_up((yyvsp[-1].i)); }
#line 2851 "mon_parse.c"
    break;

  case 54: /* machine_state_rules: CMD_DOWN end_cmd  */
#line 281 "mon_parse.y"
                     { mon_stack_down(-1); }
#line 2857 "mon_parse.c"
    break;

  case 55: /* machine_state_rules: CMD_DOWN opt_sep expression end_cmd  */
#line 283 "mon_parse.y"
                     { mon_stack_down((yyvsp[-1].i)); }
#line 2863 "mon_parse.c"
    break;

  case 56: /* machine_state_rules: CMD_SCREEN end_cmd  */
#line 285 "mon_parse.y"
                     { mon_display_screen(-1); }
#line 2869 "mon_parse.c"
    break;

  case 57: /* machine_state_rules: CMD_SCREEN address end_cmd  */
#line 287 "mon_parse.y"
                     { mon_display_screen((yyvsp[-1].a)); }
#line 2875 "mon_parse.c"
    break;

  case 58: /* machine_state_rules: CMD_WARP end_cmd  */
#line 289 "mon_parse.y"
                     {
                        mon_out("Warp mode is %s.\n",
                                vsync_get_warp_mode() ? "on" : "off");
                     }
#line 2884 "mon_parse.c"
    break;

  case 59: /* machine_state_rules: CMD_WARP TOGGLE end_cmd  */
#line 294 "mon_parse.y"
                     {
                        vsync_set_warp_mode((((yyvsp[-1].action) == e_TOGGLE) ? (vsync_get_warp_mode() ^ 1) : (yyvsp[-1].action)));
                     }
#line 2892 "mon_parse.c"
    break;

  case 61: /* register_mod: CMD_REGISTERS end_cmd  */
#line 301 "mon_parse.y"
              { (monitor_cpu_for_memspace[default_memspace]->mon_register_print)(default_memspace); }
#line 2898 "mon_parse.c"
    break;

  case 62: /* register_mod: CMD_REGISTERS memspace end_cmd  */
#line 303 "mon_parse.y"
              { (monitor_cpu_for_memspace[(yyvsp[-1].i)]->mon_register_print)((yyvsp[-1].i)); }
#line 2904 "mon_parse.c"
    break;

  case 64: /* symbol_table_rules: CMD_LOAD_LABELS memspace opt_sep filename end_cmd  */
#line 308 "mon_parse.y"
                    {
                        /* What about the memspace? */
                        mon_playback_commands((yyvsp[-1].str),true);
                    }
#line 2913 "mon_parse.c"
    break;

  case 65: /* symbol_table_rules: CMD_LOAD_LABELS filename end_cmd  */
#line 313 "mon_parse.y"
                    {
                        /* What about the memspace? */
                        mon_playback_commands((yyvsp[-1].str),true);
                    }
#line 2922 "mon_parse.c"
    break;

  case 66: /* symbol_table_rules: CMD_SAVE_LABELS memspace opt_sep filename end_cmd  */
#line 318 "mon_parse.y"
                    { mon_save_symbols((yyvsp[-3].i), (yyvsp[-1].str)); }
#line 2928 "mon_parse.c"
    break;

  case 67: /* symbol_table_rules: CMD_SAVE_LABELS filename end_cmd  */
#line 320 "mon_parse.y"
                    { mon_save_symbols(e_default_space, (yyvsp[-1].str)); }
#line 2934 "mon_parse.c"
    break;

  case 68: /* symbol_table_rules: CMD_ADD_LABEL address opt_sep LABEL end_cmd  */
#line 322 "mon_parse.y"
                    { mon_add_name_to_symbol_table((yyvsp[-3].a), (yyvsp[-1].str)); }
#line 2940 "mon_parse.c"
    break;

  case 69: /* symbol_table_rules: CMD_DEL_LABEL LABEL end_cmd  */
#line 324 "mon_parse.y"
                    { mon_remove_name_from_symbol_table(e_default_space, (yyvsp[-1].str)); }
#line 2946 "mon_parse.c"
    break;

  case 70: /* symbol_table_rules: CMD_DEL_LABEL memspace opt_sep LABEL end_cmd  */
#line 326 "mon_parse.y"
                    { mon_remove_name_from_symbol_table((yyvsp[-3].i), (yyvsp[-1].str)); }
#line 2952 "mon_parse.c"
    break;

  case 71: /* symbol_table_rules: CMD_SHOW_LABELS memspace end_cmd  */
#line 328 "mon_parse.y"
                    { mon_print_symbol_table((yyvsp[-1].i)); }
#line 2958 "mon_parse.c"
    break;

  case 72: /* symbol_table_rules: CMD_SHOW_LABELS end_cmd  */
#line 330 "mon_parse.y"
                    { mon_print_symbol_table(e_default_space); }
#line 2964 "mon_parse.c"
    break;

  case 73: /* symbol_table_rules: CMD_CLEAR_LABELS memspace end_cmd  */
#line 332 "mon_parse.y"
                    { mon_clear_symbol_table((yyvsp[-1].i)); }
#line 2970 "mon_parse.c"
    break;

  case 74: /* symbol_table_rules: CMD_CLEAR_LABELS end_cmd  */
#line 334 "mon_parse.y"
                    { mon_clear_symbol_table(e_default_space); }
#line 2976 "mon_parse.c"
    break;

  case 75: /* symbol_table_rules: CMD_LABEL_ASGN EQUALS address end_cmd  */
#line 336 "mon_parse.y"
                    {
                        mon_add_name_to_symbol_table((yyvsp[-1].a), mon_prepend_dot_to_name((yyvsp[-3].str)));
                    }
#line 2984 "mon_parse.c"
    break;

  case 76: /* symbol_table_rules: CMD_LABEL_ASGN EQUALS address LABEL_ASGN_COMMENT end_cmd  */
#line 340 "mon_parse.y"
                    {
                        mon_add_name_to_symbol_table((yyvsp[-2].a), mon_prepend_dot_to_name((yyvsp[-4].str)));
                    }
#line 2992 "mon_parse.c"
    break;

  case 77: /* $@1: %empty  */
#line 346 "mon_parse.y"
           { mon_start_assemble_mode((yyvsp[0].a), NULL); }
#line 2998 "mon_parse.c"
    break;

  case 78: /* asm_rules: CMD_ASSEMBLE address $@1 post_assemble end_cmd  */
#line 347 "mon_parse.y"
           { }
#line 3004 "mon_parse.c"
    break;

  case 79: /* asm_rules: CMD_ASSEMBLE address end_cmd  */
#line 349 "mon_parse.y"
           { mon_start_assemble_mode((yyvsp[-1].a), NULL); }
#line 3010 "mon_parse.c"
    break;

  case 80: /* asm_rules: CMD_DISASSEMBLE address_opt_range end_cmd  */
#line 351 "mon_parse.y"
           { mon_disassemble_lines((yyvsp[-1].range)[0], (yyvsp[-1].range)[1]); }
#line 3016 "mon_parse.c"
    break;

  case 81: /* asm_rules: CMD_DISASSEMBLE end_cmd  */
#line 353 "mon_parse.y"
           { mon_disassemble_lines(BAD_ADDR, BAD_ADDR); }
#line 3022 "mon_parse.c"
    break;

  case 82: /* memory_rules: CMD_MOVE address_range opt_sep address end_cmd  */
#line 357 "mon_parse.y"
              { mon_memory_move((yyvsp[-3].range)[0], (yyvsp[-3].range)[1], (yyvsp[-1].a)); }
#line 3028 "mon_parse.c"
    break;

  case 83: /* memory_rules: CMD_COMPARE address_range opt_sep address end_cmd  */
#line 359 "mon_parse.y"
              { mon_memory_compare((yyvsp[-3].range)[0], (yyvsp[-3].range)[1], (yyvsp[-1].a)); }
#line 3034 "mon_parse.c"
    break;

  case 84: /* memory_rules: CMD_FILL address_range opt_sep data_list end_cmd  */
#line 361 "mon_parse.y"
              { mon_memory_fill((yyvsp[-3].range)[0], (yyvsp[-3].range)[1],(unsigned char *)(yyvsp[-1].str)); }
#line 3040 "mon_parse.c"
    break;

  case 85: /* memory_rules: CMD_HUNT address_range opt_sep hunt_list end_cmd  */
#line 363 "mon_parse.y"
              { mon_memory_hunt((yyvsp[-3].range)[0], (yyvsp[-3].range)[1],(unsigned char *)(yyvsp[-1].str)); }
#line 3046 "mon_parse.c"
    break;

  case 86: /* memory_rules: CMD_MEM_DISPLAY RADIX_TYPE opt_sep address_opt_range end_cmd  */
#line 365 "mon_parse.y"
              { mon_memory_display((yyvsp[-3].rt), (yyvsp[-1].range)[0], (yyvsp[-1].range)[1], DF_PETSCII); }
#line 3052 "mon_parse.c"
    break;

  case 87: /* memory_rules: CMD_MEM_DISPLAY address_opt_range end_cmd  */
#line 367 "mon_parse.y"
              { mon_memory_display(default_radix, (yyvsp[-1].range)[0], (yyvsp[-1].range)[1], DF_PETSCII); }
#line 3058 "mon_parse.c"
    break;

  case 88: /* memory_rules: CMD_MEM_DISPLAY end_cmd  */
#line 369 "mon_parse.y"
              { mon_memory_display(default_radix, BAD_ADDR, BAD_ADDR, DF_PETSCII); }
#line 3064 "mon_parse.c"
    break;

  case 89: /* memory_rules: CMD_CHAR_DISPLAY address_opt_range end_cmd  */
#line 371 "mon_parse.y"
              { mon_memory_display_data((yyvsp[-1].range)[0], (yyvsp[-1].range)[1], 8, 8); }
#line 3070 "mon_parse.c"
    break;

  case 90: /* memory_rules: CMD_CHAR_DISPLAY end_cmd  */
#line 373 "mon_parse.y"
              { mon_memory_display_data(BAD_ADDR, BAD_ADDR, 8, 8); }
#line 3076 "mon_parse.c"
    break;

  case 91: /* memory_rules: CMD_SPRITE_DISPLAY address_opt_range end_cmd  */
#line 375 "mon_parse.y"
              { mon_memory_display_data((yyvsp[-1].range)[0], (yyvsp[-1].range)[1], 24, 21); }
#line 3082 "mon_parse.c"
    break;

  case 92: /* memory_rules: CMD_SPRITE_DISPLAY end_cmd  */
#line 377 "mon_parse.y"
              { mon_memory_display_data(BAD_ADDR, BAD_ADDR, 24, 21); }
#line 3088 "mon_parse.c"
    break;

  case 93: /* memory_rules: CMD_TEXT_DISPLAY address_opt_range end_cmd  */
#line 379 "mon_parse.y"
              { mon_memory_display(e_text, (yyvsp[-1].range)[0], (yyvsp[-1].range)[1], DF_PETSCII); }
#line 3094 "mon_parse.c"
    break;

  case 94: /* memory_rules: CMD_TEXT_DISPLAY end_cmd  */
#line 381 "mon_parse.y"
              { mon_memory_display(e_text, BAD_ADDR, BAD_ADDR, DF_PETSCII); }
#line 3100 "mon_parse.c"
    break;

  case 95: /* memory_rules: CMD_SCREENCODE_DISPLAY address_opt_range end_cmd  */
#line 383 "mon_parse.y"
              { mon_memory_display(e_text, (yyvsp[-1].range)[0], (yyvsp[-1].range)[1], DF_SCREEN_CODE); }
#line 3106 "mon_parse.c"
    break;

  case 96: /* memory_rules: CMD_SCREENCODE_DISPLAY end_cmd  */
#line 385 "mon_parse.y"
              { mon_memory_display(e_text, BAD_ADDR, BAD_ADDR, DF_SCREEN_CODE); }
#line 3112 "mon_parse.c"
    break;

  case 97: /* memory_rules: CMD_MEMMAPZAP end_cmd  */
#line 387 "mon_parse.y"
              { mon_memmap_zap(); }
#line 3118 "mon_parse.c"
    break;

  case 98: /* memory_rules: CMD_MEMMAPSHOW end_cmd  */
#line 389 "mon_parse.y"
              { mon_memmap_show(-1,BAD_ADDR,BAD_ADDR); }
#line 3124 "mon_parse.c"
    break;

  case 99: /* memory_rules: CMD_MEMMAPSHOW opt_sep expression end_cmd  */
#line 391 "mon_parse.y"
              { mon_memmap_show((yyvsp[-1].i),BAD_ADDR,BAD_ADDR); }
#line 3130 "mon_parse.c"
    break;

  case 100: /* memory_rules: CMD_MEMMAPSHOW opt_sep expression address_opt_range end_cmd  */
#line 393 "mon_parse.y"
              { mon_memmap_show((yyvsp[-2].i),(yyvsp[-1].range)[0],(yyvsp[-1].range)[1]); }
#line 3136 "mon_parse.c"
    break;

  case 101: /* memory_rules: CMD_MEMMAPSAVE filename opt_sep expression end_cmd  */
#line 395 "mon_parse.y"
              { mon_memmap_save((yyvsp[-3].str),(yyvsp[-1].i)); }
#line 3142 "mon_parse.c"
    break;

  case 102: /* checkpoint_rules: CMD_BREAK opt_mem_op address_opt_range opt_if_cond_expr end_cmd  */
#line 399 "mon_parse.y"
                  {
                      if ((yyvsp[-3].i)) {
                          temp = mon_breakpoint_add_checkpoint((yyvsp[-2].range)[0], (yyvsp[-2].range)[1], TRUE, (yyvsp[-3].i), FALSE, TRUE);
                      } else {
                          temp = mon_breakpoint_add_checkpoint((yyvsp[-2].range)[0], (yyvsp[-2].range)[1], TRUE, e_exec, FALSE, TRUE);
                      }
                      mon_breakpoint_set_checkpoint_condition(temp, (yyvsp[-1].cond_node));
                  }
#line 3155 "mon_parse.c"
    break;

  case 103: /* checkpoint_rules: CMD_BREAK end_cmd  */
#line 408 "mon_parse.y"
                  { mon_breakpoint_print_checkpoints(); }
#line 3161 "mon_parse.c"
    break;

  case 104: /* checkpoint_rules: CMD_UNTIL address_opt_range end_cmd  */
#line 411 "mon_parse.y"
                  {
                      mon_breakpoint_add_checkpoint((yyvsp[-1].range)[0], (yyvsp[-1].range)[1], TRUE, e_exec, TRUE, TRUE);
                  }
#line 3169 "mon_parse.c"
    break;

  case 105: /* checkpoint_rules: CMD_UNTIL end_cmd  */
#line 415 "mon_parse.y"
                  { mon_breakpoint_print_checkpoints(); }
#line 3175 "mon_parse.c"
    break;

  case 106: /* checkpoint_rules: CMD_WATCH opt_mem_op address_opt_range opt_if_cond_expr end_cmd  */
#line 418 "mon_parse.y"
                  {
                      if ((yyvsp[-3].i)) {
                          temp = mon_breakpoint_add_checkpoint((yyvsp[-2].range)[0], (yyvsp[-2].range)[1], TRUE, (yyvsp[-3].i), FALSE, TRUE);
                      } else {
                          temp = mon_breakpoint_add_checkpoint((yyvsp[-2].range)[0], (yyvsp[-2].range)[1], TRUE, e_load | e_store, FALSE, TRUE);
                      }
                      mon_breakpoint_set_checkpoint_condition(temp, (yyvsp[-1].cond_node));
                  }
#line 3188 "mon_parse.c"
    break;

  case 107: /* checkpoint_rules: CMD_WATCH end_cmd  */
#line 427 "mon_parse.y"
                  { mon_breakpoint_print_checkpoints(); }
#line 3194 "mon_parse.c"
    break;

  case 108: /* checkpoint_rules: CMD_TRACE opt_mem_op address_opt_range opt_if_cond_expr end_cmd  */
#line 430 "mon_parse.y"
                  {
                      if ((yyvsp[-3].i)) {
                          temp = mon_breakpoint_add_checkpoint((yyvsp[-2].range)[0], (yyvsp[-2].range)[1], FALSE, (yyvsp[-3].i), FALSE, TRUE);
                      } else {
                          temp = mon_breakpoint_add_checkpoint((yyvsp[-2].range)[0], (yyvsp[-2].range)[1], FALSE, e_exec | e_load | e_store, FALSE, TRUE);
                      }
                      mon_breakpoint_set_checkpoint_condition(temp, (yyvsp[-1].cond_node));
                  }
#line 3207 "mon_parse.c"
    break;

  case 109: /* checkpoint_rules: CMD_TRACE end_cmd  */
#line 439 "mon_parse.y"
                  { mon_breakpoint_print_checkpoints(); }
#line 3213 "mon_parse.c"
    break;

  case 110: /* checkpoint_control_rules: CMD_CHECKPT_ON checkpt_num end_cmd  */
#line 444 "mon_parse.y"
                          { mon_breakpoint_switch_checkpoint(e_ON, (yyvsp[-1].i)); }
#line 3219 "mon_parse.c"
    break;

  case 111: /* checkpoint_control_rules: CMD_CHECKPT_ON end_cmd  */
#line 446 "mon_parse.y"
                          { mon_breakpoint_switch_checkpoint(e_ON, -1); }
#line 3225 "mon_parse.c"
    break;

  case 112: /* checkpoint_control_rules: CMD_CHECKPT_OFF checkpt_num end_cmd  */
#line 448 "mon_parse.y"
                          { mon_breakpoint_switch_checkpoint(e_OFF, (yyvsp[-1].i)); }
#line 3231 "mon_parse.c"
    break;

  case 113: /* checkpoint_control_rules: CMD_CHECKPT_OFF end_cmd  */
#line 450 "mon_parse.y"
                          { mon_breakpoint_switch_checkpoint(e_OFF, -1); }
#line 3237 "mon_parse.c"
    break;

  case 114: /* checkpoint_control_rules: CMD_IGNORE checkpt_num end_cmd  */
#line 452 "mon_parse.y"
                          { mon_breakpoint_set_ignore_count((yyvsp[-1].i), -1); }
#line 3243 "mon_parse.c"
    break;

  case 115: /* checkpoint_control_rules: CMD_IGNORE checkpt_num opt_sep expression end_cmd  */
#line 454 "mon_parse.y"
                          { mon_breakpoint_set_ignore_count((yyvsp[-3].i), (yyvsp[-1].i)); }
#line 3249 "mon_parse.c"
    break;

  case 116: /* checkpoint_control_rules: CMD_DELETE checkpt_num end_cmd  */
#line 456 "mon_parse.y"
                          { mon_breakpoint_delete_checkpoint((yyvsp[-1].i)); }
#line 3255 "mon_parse.c"
    break;

  case 117: /* checkpoint_control_rules: CMD_DELETE end_cmd  */
#line 458 "mon_parse.y"
                          { mon_breakpoint_delete_checkpoint(-1); }
#line 3261 "mon_parse.c"
    break;

  case 118: /* checkpoint_control_rules: CMD_CONDITION checkpt_num IF cond_expr end_cmd  */
#line 460 "mon_parse.y"
                          { mon_breakpoint_set_checkpoint_condition((yyvsp[-3].i), (yyvsp[-1].cond_node)); }
#line 3267 "mon_parse.c"
    break;

  case 119: /* checkpoint_control_rules: CMD_COMMAND checkpt_num opt_sep STRING end_cmd  */
#line 462 "mon_parse.y"
                          { mon_breakpoint_set_checkpoint_command((yyvsp[-3].i), (yyvsp[-1].str)); }
#line 3273 "mon_parse.c"
    break;

  case 120: /* checkpoint_control_rules: CMD_COMMAND checkpt_num error end_cmd  */
#line 464 "mon_parse.y"
                          { return ERR_EXPECT_STRING; }
#line 3279 "mon_parse.c"
    break;

  case 121: /* monitor_state_rules: CMD_SIDEFX TOGGLE end_cmd  */
#line 468 "mon_parse.y"
                     { sidefx = (((yyvsp[-1].action) == e_TOGGLE) ? (sidefx ^ 1) : (yyvsp[-1].action)); }
#line 3285 "mon_parse.c"
    break;

  case 122: /* monitor_state_rules: CMD_SIDEFX end_cmd  */
#line 470 "mon_parse.y"
                     {
                         mon_out("I/O side effects are %s\n",
                                   sidefx ? "enabled" : "disabled");
                     }
#line 3294 "mon_parse.c"
    break;

  case 123: /* monitor_state_rules: CMD_DUMMY TOGGLE end_cmd  */
#line 475 "mon_parse.y"
                     { 
                         break_on_dummy_access = (((yyvsp[-1].action) == e_TOGGLE) ? (break_on_dummy_access ^ 1) : (yyvsp[-1].action)); 
                         /* FIXME: some day we might want to toggle the break-on-dummy-access 
                                   per MEMSPACE, for now its a global option */                         
                         mon_breakpoint_set_dummy_state(e_default_space, break_on_dummy_access);
                     }
#line 3305 "mon_parse.c"
    break;

  case 124: /* monitor_state_rules: CMD_DUMMY end_cmd  */
#line 482 "mon_parse.y"
                     {
                         mon_out("Checkpoints will %strigger on dummy accesses.\n",
                                   break_on_dummy_access ? "" : "not ");
                         /* FIXME: some day we might want to toggle the break-on-dummy-access 
                                   per MEMSPACE, for now its a global option */                         
                         mon_breakpoint_set_dummy_state(e_default_space, break_on_dummy_access);
                     }
#line 3317 "mon_parse.c"
    break;

  case 125: /* monitor_state_rules: CMD_LOG TOGGLE end_cmd  */
#line 490 "mon_parse.y"
                     { 
                        int logenabled;
                        resources_get_int("MonitorLogEnabled", &logenabled);
                        logenabled = (((yyvsp[-1].action) == e_TOGGLE) ? (logenabled ^ 1) : (yyvsp[-1].action));
                        resources_set_int("MonitorLogEnabled", logenabled);
                     }
#line 3328 "mon_parse.c"
    break;

  case 126: /* monitor_state_rules: CMD_LOG end_cmd  */
#line 497 "mon_parse.y"
                     {
                         int logenabled;
                         const char *logfilename;
                         resources_get_int("MonitorLogEnabled", &logenabled);
                         resources_get_string("MonitorLogFileName", &logfilename);
                         if (logenabled) {
                            mon_out("Logging to '%s' is enabled.\n", logfilename);
                         } else {
                            mon_out("Logging is disabled.\n");
                         }
                     }
#line 3344 "mon_parse.c"
    break;

  case 127: /* monitor_state_rules: CMD_LOGNAME filename end_cmd  */
#line 509 "mon_parse.y"
                     { 
                        resources_set_string("MonitorLogFileName", (yyvsp[-1].str));
                     }
#line 3352 "mon_parse.c"
    break;

  case 128: /* monitor_state_rules: CMD_RADIX RADIX_TYPE end_cmd  */
#line 513 "mon_parse.y"
                     { default_radix = (yyvsp[-1].rt); }
#line 3358 "mon_parse.c"
    break;

  case 129: /* monitor_state_rules: CMD_RADIX end_cmd  */
#line 515 "mon_parse.y"
                     {
                         const char *p;

                         if (default_radix == e_hexadecimal)
                             p = "Hexadecimal";
                         else if (default_radix == e_decimal)
                             p = "Decimal";
                         else if (default_radix == e_octal)
                             p = "Octal";
                         else if (default_radix == e_binary)
                             p = "Binary";
                         else
                             p = "Unknown";

                         mon_out("Default radix is %s\n", p);
                     }
#line 3379 "mon_parse.c"
    break;

  case 130: /* monitor_state_rules: CMD_DEVICE end_cmd  */
#line 533 "mon_parse.y"
                     { monitor_change_device(e_default_space); }
#line 3385 "mon_parse.c"
    break;

  case 131: /* monitor_state_rules: CMD_DEVICE memspace end_cmd  */
#line 535 "mon_parse.y"
                     { monitor_change_device((yyvsp[-1].i)); }
#line 3391 "mon_parse.c"
    break;

  case 132: /* monitor_state_rules: CMD_EXPORT end_cmd  */
#line 537 "mon_parse.y"
                     { mon_export(); }
#line 3397 "mon_parse.c"
    break;

  case 133: /* monitor_state_rules: CMD_QUIT end_cmd  */
#line 539 "mon_parse.y"
                     { mon_quit(); YYACCEPT; }
#line 3403 "mon_parse.c"
    break;

  case 134: /* monitor_state_rules: CMD_EXIT end_cmd  */
#line 541 "mon_parse.y"
                     { mon_exit(); YYACCEPT; }
#line 3409 "mon_parse.c"
    break;

  case 135: /* monitor_state_rules: CMD_MAINCPU_TRACE end_cmd  */
#line 543 "mon_parse.y"
                     { mon_maincpu_trace(); }
#line 3415 "mon_parse.c"
    break;

  case 136: /* monitor_state_rules: CMD_MAINCPU_TRACE TOGGLE end_cmd  */
#line 545 "mon_parse.y"
                     { mon_maincpu_toggle_trace((yyvsp[-1].action)); }
#line 3421 "mon_parse.c"
    break;

  case 137: /* monitor_misc_rules: CMD_DISK rest_of_line end_cmd  */
#line 549 "mon_parse.y"
                    { mon_drive_execute_disk_cmd((yyvsp[-1].str)); }
#line 3427 "mon_parse.c"
    break;

  case 138: /* monitor_misc_rules: CMD_PRINT expression end_cmd  */
#line 551 "mon_parse.y"
                    { mon_out("\t%d\n",(yyvsp[-1].i)); }
#line 3433 "mon_parse.c"
    break;

  case 139: /* monitor_misc_rules: CMD_HELP end_cmd  */
#line 553 "mon_parse.y"
                    { mon_command_print_help(NULL); }
#line 3439 "mon_parse.c"
    break;

  case 140: /* monitor_misc_rules: CMD_HELP rest_of_line end_cmd  */
#line 555 "mon_parse.y"
                    { mon_command_print_help((yyvsp[-1].str)); }
#line 3445 "mon_parse.c"
    break;

  case 141: /* monitor_misc_rules: CONVERT_OP expression end_cmd  */
#line 557 "mon_parse.y"
                    { mon_print_convert((yyvsp[-1].i)); }
#line 3451 "mon_parse.c"
    break;

  case 142: /* monitor_misc_rules: CMD_CHDIR rest_of_line_or_quoted end_cmd  */
#line 559 "mon_parse.y"
                    { mon_change_dir((yyvsp[-1].str)); }
#line 3457 "mon_parse.c"
    break;

  case 143: /* monitor_misc_rules: CMD_KEYBUF rest_of_line end_cmd  */
#line 561 "mon_parse.y"
                    { mon_keyboard_feed((yyvsp[-1].str)); }
#line 3463 "mon_parse.c"
    break;

  case 144: /* monitor_misc_rules: CMD_BACKTRACE end_cmd  */
#line 563 "mon_parse.y"
                    { mon_backtrace(); }
#line 3469 "mon_parse.c"
    break;

  case 145: /* monitor_misc_rules: CMD_DIR opt_rest_of_line end_cmd  */
#line 565 "mon_parse.y"
                     { mon_show_dir((yyvsp[-1].str)); }
#line 3475 "mon_parse.c"
    break;

  case 146: /* monitor_misc_rules: CMD_PWD end_cmd  */
#line 567 "mon_parse.y"
                     { mon_show_pwd(); }
#line 3481 "mon_parse.c"
    break;

  case 147: /* monitor_misc_rules: CMD_MKDIR rest_of_line_or_quoted end_cmd  */
#line 569 "mon_parse.y"
                    { mon_make_dir((yyvsp[-1].str)); }
#line 3487 "mon_parse.c"
    break;

  case 148: /* monitor_misc_rules: CMD_RMDIR rest_of_line_or_quoted end_cmd  */
#line 571 "mon_parse.y"
                    { mon_remove_dir((yyvsp[-1].str)); }
#line 3493 "mon_parse.c"
    break;

  case 149: /* monitor_misc_rules: CMD_SCREENSHOT filename end_cmd  */
#line 573 "mon_parse.y"
                    { mon_screenshot_save((yyvsp[-1].str),-1); }
#line 3499 "mon_parse.c"
    break;

  case 150: /* monitor_misc_rules: CMD_SCREENSHOT filename opt_sep expression end_cmd  */
#line 575 "mon_parse.y"
                    { mon_screenshot_save((yyvsp[-3].str),(yyvsp[-1].i)); }
#line 3505 "mon_parse.c"
    break;

  case 151: /* monitor_misc_rules: CMD_RESOURCE_GET STRING end_cmd  */
#line 577 "mon_parse.y"
                    { mon_resource_get((yyvsp[-1].str)); }
#line 3511 "mon_parse.c"
    break;

  case 152: /* monitor_misc_rules: CMD_RESOURCE_SET STRING STRING end_cmd  */
#line 579 "mon_parse.y"
                    { mon_resource_set((yyvsp[-2].str),(yyvsp[-1].str)); }
#line 3517 "mon_parse.c"
    break;

  case 153: /* monitor_misc_rules: CMD_LOAD_RESOURCES filename end_cmd  */
#line 581 "mon_parse.y"
                    { resources_load((yyvsp[-1].str)); }
#line 3523 "mon_parse.c"
    break;

  case 154: /* monitor_misc_rules: CMD_SAVE_RESOURCES filename end_cmd  */
#line 583 "mon_parse.y"
                    { resources_save((yyvsp[-1].str)); }
#line 3529 "mon_parse.c"
    break;

  case 155: /* monitor_misc_rules: CMD_MON_RESET end_cmd  */
#line 585 "mon_parse.y"
                    { mon_reset_machine(-1); }
#line 3535 "mon_parse.c"
    break;

  case 156: /* monitor_misc_rules: CMD_MON_RESET opt_sep expression end_cmd  */
#line 587 "mon_parse.y"
                    { mon_reset_machine((yyvsp[-1].i)); }
#line 3541 "mon_parse.c"
    break;

  case 157: /* monitor_misc_rules: CMD_TAPECTRL opt_sep expression end_cmd  */
#line 589 "mon_parse.y"
                    { mon_tape_ctrl(TAPEPORT_PORT_1, (yyvsp[-1].i)); }
#line 3547 "mon_parse.c"
    break;

  case 158: /* monitor_misc_rules: CMD_TAPEOFFS end_cmd  */
#line 591 "mon_parse.y"
                    { mon_tape_offs(TAPEPORT_PORT_1, -1); }
#line 3553 "mon_parse.c"
    break;

  case 159: /* monitor_misc_rules: CMD_TAPEOFFS opt_sep expression end_cmd  */
#line 593 "mon_parse.y"
                    { mon_tape_offs(TAPEPORT_PORT_1, (yyvsp[-1].i)); }
#line 3559 "mon_parse.c"
    break;

  case 160: /* monitor_misc_rules: CMD_CARTFREEZE end_cmd  */
#line 595 "mon_parse.y"
                    { mon_cart_freeze(); }
#line 3565 "mon_parse.c"
    break;

  case 161: /* monitor_misc_rules: CMD_UPDB number end_cmd  */
#line 597 "mon_parse.y"
                    { mon_userport_set_output((yyvsp[-1].i)); }
#line 3571 "mon_parse.c"
    break;

  case 162: /* monitor_misc_rules: CMD_UPDB end_cmd  */
#line 599 "mon_parse.y"
                    { mon_userport_get_output(); }
#line 3577 "mon_parse.c"
    break;

  case 163: /* monitor_misc_rules: CMD_JPDB number number end_cmd  */
#line 601 "mon_parse.y"
                    { mon_joyport_set_output((yyvsp[-2].i), (yyvsp[-1].i)); }
#line 3583 "mon_parse.c"
    break;

  case 164: /* monitor_misc_rules: CMD_JPDB number end_cmd  */
#line 603 "mon_parse.y"
                    { mon_joyport_get_output((yyvsp[-1].i)); }
#line 3589 "mon_parse.c"
    break;

  case 165: /* monitor_misc_rules: CMD_COMMENT opt_rest_of_line end_cmd  */
#line 605 "mon_parse.y"
                     { }
#line 3595 "mon_parse.c"
    break;

  case 166: /* monitor_misc_rules: CMD_STOPWATCH RESET end_cmd  */
#line 607 "mon_parse.y"
                     { mon_stopwatch_reset(); }
#line 3601 "mon_parse.c"
    break;

  case 167: /* monitor_misc_rules: CMD_STOPWATCH end_cmd  */
#line 609 "mon_parse.y"
                     { mon_stopwatch_show(default_memspace, "Stopwatch: ", "\n"); }
#line 3607 "mon_parse.c"
    break;

  case 168: /* monitor_misc_rules: CMD_PROFILE TOGGLE end_cmd  */
#line 611 "mon_parse.y"
                     { mon_profile_action((yyvsp[-1].action)); }
#line 3613 "mon_parse.c"
    break;

  case 169: /* monitor_misc_rules: CMD_PROFILE end_cmd  */
#line 613 "mon_parse.y"
                     { mon_profile(); }
#line 3619 "mon_parse.c"
    break;

  case 170: /* monitor_misc_rules: CMD_PROFILE FLAT opt_d_number end_cmd  */
#line 615 "mon_parse.y"
                     { mon_profile_flat((yyvsp[-1].i)); }
#line 3625 "mon_parse.c"
    break;

  case 171: /* monitor_misc_rules: CMD_PROFILE GRAPH opt_context_num end_cmd  */
#line 617 "mon_parse.y"
                     { mon_profile_graph((yyvsp[-1].i), -1); }
#line 3631 "mon_parse.c"
    break;

  case 172: /* monitor_misc_rules: CMD_PROFILE GRAPH opt_context_num DEPTH d_number end_cmd  */
#line 619 "mon_parse.y"
                     { mon_profile_graph((yyvsp[-3].i), (yyvsp[-1].i)); }
#line 3637 "mon_parse.c"
    break;

  case 173: /* monitor_misc_rules: CMD_PROFILE FUNC address end_cmd  */
#line 621 "mon_parse.y"
                     { mon_profile_func((yyvsp[-1].a)); }
#line 3643 "mon_parse.c"
    break;

  case 174: /* monitor_misc_rules: CMD_PROFILE DISASS address end_cmd  */
#line 623 "mon_parse.y"
                     { mon_profile_disass((yyvsp[-1].a)); }
#line 3649 "mon_parse.c"
    break;

  case 175: /* monitor_misc_rules: CMD_PROFILE CLEAR address end_cmd  */
#line 625 "mon_parse.y"
                     { mon_profile_clear((yyvsp[-1].a)); }
#line 3655 "mon_parse.c"
    break;

  case 176: /* monitor_misc_rules: CMD_PROFILE PROFILE_CONTEXT d_number end_cmd  */
#line 627 "mon_parse.y"
                     { mon_profile_disass_context((yyvsp[-1].i)); }
#line 3661 "mon_parse.c"
    break;

  case 177: /* disk_rules: CMD_LOAD filename device_num opt_address end_cmd  */
#line 631 "mon_parse.y"
            { mon_file_load((yyvsp[-3].str), (yyvsp[-2].i), (yyvsp[-1].a), FALSE, FALSE); }
#line 3667 "mon_parse.c"
    break;

  case 178: /* disk_rules: CMD_BASICLOAD filename device_num opt_address end_cmd  */
#line 633 "mon_parse.y"
            { mon_file_load((yyvsp[-3].str), (yyvsp[-2].i), (yyvsp[-1].a), FALSE, TRUE); }
#line 3673 "mon_parse.c"
    break;

  case 179: /* disk_rules: CMD_BLOAD filename device_num address end_cmd  */
#line 635 "mon_parse.y"
            { mon_file_load((yyvsp[-3].str), (yyvsp[-2].i), (yyvsp[-1].a), TRUE, FALSE); }
#line 3679 "mon_parse.c"
    break;

  case 180: /* disk_rules: CMD_BLOAD filename device_num error  */
#line 637 "mon_parse.y"
            { return ERR_EXPECT_ADDRESS; }
#line 3685 "mon_parse.c"
    break;

  case 181: /* disk_rules: CMD_SAVE filename device_num address_range end_cmd  */
#line 639 "mon_parse.y"
            { mon_file_save((yyvsp[-3].str), (yyvsp[-2].i), (yyvsp[-1].range)[0], (yyvsp[-1].range)[1], FALSE); }
#line 3691 "mon_parse.c"
    break;

  case 182: /* disk_rules: CMD_SAVE filename error  */
#line 641 "mon_parse.y"
            { return ERR_EXPECT_DEVICE_NUM; }
#line 3697 "mon_parse.c"
    break;

  case 183: /* disk_rules: CMD_SAVE filename device_num error  */
#line 643 "mon_parse.y"
            { return ERR_EXPECT_ADDRESS; }
#line 3703 "mon_parse.c"
    break;

  case 184: /* disk_rules: CMD_BSAVE filename device_num address_range end_cmd  */
#line 645 "mon_parse.y"
            { mon_file_save((yyvsp[-3].str), (yyvsp[-2].i), (yyvsp[-1].range)[0], (yyvsp[-1].range)[1], TRUE); }
#line 3709 "mon_parse.c"
    break;

  case 185: /* disk_rules: CMD_BSAVE filename device_num error  */
#line 647 "mon_parse.y"
            { return ERR_EXPECT_ADDRESS; }
#line 3715 "mon_parse.c"
    break;

  case 186: /* disk_rules: CMD_VERIFY filename device_num opt_address end_cmd  */
#line 649 "mon_parse.y"
            { mon_file_verify((yyvsp[-3].str),(yyvsp[-2].i),(yyvsp[-1].a),FALSE); }
#line 3721 "mon_parse.c"
    break;

  case 187: /* disk_rules: CMD_BVERIFY filename device_num address end_cmd  */
#line 651 "mon_parse.y"
            { mon_file_verify((yyvsp[-3].str),(yyvsp[-2].i),(yyvsp[-1].a),TRUE); }
#line 3727 "mon_parse.c"
    break;

  case 188: /* disk_rules: CMD_BVERIFY filename device_num error  */
#line 653 "mon_parse.y"
            { return ERR_EXPECT_ADDRESS; }
#line 3733 "mon_parse.c"
    break;

  case 189: /* disk_rules: CMD_BLOCK_READ expression expression opt_address end_cmd  */
#line 655 "mon_parse.y"
            { mon_drive_block_cmd(0,(yyvsp[-3].i),(yyvsp[-2].i),(yyvsp[-1].a)); }
#line 3739 "mon_parse.c"
    break;

  case 190: /* disk_rules: CMD_BLOCK_WRITE expression expression address end_cmd  */
#line 657 "mon_parse.y"
            { mon_drive_block_cmd(1,(yyvsp[-3].i),(yyvsp[-2].i),(yyvsp[-1].a)); }
#line 3745 "mon_parse.c"
    break;

  case 191: /* disk_rules: CMD_LIST end_cmd  */
#line 659 "mon_parse.y"
            { mon_drive_list(-1); }
#line 3751 "mon_parse.c"
    break;

  case 192: /* disk_rules: CMD_LIST device_num end_cmd  */
#line 661 "mon_parse.y"
            { mon_drive_list((yyvsp[-1].i)); }
#line 3757 "mon_parse.c"
    break;

  case 193: /* disk_rules: CMD_ATTACH filename expression end_cmd  */
#line 663 "mon_parse.y"
            { mon_attach((yyvsp[-2].str),(yyvsp[-1].i)); }
#line 3763 "mon_parse.c"
    break;

  case 194: /* disk_rules: CMD_DETACH expression end_cmd  */
#line 665 "mon_parse.y"
            { mon_detach((yyvsp[-1].i)); }
#line 3769 "mon_parse.c"
    break;

  case 195: /* disk_rules: CMD_AUTOSTART filename end_cmd  */
#line 667 "mon_parse.y"
            { mon_autostart((yyvsp[-1].str),0,1); }
#line 3775 "mon_parse.c"
    break;

  case 196: /* disk_rules: CMD_AUTOSTART filename opt_sep number end_cmd  */
#line 669 "mon_parse.y"
            { mon_autostart((yyvsp[-3].str),(yyvsp[-1].i),1); }
#line 3781 "mon_parse.c"
    break;

  case 197: /* disk_rules: CMD_AUTOLOAD filename end_cmd  */
#line 671 "mon_parse.y"
            { mon_autostart((yyvsp[-1].str),0,0); }
#line 3787 "mon_parse.c"
    break;

  case 198: /* disk_rules: CMD_AUTOLOAD filename opt_sep number end_cmd  */
#line 673 "mon_parse.y"
            { mon_autostart((yyvsp[-3].str),(yyvsp[-1].i),0); }
#line 3793 "mon_parse.c"
    break;

  case 199: /* cmd_file_rules: CMD_RECORD filename end_cmd  */
#line 677 "mon_parse.y"
                { mon_record_commands((yyvsp[-1].str)); }
#line 3799 "mon_parse.c"
    break;

  case 200: /* cmd_file_rules: CMD_MON_STOP end_cmd  */
#line 679 "mon_parse.y"
                { mon_end_recording(); }
#line 3805 "mon_parse.c"
    break;

  case 201: /* cmd_file_rules: CMD_PLAYBACK filename end_cmd  */
#line 681 "mon_parse.y"
                { mon_playback_commands((yyvsp[-1].str),true); }
#line 3811 "mon_parse.c"
    break;

  case 202: /* data_entry_rules: CMD_ENTER_DATA address data_list end_cmd  */
#line 685 "mon_parse.y"
                  { mon_memory_fill((yyvsp[-2].a), BAD_ADDR, (unsigned char *)(yyvsp[-1].str)); }
#line 3817 "mon_parse.c"
    break;

  case 203: /* data_entry_rules: CMD_ENTER_BIN_DATA end_cmd  */
#line 687 "mon_parse.y"
                  { printf("Not yet.\n"); }
#line 3823 "mon_parse.c"
    break;

  case 204: /* monitor_debug_rules: CMD_YYDEBUG end_cmd  */
#line 691 "mon_parse.y"
                     {
#if YYDEBUG
                     yydebug = 1;
#endif
                     }
#line 3833 "mon_parse.c"
    break;

  case 205: /* rest_of_line: R_O_L  */
#line 698 "mon_parse.y"
                    { (yyval.str) = (yyvsp[0].str); }
#line 3839 "mon_parse.c"
    break;

  case 206: /* opt_rest_of_line: R_O_L  */
#line 701 "mon_parse.y"
                        { (yyval.str) = (yyvsp[0].str); }
#line 3845 "mon_parse.c"
    break;

  case 207: /* opt_rest_of_line: %empty  */
#line 702 "mon_parse.y"
                    { (yyval.str) = NULL; }
#line 3851 "mon_parse.c"
    break;

  case 208: /* rest_of_line_or_quoted: R_O_L_Q  */
#line 705 "mon_parse.y"
                                { (yyval.str) = (yyvsp[0].str); }
#line 3857 "mon_parse.c"
    break;

  case 210: /* filename: error  */
#line 709 "mon_parse.y"
                { return ERR_EXPECT_FILENAME; }
#line 3863 "mon_parse.c"
    break;

  case 212: /* device_num: error  */
#line 713 "mon_parse.y"
              { return ERR_EXPECT_DEVICE_NUM; }
#line 3869 "mon_parse.c"
    break;

  case 213: /* mem_op: mem_op MEM_OP  */
#line 716 "mon_parse.y"
                      { (yyval.i) = (yyvsp[-1].i) | (yyvsp[0].i); }
#line 3875 "mon_parse.c"
    break;

  case 214: /* mem_op: MEM_OP  */
#line 717 "mon_parse.y"
               { (yyval.i) = (yyvsp[0].i); }
#line 3881 "mon_parse.c"
    break;

  case 215: /* opt_mem_op: mem_op  */
#line 720 "mon_parse.y"
                   { (yyval.i) = (yyvsp[0].i); }
#line 3887 "mon_parse.c"
    break;

  case 216: /* opt_mem_op: %empty  */
#line 721 "mon_parse.y"
            { (yyval.i) = 0; }
#line 3893 "mon_parse.c"
    break;

  case 217: /* register: MON_REGISTER  */
#line 724 "mon_parse.y"
                                {
                                    if (!mon_register_valid(default_memspace, (yyvsp[0].reg))) {
                                        return ERR_INVALID_REGISTER;
                                    }
                                    (yyval.i) = new_reg(default_memspace, (yyvsp[0].reg));
                                }
#line 3904 "mon_parse.c"
    break;

  case 218: /* register: memspace MON_REGISTER  */
#line 730 "mon_parse.y"
                                {
                                    if (!mon_register_valid((yyvsp[-1].i), (yyvsp[0].reg))) {
                                        return ERR_INVALID_REGISTER;
                                    }
                                    (yyval.i) = new_reg((yyvsp[-1].i), (yyvsp[0].reg));
                                }
#line 3915 "mon_parse.c"
    break;

  case 221: /* reg_asgn: register EQUALS number  */
#line 743 "mon_parse.y"
          { (monitor_cpu_for_memspace[reg_memspace((yyvsp[-2].i))]->mon_register_set_val)(reg_memspace((yyvsp[-2].i)), reg_regid((yyvsp[-2].i)), (uint16_t) (yyvsp[0].i)); }
#line 3921 "mon_parse.c"
    break;

  case 222: /* checkpt_num: d_number  */
#line 746 "mon_parse.y"
                      { (yyval.i) = (yyvsp[0].i); }
#line 3927 "mon_parse.c"
    break;

  case 223: /* checkpt_num: error  */
#line 747 "mon_parse.y"
                   { return ERR_EXPECT_CHECKNUM; }
#line 3933 "mon_parse.c"
    break;

  case 224: /* opt_context_num: d_number  */
#line 750 "mon_parse.y"
                          { (yyval.i) = (yyvsp[0].i); }
#line 3939 "mon_parse.c"
    break;

  case 225: /* opt_context_num: %empty  */
#line 751 "mon_parse.y"
                 { (yyval.i) = -1; }
#line 3945 "mon_parse.c"
    break;

  case 227: /* address_opt_range: address  */
#line 755 "mon_parse.y"
                           { (yyval.range)[0] = (yyvsp[0].a); (yyval.range)[1] = BAD_ADDR; }
#line 3951 "mon_parse.c"
    break;

  case 228: /* address_range: address opt_sep address  */
#line 758 "mon_parse.y"
                                       { (yyval.range)[0] = (yyvsp[-2].a); (yyval.range)[1] = (yyvsp[0].a); }
#line 3957 "mon_parse.c"
    break;

  case 229: /* address_range: H_RANGE_GUESS  */
#line 760 "mon_parse.y"
               { if (resolve_range(e_default_space, (yyval.range), (yyvsp[0].str))) return ERR_ADDR_TOO_BIG; }
#line 3963 "mon_parse.c"
    break;

  case 230: /* address_range: memspace opt_sep H_RANGE_GUESS  */
#line 762 "mon_parse.y"
               { if (resolve_range((yyvsp[-2].i), (yyval.range), (yyvsp[0].str))) return ERR_ADDR_TOO_BIG; }
#line 3969 "mon_parse.c"
    break;

  case 231: /* opt_address: opt_sep address  */
#line 765 "mon_parse.y"
                             { (yyval.a) = (yyvsp[0].a); }
#line 3975 "mon_parse.c"
    break;

  case 232: /* opt_address: %empty  */
#line 766 "mon_parse.y"
             { (yyval.a) = BAD_ADDR; }
#line 3981 "mon_parse.c"
    break;

  case 233: /* address: memloc  */
#line 770 "mon_parse.y"
         {
             (yyval.a) = new_addr(e_default_space,(yyvsp[0].i));
             if (opt_asm) new_cmd = asm_mode = 1;
         }
#line 3990 "mon_parse.c"
    break;

  case 234: /* address: memspace opt_sep memloc  */
#line 775 "mon_parse.y"
         {
             (yyval.a) = new_addr((yyvsp[-2].i), (yyvsp[0].i));
             if (opt_asm) new_cmd = asm_mode = 1;
         }
#line 3999 "mon_parse.c"
    break;

  case 235: /* address: LABEL  */
#line 780 "mon_parse.y"
         {
             temp = mon_symbol_table_lookup_addr(e_default_space, (yyvsp[0].str));
             if (temp >= 0)
                 (yyval.a) = new_addr(e_default_space, temp);
             else
                 return ERR_UNDEFINED_LABEL;
         }
#line 4011 "mon_parse.c"
    break;

  case 238: /* memspace: MEM_COMP  */
#line 793 "mon_parse.y"
                   { (yyval.i) = e_comp_space; }
#line 4017 "mon_parse.c"
    break;

  case 239: /* memspace: MEM_DISK8  */
#line 794 "mon_parse.y"
                    { (yyval.i) = e_disk8_space; }
#line 4023 "mon_parse.c"
    break;

  case 240: /* memspace: MEM_DISK9  */
#line 795 "mon_parse.y"
                    { (yyval.i) = e_disk9_space; }
#line 4029 "mon_parse.c"
    break;

  case 241: /* memspace: MEM_DISK10  */
#line 796 "mon_parse.y"
                     { (yyval.i) = e_disk10_space; }
#line 4035 "mon_parse.c"
    break;

  case 242: /* memspace: MEM_DISK11  */
#line 797 "mon_parse.y"
                     { (yyval.i) = e_disk11_space; }
#line 4041 "mon_parse.c"
    break;

  case 243: /* memloc: memaddr  */
#line 800 "mon_parse.y"
                { (yyval.i) = (yyvsp[0].i); if (!CHECK_ADDR((yyvsp[0].i))) return ERR_ADDR_TOO_BIG; }
#line 4047 "mon_parse.c"
    break;

  case 244: /* memaddr: number  */
#line 802 "mon_parse.y"
                { (yyval.i) = (yyvsp[0].i); }
#line 4053 "mon_parse.c"
    break;

  case 245: /* expression: expression '+' expression  */
#line 827 "mon_parse.y"
                                      { (yyval.i) = (yyvsp[-2].i) + (yyvsp[0].i); }
#line 4059 "mon_parse.c"
    break;

  case 246: /* expression: expression '-' expression  */
#line 828 "mon_parse.y"
                                      { (yyval.i) = (yyvsp[-2].i) - (yyvsp[0].i); }
#line 4065 "mon_parse.c"
    break;

  case 247: /* expression: expression '*' expression  */
#line 829 "mon_parse.y"
                                      { (yyval.i) = (yyvsp[-2].i) * (yyvsp[0].i); }
#line 4071 "mon_parse.c"
    break;

  case 248: /* expression: expression '/' expression  */
#line 830 "mon_parse.y"
                                      { (yyval.i) = ((yyvsp[0].i)) ? ((yyvsp[-2].i) / (yyvsp[0].i)) : 1; }
#line 4077 "mon_parse.c"
    break;

  case 249: /* expression: '(' expression ')'  */
#line 831 "mon_parse.y"
                               { (yyval.i) = (yyvsp[-1].i); }
#line 4083 "mon_parse.c"
    break;

  case 250: /* expression: '(' expression error  */
#line 832 "mon_parse.y"
                                 { return ERR_MISSING_CLOSE_PAREN; }
#line 4089 "mon_parse.c"
    break;

  case 251: /* expression: value  */
#line 833 "mon_parse.y"
                  { (yyval.i) = (yyvsp[0].i); }
#line 4095 "mon_parse.c"
    break;

  case 252: /* opt_if_cond_expr: IF cond_expr  */
#line 836 "mon_parse.y"
                               { (yyval.cond_node) = (yyvsp[0].cond_node); }
#line 4101 "mon_parse.c"
    break;

  case 253: /* opt_if_cond_expr: %empty  */
#line 837 "mon_parse.y"
                  { (yyval.cond_node) = 0; }
#line 4107 "mon_parse.c"
    break;

  case 254: /* cond_expr: cond_expr COND_OP cond_expr  */
#line 840 "mon_parse.y"
           {
               (yyval.cond_node) = new_cond; (yyval.cond_node)->is_parenthized = FALSE;
               (yyval.cond_node)->child1 = (yyvsp[-2].cond_node); (yyval.cond_node)->child2 = (yyvsp[0].cond_node); (yyval.cond_node)->operation = (yyvsp[-1].cond_op);
           }
#line 4116 "mon_parse.c"
    break;

  case 255: /* cond_expr: cond_expr COND_OP error  */
#line 845 "mon_parse.y"
           { return ERR_INCOMPLETE_COND_OP; }
#line 4122 "mon_parse.c"
    break;

  case 256: /* cond_expr: L_PAREN cond_expr R_PAREN  */
#line 847 "mon_parse.y"
           { (yyval.cond_node) = (yyvsp[-1].cond_node); (yyval.cond_node)->is_parenthized = TRUE; }
#line 4128 "mon_parse.c"
    break;

  case 257: /* cond_expr: L_PAREN cond_expr error  */
#line 849 "mon_parse.y"
           { return ERR_MISSING_CLOSE_PAREN; }
#line 4134 "mon_parse.c"
    break;

  case 258: /* cond_expr: cond_operand  */
#line 851 "mon_parse.y"
           { (yyval.cond_node) = (yyvsp[0].cond_node); }
#line 4140 "mon_parse.c"
    break;

  case 259: /* cond_operand: register  */
#line 854 "mon_parse.y"
                          { (yyval.cond_node) = new_cond;
                            (yyval.cond_node)->operation = e_INV;
                            (yyval.cond_node)->is_parenthized = FALSE;
                            (yyval.cond_node)->reg_num = (yyvsp[0].i); (yyval.cond_node)->is_reg = TRUE; (yyval.cond_node)->banknum=-1;
                            (yyval.cond_node)->child1 = NULL; (yyval.cond_node)->child2 = NULL;
                          }
#line 4151 "mon_parse.c"
    break;

  case 260: /* cond_operand: number  */
#line 860 "mon_parse.y"
                          { (yyval.cond_node) = new_cond;
                            (yyval.cond_node)->operation = e_INV;
                            (yyval.cond_node)->is_parenthized = FALSE;
                            (yyval.cond_node)->value = (yyvsp[0].i); (yyval.cond_node)->is_reg = FALSE; (yyval.cond_node)->banknum=-1;
                            (yyval.cond_node)->child1 = NULL; (yyval.cond_node)->child2 = NULL;
                          }
#line 4162 "mon_parse.c"
    break;

  case 261: /* cond_operand: '@' BANKNAME ':' L_PAREN cond_expr R_PAREN  */
#line 867 "mon_parse.y"
                                                             {
                            (yyval.cond_node) = new_cond;
                            (yyval.cond_node)->operation = e_INV;
                            (yyval.cond_node)->is_parenthized = FALSE;
                            (yyval.cond_node)->banknum = mon_banknum_from_bank(e_default_space, (yyvsp[-4].str));
                            if ((yyval.cond_node)->banknum < 0) {
                                return ERR_ILLEGAL_INPUT;
                            }
                            (yyval.cond_node)->value = 0;
                            (yyval.cond_node)->is_reg = FALSE;
                            (yyval.cond_node)->child1 = (yyvsp[-1].cond_node);
                            (yyval.cond_node)->child2 = NULL;
                        }
#line 4180 "mon_parse.c"
    break;

  case 262: /* cond_operand: '@' BANKNAME ':' address  */
#line 880 "mon_parse.y"
                                           {
                            (yyval.cond_node) = new_cond;
                            (yyval.cond_node)->operation = e_INV;
                            (yyval.cond_node)->is_parenthized = FALSE;
                            (yyval.cond_node)->banknum = mon_banknum_from_bank(e_default_space, (yyvsp[-2].str));
                            if ((yyval.cond_node)->banknum < 0) {
                                return ERR_ILLEGAL_INPUT;
                            }
                            (yyval.cond_node)->value = (yyvsp[0].a);
                            (yyval.cond_node)->is_reg = FALSE;
                            (yyval.cond_node)->child1 = NULL; (yyval.cond_node)->child2 = NULL;  
                        }
#line 4197 "mon_parse.c"
    break;

  case 265: /* data_element: number  */
#line 898 "mon_parse.y"
                     { mon_add_number_to_buffer((yyvsp[0].i)); }
#line 4203 "mon_parse.c"
    break;

  case 266: /* data_element: STRING  */
#line 899 "mon_parse.y"
                     { mon_add_string_to_buffer((yyvsp[0].str)); }
#line 4209 "mon_parse.c"
    break;

  case 269: /* hunt_element: number  */
#line 906 "mon_parse.y"
                     { mon_add_number_to_buffer((yyvsp[0].i)); }
#line 4215 "mon_parse.c"
    break;

  case 270: /* hunt_element: MASK  */
#line 907 "mon_parse.y"
                     { mon_add_number_masked_to_buffer((yyvsp[0].i), 0x00); }
#line 4221 "mon_parse.c"
    break;

  case 271: /* hunt_element: STRING  */
#line 908 "mon_parse.y"
                     { mon_add_string_to_buffer((yyvsp[0].str)); }
#line 4227 "mon_parse.c"
    break;

  case 272: /* value: number  */
#line 911 "mon_parse.y"
              { (yyval.i) = (yyvsp[0].i); }
#line 4233 "mon_parse.c"
    break;

  case 273: /* value: register  */
#line 912 "mon_parse.y"
                { (yyval.i) = (monitor_cpu_for_memspace[reg_memspace((yyvsp[0].i))]->mon_register_get_val)(reg_memspace((yyvsp[0].i)), reg_regid((yyvsp[0].i))); }
#line 4239 "mon_parse.c"
    break;

  case 274: /* d_number: D_NUMBER  */
#line 915 "mon_parse.y"
                   { (yyval.i) = (yyvsp[0].i); }
#line 4245 "mon_parse.c"
    break;

  case 275: /* d_number: B_NUMBER_GUESS  */
#line 916 "mon_parse.y"
                         { (yyval.i) = (int)strtol((yyvsp[0].str), NULL, 10); }
#line 4251 "mon_parse.c"
    break;

  case 276: /* d_number: D_NUMBER_GUESS  */
#line 917 "mon_parse.y"
                         { (yyval.i) = (int)strtol((yyvsp[0].str), NULL, 10); }
#line 4257 "mon_parse.c"
    break;

  case 277: /* d_number: O_NUMBER_GUESS  */
#line 918 "mon_parse.y"
                         { (yyval.i) = (int)strtol((yyvsp[0].str), NULL, 10); }
#line 4263 "mon_parse.c"
    break;

  case 278: /* opt_d_number: d_number  */
#line 921 "mon_parse.y"
                       { (yyval.i) = (yyvsp[0].i); }
#line 4269 "mon_parse.c"
    break;

  case 279: /* opt_d_number: %empty  */
#line 922 "mon_parse.y"
              { (yyval.i) = -1; }
#line 4275 "mon_parse.c"
    break;

  case 280: /* guess_default: B_NUMBER_GUESS  */
#line 925 "mon_parse.y"
                              { (yyval.i) = resolve_datatype(B_NUMBER,(yyvsp[0].str)); }
#line 4281 "mon_parse.c"
    break;

  case 281: /* guess_default: D_NUMBER_GUESS  */
#line 926 "mon_parse.y"
                              { (yyval.i) = resolve_datatype(D_NUMBER,(yyvsp[0].str)); }
#line 4287 "mon_parse.c"
    break;

  case 282: /* guess_default: O_NUMBER_GUESS  */
#line 927 "mon_parse.y"
                              { (yyval.i) = resolve_datatype(O_NUMBER,(yyvsp[0].str)); }
#line 4293 "mon_parse.c"
    break;

  case 283: /* number: H_NUMBER  */
#line 930 "mon_parse.y"
                 { (yyval.i) = (yyvsp[0].i); }
#line 4299 "mon_parse.c"
    break;

  case 284: /* number: B_NUMBER  */
#line 931 "mon_parse.y"
                 { (yyval.i) = (yyvsp[0].i); }
#line 4305 "mon_parse.c"
    break;

  case 285: /* number: D_NUMBER  */
#line 932 "mon_parse.y"
                 { (yyval.i) = (yyvsp[0].i); }
#line 4311 "mon_parse.c"
    break;

  case 286: /* number: O_NUMBER  */
#line 933 "mon_parse.y"
                 { (yyval.i) = (yyvsp[0].i); }
#line 4317 "mon_parse.c"
    break;

  case 287: /* number: guess_default  */
#line 934 "mon_parse.y"
                      { (yyval.i) = (yyvsp[0].i); }
#line 4323 "mon_parse.c"
    break;

  case 291: /* assembly_instruction: OPCODE asm_operand_mode  */
#line 942 "mon_parse.y"
                                              { (yyval.i) = 0;
                                                if ((yyvsp[-1].str)) {
                                                    (monitor_cpu_for_memspace[default_memspace]->mon_assemble_instr)((yyvsp[-1].str), (yyvsp[0].mode));
                                                } else {
                                                    new_cmd = 1;
                                                    asm_mode = 0;
                                                }
                                                opt_asm = 0;
                                              }
#line 4337 "mon_parse.c"
    break;

  case 293: /* post_assemble: assembly_instr_list  */
#line 953 "mon_parse.y"
                                   { asm_mode = 0; }
#line 4343 "mon_parse.c"
    break;

  case 294: /* asm_operand_mode: ARG_IMMEDIATE number  */
#line 956 "mon_parse.y"
                                       { if ((yyvsp[0].i) > 0xff) {
                          (yyval.mode).addr_mode = ASM_ADDR_MODE_IMMEDIATE_16;
                          (yyval.mode).param = (yyvsp[0].i);
                        } else {
                          (yyval.mode).addr_mode = ASM_ADDR_MODE_IMMEDIATE;
                          (yyval.mode).param = (yyvsp[0].i);
                        } }
#line 4355 "mon_parse.c"
    break;

  case 295: /* asm_operand_mode: number  */
#line 963 "mon_parse.y"
           { if ((yyvsp[0].i) >= 0x10000) {
               (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_LONG;
               (yyval.mode).param = (yyvsp[0].i);
             } else if ((yyvsp[0].i) < 0x100) {
               (yyval.mode).addr_mode = ASM_ADDR_MODE_ZERO_PAGE;
               (yyval.mode).param = (yyvsp[0].i);
             } else {
               (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE;
               (yyval.mode).param = (yyvsp[0].i);
             }
           }
#line 4371 "mon_parse.c"
    break;

  case 296: /* asm_operand_mode: number COMMA REG_X  */
#line 974 "mon_parse.y"
                        { if ((yyvsp[-2].i) >= 0x10000) {
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_LONG_X;
                            (yyval.mode).param = (yyvsp[-2].i);
                          } else if ((yyvsp[-2].i) < 0x100) { 
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_ZERO_PAGE_X;
                            (yyval.mode).param = (yyvsp[-2].i);
                          } else {
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_X;
                            (yyval.mode).param = (yyvsp[-2].i);
                          }
                        }
#line 4387 "mon_parse.c"
    break;

  case 297: /* asm_operand_mode: number COMMA REG_Y  */
#line 985 "mon_parse.y"
                        { if ((yyvsp[-2].i) < 0x100) {
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_ZERO_PAGE_Y;
                            (yyval.mode).param = (yyvsp[-2].i);
                          } else {
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_Y;
                            (yyval.mode).param = (yyvsp[-2].i);
                          }
                        }
#line 4400 "mon_parse.c"
    break;

  case 298: /* asm_operand_mode: number COMMA REG_S  */
#line 993 "mon_parse.y"
                        { if ((yyvsp[-2].i) < 0x100) {
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_STACK_RELATIVE;
                            (yyval.mode).param = (yyvsp[-2].i);
                          } else { /* 6809 */
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
                            if ((yyvsp[-2].i) >= -16 && (yyvsp[-2].i) < 16) {
                                (yyval.mode).addr_submode = (yyvsp[0].i) | ((yyvsp[-2].i) & 0x1F);
                            } else if ((yyvsp[-2].i) >= -128 && (yyvsp[-2].i) < 128) {
                                (yyval.mode).addr_submode = 0x80 | (yyvsp[0].i) | ASM_ADDR_MODE_INDEXED_OFF8;
                                (yyval.mode).param = (yyvsp[-2].i);
                            } else if ((yyvsp[-2].i) >= -32768 && (yyvsp[-2].i) < 32768) {
                                (yyval.mode).addr_submode = 0x80 | (yyvsp[0].i) | ASM_ADDR_MODE_INDEXED_OFF16;
                                (yyval.mode).param = (yyvsp[-2].i);
                            } else {
                                (yyval.mode).addr_mode = ASM_ADDR_MODE_ILLEGAL;
                                mon_out("offset too large even for 16 bits (signed)\n");
                            }
                          }
                        }
#line 4424 "mon_parse.c"
    break;

  case 299: /* asm_operand_mode: number COMMA number  */
#line 1012 "mon_parse.y"
                        { if ((yyvsp[-2].i) < 0x100) {
                            (yyval.mode).addr_mode = ASM_ADDR_MODE_DOUBLE;
                            (yyval.mode).param = (yyvsp[0].i);
                            (yyval.mode).addr_submode = (yyvsp[-2].i);
                          }
                        }
#line 4435 "mon_parse.c"
    break;

  case 300: /* asm_operand_mode: L_PAREN number R_PAREN  */
#line 1018 "mon_parse.y"
                           { if ((yyvsp[-1].i) < 0x100) {
                               (yyval.mode).addr_mode = ASM_ADDR_MODE_INDIRECT;
                               (yyval.mode).param = (yyvsp[-1].i);
                             } else {
                               (yyval.mode).addr_mode = ASM_ADDR_MODE_ABS_INDIRECT;
                               (yyval.mode).param = (yyvsp[-1].i);
                             }
                           }
#line 4448 "mon_parse.c"
    break;

  case 301: /* asm_operand_mode: L_PAREN number COMMA REG_X R_PAREN  */
#line 1026 "mon_parse.y"
                                       { if ((yyvsp[-3].i) < 0x100) {
                                           (yyval.mode).addr_mode = ASM_ADDR_MODE_INDIRECT_X;
                                           (yyval.mode).param = (yyvsp[-3].i);
                                         } else {
                                           (yyval.mode).addr_mode = ASM_ADDR_MODE_ABS_INDIRECT_X;
                                           (yyval.mode).param = (yyvsp[-3].i);
                                         }
                                       }
#line 4461 "mon_parse.c"
    break;

  case 302: /* asm_operand_mode: L_PAREN number COMMA REG_S R_PAREN COMMA REG_Y  */
#line 1035 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_STACK_RELATIVE_Y; (yyval.mode).param = (yyvsp[-5].i); }
#line 4467 "mon_parse.c"
    break;

  case 303: /* asm_operand_mode: L_PAREN number R_PAREN COMMA REG_Y  */
#line 1037 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_INDIRECT_Y; (yyval.mode).param = (yyvsp[-3].i); }
#line 4473 "mon_parse.c"
    break;

  case 304: /* asm_operand_mode: L_PAREN REG_BC R_PAREN  */
#line 1038 "mon_parse.y"
                           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IND_BC; }
#line 4479 "mon_parse.c"
    break;

  case 305: /* asm_operand_mode: L_PAREN REG_DE R_PAREN  */
#line 1039 "mon_parse.y"
                           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IND_DE; }
#line 4485 "mon_parse.c"
    break;

  case 306: /* asm_operand_mode: L_PAREN REG_HL R_PAREN  */
#line 1040 "mon_parse.y"
                           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IND_HL; }
#line 4491 "mon_parse.c"
    break;

  case 307: /* asm_operand_mode: L_PAREN REG_IX R_PAREN  */
#line 1041 "mon_parse.y"
                           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IND_IX; }
#line 4497 "mon_parse.c"
    break;

  case 308: /* asm_operand_mode: L_PAREN REG_IY R_PAREN  */
#line 1042 "mon_parse.y"
                           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IND_IY; }
#line 4503 "mon_parse.c"
    break;

  case 309: /* asm_operand_mode: L_PAREN REG_SP R_PAREN  */
#line 1043 "mon_parse.y"
                           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IND_SP; }
#line 4509 "mon_parse.c"
    break;

  case 310: /* asm_operand_mode: L_PAREN number R_PAREN COMMA REG_A  */
#line 1045 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_A; (yyval.mode).param = (yyvsp[-3].i); }
#line 4515 "mon_parse.c"
    break;

  case 311: /* asm_operand_mode: L_PAREN number R_PAREN COMMA REG_HL  */
#line 1047 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_HL; (yyval.mode).param = (yyvsp[-3].i); }
#line 4521 "mon_parse.c"
    break;

  case 312: /* asm_operand_mode: L_PAREN number R_PAREN COMMA REG_IX  */
#line 1049 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_IX; (yyval.mode).param = (yyvsp[-3].i); }
#line 4527 "mon_parse.c"
    break;

  case 313: /* asm_operand_mode: L_PAREN number R_PAREN COMMA REG_IY  */
#line 1051 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_ABSOLUTE_IY; (yyval.mode).param = (yyvsp[-3].i); }
#line 4533 "mon_parse.c"
    break;

  case 314: /* asm_operand_mode: %empty  */
#line 1052 "mon_parse.y"
    { (yyval.mode).addr_mode = ASM_ADDR_MODE_IMPLIED; }
#line 4539 "mon_parse.c"
    break;

  case 315: /* asm_operand_mode: REG_A  */
#line 1053 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_ACCUMULATOR; }
#line 4545 "mon_parse.c"
    break;

  case 316: /* asm_operand_mode: REG_B  */
#line 1054 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_B; }
#line 4551 "mon_parse.c"
    break;

  case 317: /* asm_operand_mode: REG_C  */
#line 1055 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_C; }
#line 4557 "mon_parse.c"
    break;

  case 318: /* asm_operand_mode: REG_D  */
#line 1056 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_D; }
#line 4563 "mon_parse.c"
    break;

  case 319: /* asm_operand_mode: REG_E  */
#line 1057 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_E; }
#line 4569 "mon_parse.c"
    break;

  case 320: /* asm_operand_mode: REG_H  */
#line 1058 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_H; }
#line 4575 "mon_parse.c"
    break;

  case 321: /* asm_operand_mode: REG_IXH  */
#line 1059 "mon_parse.y"
            { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IXH; }
#line 4581 "mon_parse.c"
    break;

  case 322: /* asm_operand_mode: REG_IYH  */
#line 1060 "mon_parse.y"
            { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IYH; }
#line 4587 "mon_parse.c"
    break;

  case 323: /* asm_operand_mode: REG_L  */
#line 1061 "mon_parse.y"
          { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_L; }
#line 4593 "mon_parse.c"
    break;

  case 324: /* asm_operand_mode: REG_IXL  */
#line 1062 "mon_parse.y"
            { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IXL; }
#line 4599 "mon_parse.c"
    break;

  case 325: /* asm_operand_mode: REG_IYL  */
#line 1063 "mon_parse.y"
            { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IYL; }
#line 4605 "mon_parse.c"
    break;

  case 326: /* asm_operand_mode: REG_AF  */
#line 1064 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_AF; }
#line 4611 "mon_parse.c"
    break;

  case 327: /* asm_operand_mode: REG_BC  */
#line 1065 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_BC; }
#line 4617 "mon_parse.c"
    break;

  case 328: /* asm_operand_mode: REG_DE  */
#line 1066 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_DE; }
#line 4623 "mon_parse.c"
    break;

  case 329: /* asm_operand_mode: REG_HL  */
#line 1067 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_HL; }
#line 4629 "mon_parse.c"
    break;

  case 330: /* asm_operand_mode: REG_IX  */
#line 1068 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IX; }
#line 4635 "mon_parse.c"
    break;

  case 331: /* asm_operand_mode: REG_IY  */
#line 1069 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_IY; }
#line 4641 "mon_parse.c"
    break;

  case 332: /* asm_operand_mode: REG_SP  */
#line 1070 "mon_parse.y"
           { (yyval.mode).addr_mode = ASM_ADDR_MODE_REG_SP; }
#line 4647 "mon_parse.c"
    break;

  case 333: /* asm_operand_mode: LESS_THAN number  */
#line 1072 "mon_parse.y"
                     { (yyval.mode).addr_mode = ASM_ADDR_MODE_DIRECT; (yyval.mode).param = (yyvsp[0].i); }
#line 4653 "mon_parse.c"
    break;

  case 334: /* asm_operand_mode: number COMMA index_ureg  */
#line 1073 "mon_parse.y"
                            {    /* Clash with addr,x addr,y addr,s modes! */
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        if ((yyvsp[-2].i) >= -16 && (yyvsp[-2].i) < 16) {
            (yyval.mode).addr_submode = (3 << 5) | ((yyvsp[-2].i) & 0x1F);
        } else if ((yyvsp[-2].i) >= -128 && (yyvsp[-2].i) < 128) {
            (yyval.mode).addr_submode = 0x80 | (3 << 5) | ASM_ADDR_MODE_INDEXED_OFF8;
            (yyval.mode).param = (yyvsp[-2].i);
        } else if ((yyvsp[-2].i) >= -32768 && (yyvsp[-2].i) < 32768) {
            (yyval.mode).addr_submode = 0x80 | (3 << 5) | ASM_ADDR_MODE_INDEXED_OFF16;
            (yyval.mode).param = (yyvsp[-2].i);
        } else {
            (yyval.mode).addr_mode = ASM_ADDR_MODE_ILLEGAL;
            mon_out("offset too large even for 16 bits (signed)\n");
        }
    }
#line 4673 "mon_parse.c"
    break;

  case 335: /* asm_operand_mode: COMMA index_reg PLUS  */
#line 1088 "mon_parse.y"
                         {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_INC1;
        }
#line 4682 "mon_parse.c"
    break;

  case 336: /* asm_operand_mode: COMMA index_reg PLUS PLUS  */
#line 1092 "mon_parse.y"
                              {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-2].i) | ASM_ADDR_MODE_INDEXED_INC2;
        }
#line 4691 "mon_parse.c"
    break;

  case 337: /* asm_operand_mode: COMMA MINUS index_reg  */
#line 1096 "mon_parse.y"
                          {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[0].i) | ASM_ADDR_MODE_INDEXED_DEC1;
        }
#line 4700 "mon_parse.c"
    break;

  case 338: /* asm_operand_mode: COMMA MINUS MINUS index_reg  */
#line 1100 "mon_parse.y"
                                {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[0].i) | ASM_ADDR_MODE_INDEXED_DEC2;
        }
#line 4709 "mon_parse.c"
    break;

  case 339: /* asm_operand_mode: COMMA index_reg  */
#line 1104 "mon_parse.y"
                    {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[0].i) | ASM_ADDR_MODE_INDEXED_OFF0;
        }
#line 4718 "mon_parse.c"
    break;

  case 340: /* asm_operand_mode: REG_B COMMA index_reg  */
#line 1108 "mon_parse.y"
                          {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_OFFB;
        }
#line 4727 "mon_parse.c"
    break;

  case 341: /* asm_operand_mode: REG_A COMMA index_reg  */
#line 1112 "mon_parse.y"
                          {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_OFFA;
        }
#line 4736 "mon_parse.c"
    break;

  case 342: /* asm_operand_mode: REG_D COMMA index_reg  */
#line 1116 "mon_parse.y"
                          {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_OFFD;
        }
#line 4745 "mon_parse.c"
    break;

  case 343: /* asm_operand_mode: number COMMA REG_PC  */
#line 1120 "mon_parse.y"
                        {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).param = (yyvsp[-2].i);
        if ((yyvsp[-2].i) >= -128 && (yyvsp[-2].i) < 128) {
            (yyval.mode).addr_submode = ASM_ADDR_MODE_INDEXED_OFFPC8;
        } else if ((yyvsp[-2].i) >= -32768 && (yyvsp[-2].i) < 32768) {
            (yyval.mode).addr_submode = ASM_ADDR_MODE_INDEXED_OFFPC16;
        } else {
            (yyval.mode).addr_mode = ASM_ADDR_MODE_ILLEGAL;
            mon_out("offset too large even for 16 bits (signed)\n");
        }
    }
#line 4762 "mon_parse.c"
    break;

  case 344: /* asm_operand_mode: L_BRACKET number COMMA index_reg R_BRACKET  */
#line 1132 "mon_parse.y"
                                               {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        if ((yyvsp[-3].i) >= -16 && (yyvsp[-3].i) < 16) {
            (yyval.mode).addr_submode = (yyvsp[-3].i) & 0x1F;
        } else if ((yyvsp[-4].i) >= -128 && (yyvsp[-4].i) < 128) {
            (yyval.mode).addr_submode = ASM_ADDR_MODE_INDEXED_OFF8;
            (yyval.mode).param = (yyvsp[-3].i);
        } else if ((yyvsp[-3].i) >= -32768 && (yyvsp[-3].i) < 32768) {
            (yyval.mode).addr_submode = ASM_ADDR_MODE_INDEXED_OFF16;
            (yyval.mode).param = (yyvsp[-3].i);
        } else {
            (yyval.mode).addr_mode = ASM_ADDR_MODE_ILLEGAL;
            mon_out("offset too large even for 16 bits (signed)\n");
        }
    }
#line 4782 "mon_parse.c"
    break;

  case 345: /* asm_operand_mode: L_BRACKET COMMA index_reg PLUS R_BRACKET  */
#line 1147 "mon_parse.y"
                                             {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-2].i) | ASM_ADDR_MODE_INDEXED_INC1;
        }
#line 4791 "mon_parse.c"
    break;

  case 346: /* asm_operand_mode: L_BRACKET COMMA index_reg PLUS PLUS R_BRACKET  */
#line 1151 "mon_parse.y"
                                                  {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-3].i) | ASM_ADDR_MODE_INDEXED_INC2;
        }
#line 4800 "mon_parse.c"
    break;

  case 347: /* asm_operand_mode: L_BRACKET COMMA MINUS index_reg R_BRACKET  */
#line 1155 "mon_parse.y"
                                              {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_DEC1;
        }
#line 4809 "mon_parse.c"
    break;

  case 348: /* asm_operand_mode: L_BRACKET COMMA MINUS MINUS index_reg R_BRACKET  */
#line 1159 "mon_parse.y"
                                                    {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_DEC2;
        }
#line 4818 "mon_parse.c"
    break;

  case 349: /* asm_operand_mode: L_BRACKET COMMA index_reg R_BRACKET  */
#line 1163 "mon_parse.y"
                                        {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-1].i) | ASM_ADDR_MODE_INDEXED_OFF0;
        }
#line 4827 "mon_parse.c"
    break;

  case 350: /* asm_operand_mode: L_BRACKET REG_B COMMA index_reg R_BRACKET  */
#line 1167 "mon_parse.y"
                                              {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-2].i) | ASM_ADDR_MODE_INDEXED_OFFB;
        }
#line 4836 "mon_parse.c"
    break;

  case 351: /* asm_operand_mode: L_BRACKET REG_A COMMA index_reg R_BRACKET  */
#line 1171 "mon_parse.y"
                                              {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-2].i) | ASM_ADDR_MODE_INDEXED_OFFA;
        }
#line 4845 "mon_parse.c"
    break;

  case 352: /* asm_operand_mode: L_BRACKET REG_D COMMA index_reg R_BRACKET  */
#line 1175 "mon_parse.y"
                                              {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | (yyvsp[-2].i) | ASM_ADDR_MODE_INDEXED_OFFD;
        }
#line 4854 "mon_parse.c"
    break;

  case 353: /* asm_operand_mode: L_BRACKET number COMMA REG_PC R_BRACKET  */
#line 1179 "mon_parse.y"
                                            {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).param = (yyvsp[-3].i);
        if ((yyvsp[-3].i) >= -128 && (yyvsp[-3].i) < 128) {
            (yyval.mode).addr_submode = ASM_ADDR_MODE_INDEXED_OFFPC8_IND;
        } else if ((yyvsp[-3].i) >= -32768 && (yyvsp[-3].i) < 32768) {
            (yyval.mode).addr_submode = ASM_ADDR_MODE_INDEXED_OFFPC16_IND;
        } else {
            (yyval.mode).addr_mode = ASM_ADDR_MODE_ILLEGAL;
            mon_out("offset too large even for 16 bits (signed)\n");
        }
    }
#line 4871 "mon_parse.c"
    break;

  case 354: /* asm_operand_mode: L_BRACKET number R_BRACKET  */
#line 1191 "mon_parse.y"
                               {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDEXED;
        (yyval.mode).addr_submode = 0x80 | ASM_ADDR_MODE_EXTENDED_INDIRECT;
        (yyval.mode).param = (yyvsp[-1].i);
        }
#line 4881 "mon_parse.c"
    break;

  case 355: /* asm_operand_mode: L_BRACKET number R_BRACKET COMMA REG_Y  */
#line 1196 "mon_parse.y"
                                           {
        (yyval.mode).addr_mode = ASM_ADDR_MODE_INDIRECT_LONG_Y;
        (yyval.mode).param = (yyvsp[-3].i);
        }
#line 4890 "mon_parse.c"
    break;

  case 356: /* index_reg: REG_X  */
#line 1204 "mon_parse.y"
          { (yyval.i) = (0 << 5); printf("reg_x\n"); }
#line 4896 "mon_parse.c"
    break;

  case 357: /* index_reg: REG_Y  */
#line 1205 "mon_parse.y"
          { (yyval.i) = (1 << 5); printf("reg_y\n"); }
#line 4902 "mon_parse.c"
    break;

  case 358: /* index_reg: index_ureg  */
#line 1206 "mon_parse.y"
               { (yyval.i) = (yyvsp[0].i); }
#line 4908 "mon_parse.c"
    break;

  case 359: /* index_reg: REG_S  */
#line 1207 "mon_parse.y"
          { (yyval.i) = (3 << 5); printf("reg_s\n"); }
#line 4914 "mon_parse.c"
    break;

  case 360: /* index_ureg: REG_U  */
#line 1211 "mon_parse.y"
          { (yyval.i) = (2 << 5); printf("reg_u\n"); }
#line 4920 "mon_parse.c"
    break;


#line 4924 "mon_parse.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 1215 "mon_parse.y"


int parse_and_execute_line(char *input)
{
   char *temp_buf;
   int i, rc;

   if (default_memspace == e_comp_space) {
       /*
        * If the command is to be executed when the default address space is the main cpu,
        * Ensure drive CPU emulation is up to date with main cpu CLOCK.
        */
       drive_cpu_execute_all(maincpu_clk);
   }

   temp_buf = lib_malloc(strlen(input) + 3);
   strcpy(temp_buf,input);
   i = (int)strlen(input);
   temp_buf[i++] = '\n';
   temp_buf[i++] = '\0';
   temp_buf[i++] = '\0';

   make_buffer(temp_buf);
   mon_clear_buffer();
   if ( (rc =yyparse()) != 0) {
       mon_out("ERROR -- ");
       switch(rc) {
         case ERR_BAD_CMD:
           mon_out("Bad command:\n");
           break;
         case ERR_RANGE_BAD_START:
           mon_out("Bad first address in range:\n");
           break;
         case ERR_RANGE_BAD_END:
           mon_out("Bad second address in range:\n");
           break;
         case ERR_EXPECT_CHECKNUM:
           mon_out("Checkpoint number expected:\n");
           break;
         case ERR_EXPECT_END_CMD:
           mon_out("Unexpected token:\n");
           break;
         case ERR_MISSING_CLOSE_PAREN:
           mon_out("')' expected:\n");
           break;
         case ERR_INCOMPLETE_COND_OP:
           mon_out("Conditional operation missing an operand:\n");
           break;
         case ERR_EXPECT_FILENAME:
           mon_out("Expecting a filename:\n");
           break;
         case ERR_ADDR_TOO_BIG:
           mon_out("Address too large:\n");
           break;
         case ERR_IMM_TOO_BIG:
           mon_out("Immediate argument too large:\n");
           break;
         case ERR_EXPECT_STRING:
           mon_out("Expecting a string.\n");
           break;
         case ERR_UNDEFINED_LABEL:
           mon_out("Found an undefined label.\n");
           break;
         case ERR_EXPECT_DEVICE_NUM:
           mon_out("Expecting a device number.\n");
           break;
         case ERR_EXPECT_ADDRESS:
           mon_out("Expecting an address.\n");
           break;
         case ERR_INVALID_REGISTER:
           mon_out("Invalid register.\n");
           break;
         case ERR_ILLEGAL_INPUT:
         default:
           mon_out("Wrong syntax:\n");
       }
       mon_out("  %s\n", input);
       for (i = 0; i < last_len; i++)
           mon_out(" ");
       mon_out("  ^\n");
       asm_mode = 0;
       new_cmd = 1;
   }
   lib_free(temp_buf);
   free_buffer();

   return rc;
}

void set_yydebug(int val)
{
#if YYDEBUG
    yydebug = val;
#else
#endif
}

static int yyerror(char *s)
{
#if 0
   fprintf(stderr, "ERR:%s\n", s);
#endif
   return 0;
}

/* convert the string in "num" to a numeric value, depending on radix. this 
   function does some magic conversion on addresses when radix is not hex.
*/
static int resolve_datatype(unsigned guess_type, const char *num)
{
    int binary = 1, hex = 0, octal = 0, decimal = 1;
    const char *c;

    /* FIXME: Handle cases when default type is non-numerical */
    if (default_radix == e_hexadecimal) {
        return (int)strtol(num, NULL, 16);
    }

    /* we do some educated guessing on what type of number we have here */
    if (num[0] == '0') {
        /* might be octal with leading zero */
        octal = 1;
    }
    /* a string containing any digits not 0 or 1 can't be a binary number */
    c = num;
    while (*c) {
        if ((*c != '0') && (*c != '1')) {
            binary = 0;
            break;
        }
        c++;
    }
    /* a string containing 8 or 9 can't be an octal number */
    c = num;
    while (*c) {
        if ((*c == '8') && (*c == '9')) {
            octal = 0;
            break;
        }
        c++;
    }
    /* a string containing any of A-F can only be a hex number */
    c = num;
    while (*c) {
        if ((tolower((unsigned char)*c) >= 'a') && (tolower((unsigned char)*c) <= 'f')) {
            hex = 1;
            octal = 0;
            binary = 0;
            decimal = 0;
            break;
        }
        c++;
    }

    /* a hex number can only be hex no matter what */
    if (hex) {
        return (int)strtol(num, NULL, 16);
    }

    /* first, if default radix and detected number matches, just do it */
    if (binary && (default_radix == e_binary)) {
        return (int)strtol(num, NULL, 2);
    }
    if (decimal && (default_radix == e_decimal)) {
        return (int)strtol(num, NULL, 10);
    }
    if (octal && (default_radix == e_octal)) {
        return (int)strtol(num, NULL, 8);
    }

    /* second, if detected number matches guess type, do it */
    if (binary && (guess_type == B_NUMBER)) {
        return (int)strtol(num, NULL, 2);
    }
    if (decimal && (guess_type == D_NUMBER)) {
        return (int)strtol(num, NULL, 10);
    }
    if (octal && (guess_type == O_NUMBER)) {
        return (int)strtol(num, NULL, 8);
    }

    /* third only use the detected type */
    if (binary) {
        return (int)strtol(num, NULL, 2);
    }
    if (decimal) {
        return (int)strtol(num, NULL, 10);
    }
    if (octal) {
        return (int)strtol(num, NULL, 8);
    }

    /* use hex as default, should we ever come here */
    return (int)strtol(num, NULL, 16);
}

/*
 * Resolve a character sequence containing 8 hex digits like "08001000".
 * This could be a lazy version of "0800 1000". If the default radix is not
 * hexadecimal, we handle it like a ordinary number, in the latter case there
 * is only one number in the range.
 */
static int resolve_range(enum t_memspace memspace, MON_ADDR range[2],
                         const char *num)
{
    char start[5];
    char end[5];
    long sa;

    range[1] = BAD_ADDR;

    switch (default_radix)
    {
    case e_hexadecimal:
        /* checked twice, but as the code must have exactly 8 digits: */
        if (strlen(num) == 8) {
            memcpy(start, num, 4);
            start[4] = '\0';
            memcpy(end, num + 4, 4);
            end[4] = '\0';
            sa = strtol(start, NULL, 16);
            range[1] = (int)new_addr(memspace, strtol(end, NULL, 16));
        }
        else
            sa = strtol(num, NULL, 16);
        break;

    case e_decimal:
       sa = strtol(num, NULL, 10);
       break;

    case e_octal:
       sa = strtol(num, NULL, 8);
       break;

    default:
       sa = strtol(num, NULL, 2);
    }

    if (!CHECK_ADDR(sa))
        return ERR_ADDR_TOO_BIG;

    range[0] = (int)new_addr(memspace, sa);
    return 0;
}

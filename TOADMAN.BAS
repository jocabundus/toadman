
'============================================================
'=                    DELTA CODE PRESENTS                   =
'=                       ***TOADMAN***                      =
'=                        VERSION 1.6                       =
'============================================================

'1999-2000 Created by Joe King

'****PRESS F2 AND GOTO ABOUT FOR HELP AND INFO****

DECLARE SUB MAZE8 (MZ$())
DECLARE SUB MAZE7 (MZ$())
DECLARE SUB LEVELBUILBER (MZ$(), SPRITES%(), EPS%, SP%(), LB%)
DECLARE SUB MAZE4 (MZ$())
DECLARE SUB MAZE3 (MZ$())
DECLARE SUB MAZE2 (MZ$())
DECLARE SUB INTRO (SPRITES%(), EPS%, az%)
DECLARE SUB MAZE1 (MZ$())
DECLARE SUB MAZE5 (MZ$())
DECLARE SUB MAZE6 (MZ$())
COMMON SHARED Speed&, BSpeed&, ESpeed&


RANDOMIZE TIMER

10
CLEAR , , 20000
DIM SHARED CR%
DIM SHARED B1%(40, 40)
DIM SHARED B2%(40, 40)
LB% = 0
DO
a$ = INKEY$
LOOP UNTIL a$ = ""

DEFINT A-Z

TYPE HUES
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

SCREEN 13

DIM Pal(255) AS HUES
DEF SEG = VARSEG(Pal(0))
BLOAD "TOADMAN.PAL", 0
OUT &H3C8, 0
FOR atrib = 0 TO 255
 OUT &H3C9, Pal(atrib).red
 OUT &H3C9, Pal(atrib).grn
 OUT &H3C9, Pal(atrib).blu
NEXT atrib


'Select file to view

Filename$ = "TOADMAN.SPR"


OPEN Filename$ FOR BINARY AS #1
filesize& = LOF(1)
CLOSE #1


bytes = (filesize& - 7) \ 2 - 1
REDIM SPRITES(bytes)
DEF SEG = VARSEG(SPRITES(0))
BLOAD Filename$, 0
spritewidth = SPRITES(0) \ 8
spriteheight = SPRITES(1)


xsprites = 319 \ (spritewidth + 1)
xend = spritewidth * (xsprites - 1) + xsprites
EPS% = ((spritewidth * spriteheight) \ 2) + 3
DIM MZ$(40)
DIM SP%(10, 40)


'*****THESE ARE THE SPEED CONSTANTS*****
Speed& = 1      '*****This is how long you will see the flame when you shoot
BSpeed& = 1000  '*****This is how fast the badguys move
ESpeed& = 32000 '*****This is how fast the toads explode
'========================================

CALL INTRO(SPRITES%(), EPS%, az%)
IF CR% = 1 THEN CR% = 0: GOTO 10
IF az% = 1 THEN CALL MAZE1(MZ$())
IF az% = 2 THEN CALL MAZE2(MZ$())
IF az% = 3 THEN CALL MAZE3(MZ$())
IF az% = 4 THEN CALL MAZE4(MZ$())
IF az% = 5 THEN CALL MAZE5(MZ$())
IF az% = 6 THEN CALL MAZE6(MZ$())
IF az% = 7 THEN CALL MAZE7(MZ$())
IF az% = 8 THEN CALL MAZE8(MZ$())
IF az% = 98 THEN GOTO 10
754
IF az% = 99 THEN CALL LEVELBUILBER(MZ$(), SPRITES%(), EPS%, SP%(), LB%)
CLS
GOSUB MAP

FIRE1% = 5: FIRE2% = 5
FOR zz% = 1 TO 40
FOR yy% = 1 TO 40
IF MID$(MZ$(yy%), zz%, 1) = "B" THEN PO%(1) = yy%: PO%(2) = zz%: OP%(1) = PO%(1): OP%(2) = PO%(2): MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) = "b" THEN PT%(1) = yy%: PT%(2) = zz%: TP%(1) = PT%(1): TP%(2) = PT%(2): MID$(MZ$(yy%), zz%, 1) = " "
NEXT yy%
NEXT zz%
PUTUPSCREEN:
LOCATE 8, 8: COLOR 1: PRINT "ллллллллл    ллллллллл"
LOCATE 16, 8: PRINT "ллллллллл    ллллллллл"
FOR yy% = 9 TO 15
LOCATE yy%, 8: PRINT "л"
LOCATE yy%, 16: PRINT "л"
LOCATE yy%, 21: PRINT "л"
LOCATE yy%, 29: PRINT "л"
NEXT yy%
IF ZX% = 1 THEN ZX% = 0: RETURN
K% = 1: LFA% = 100
KL% = 3: LFB% = 100
BGB% = 200
BGA% = 200
gasa% = 150: gasb% = 150
GOSUB LIFE

'SCAN WHAT'S AROUND YOU
100
IF PO%(1) = PT%(1) AND PO%(2) = PT%(2) THEN PO%(1) = OP%(1): PT%(1) = TP%(1): PO%(2) = OP%(2): PT%(2) = TP%(2): GOTO 104
IF BGB% > 0 THEN IF PO%(1) = BD%(1) AND PO%(2) = BD%(2) THEN PO%(1) = OP%(1): DB%(1) = BD%(1): PO%(2) = OP%(2): BD%(2) = DB%(2): GOTO 104
IF BGB% > 0 THEN IF PT%(1) = BD%(1) AND PT%(2) = BD%(2) THEN PT%(1) = TP%(1): PT%(2) = TP%(2): GOTO 104
IF BGA% > 0 THEN IF PO%(1) = BD%(3) AND PO%(2) = BD%(4) THEN PO%(1) = OP%(1): PO%(2) = OP%(2): GOTO 104
IF BGA% > 0 THEN IF PT%(1) = BD%(3) AND PT%(2) = BD%(4) THEN PT%(1) = TP%(1): PT%(2) = TP%(2): GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "K" THEN keya1% = keya1% + 1: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "K" THEN keyb1% = keyb1% + 1: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "k" THEN keya2% = keya2% + 1: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "k" THEN keyb2% = keyb2% + 1: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "R" THEN keya3% = keya3% + 1: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "R" THEN keyb3% = keyb3% + 1: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "D" AND keya1% > 0 THEN : keya1% = keya1% - 1: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "D" AND keyb1% > 0 THEN : keyb1% = keyb1% - 1: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "d" AND keya2% > 0 THEN : keya2% = keya2% - 1: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "d" AND keyb2% > 0 THEN : keyb2% = keyb2% - 1: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "r" AND keya3% > 0 THEN : keya3% = keya3% - 1: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "r" AND keyb3% > 0 THEN : keyb3% = keyb3% - 1: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "n" THEN LFA% = LFA% + 5: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "n" THEN LFB% = LFB% + 5: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "N" THEN LFA% = LFA% + 10: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "N" THEN LFB% = LFB% + 10: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "M" THEN LFA% = LFA% + 50: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "M" THEN LFB% = LFB% + 50: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "_" THEN gasa% = gasa% + 10: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "_" THEN gasb% = gasb% + 10: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "=" THEN gasa% = gasa% + 30: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "=" THEN gasb% = gasb% + 30: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "+" THEN gasa% = gasa% + 100: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "+" THEN gasb% = gasb% + 100: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "*" THEN SUPERFLAME1% = 1: EXTRAFLAME1% = 150: FIRE1% = 10: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "*" THEN SUPERFLAME2% = 1: EXTRAFLAME2% = 150: FIRE2% = 10: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) = "#" THEN EXTRALIFE1% = 1: FIRE1% = 10: GOSUB 386: GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) = "#" THEN EXTRALIFE2% = 1: FIRE2% = 10: GOSUB 486: GOTO 104
IF MID$(MZ$(PO%(1)), PO%(2), 1) <> " " THEN PO%(1) = OP%(1): PO%(2) = OP%(2): GOTO 104
IF MID$(MZ$(PT%(1)), PT%(2), 1) <> " " THEN PT%(1) = TP%(1): PT%(2) = TP%(2)
104


B% = 0: C% = 0
y% = 0: z% = 0
FOR yy% = -3 TO 3 STEP 1
FOR zz% = -3 TO 3 STEP 1
IF zz% = 0 AND yy% = 0 THEN GOTO 103
dy% = (12 - yy%) * 8 - 8
dz% = (12 - zz%) * 8 - 8
IF PO%(2) - yy% <= 0 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 105
IF PO%(1) - zz% <= 0 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 105
IF PO%(2) - yy% >= 41 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 105
IF PO%(1) - zz% >= 41 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 105

IF PO%(1) = PT%(1) + zz% AND PO%(2) = PT%(2) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * KL%), PSET: GOTO 105
IF BGB% > 0 THEN IF PO%(1) = BD%(1) + zz% AND PO%(2) = BD%(2) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * BK%), PSET: B% = 1: dp%(1) = dy%: dp%(2) = dz%: GOTO 105
IF BGA% > 0 THEN IF PO%(1) = BD%(3) + zz% AND PO%(2) = BD%(4) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * KB%), PSET: y% = 1: dp%(1) = dy%: dp%(2) = dz%: GOTO 105
IF H% = 1 THEN IF PO%(1) = BD%(1) + zz% AND PO%(2) = BD%(2) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * BK%), PSET: B% = 1: dp%(1) = dy%: dp%(2) = dz%: H% = 0: GOTO 105
IF J% = 1 THEN IF PO%(1) = BD%(3) + zz% AND PO%(2) = BD%(4) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * KB%), PSET: y% = 1: dp%(1) = dy%: dp%(2) = dz%: J% = 0: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = " " THEN PUT (dy%, dz%), SPRITES(EPS% * 17), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "1" THEN PUT (dy%, dz%), SPRITES(EPS% * 70), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "2" THEN PUT (dy%, dz%), SPRITES(EPS% * 71), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "3" THEN PUT (dy%, dz%), SPRITES(EPS% * 72), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "4" THEN PUT (dy%, dz%), SPRITES(EPS% * 73), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "5" THEN PUT (dy%, dz%), SPRITES(EPS% * 74), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "T" THEN PUT (dy%, dz%), SPRITES(EPS% * 75), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "t" THEN PUT (dy%, dz%), SPRITES(EPS% * 76), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "Y" THEN PUT (dy%, dz%), SPRITES(EPS% * 95), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "y" THEN PUT (dy%, dz%), SPRITES(EPS% * 96), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "S" THEN PUT (dy%, dz%), SPRITES(EPS% * 77), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "s" THEN PUT (dy%, dz%), SPRITES(EPS% * 78), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "6" THEN PUT (dy%, dz%), SPRITES(EPS% * 79), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "7" THEN PUT (dy%, dz%), SPRITES(EPS% * 80), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "8" THEN PUT (dy%, dz%), SPRITES(EPS% * 81), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "9" THEN PUT (dy%, dz%), SPRITES(EPS% * 82), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "0" THEN PUT (dy%, dz%), SPRITES(EPS% * 83), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "G" THEN PUT (dy%, dz%), SPRITES(EPS% * 84), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "W" THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "V" THEN PUT (dy%, dz%), SPRITES(EPS% * 86), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "v" THEN PUT (dy%, dz%), SPRITES(EPS% * 87), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "-" THEN PUT (dy%, dz%), SPRITES(EPS% * 88), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "A" THEN PUT (dy%, dz%), SPRITES(EPS% * 89), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "a" THEN PUT (dy%, dz%), SPRITES(EPS% * 90), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "Z" THEN PUT (dy%, dz%), SPRITES(EPS% * 93), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "z" THEN PUT (dy%, dz%), SPRITES(EPS% * 94), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "K" THEN PUT (dy%, dz%), SPRITES(EPS% * 35), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "D" THEN PUT (dy%, dz%), SPRITES(EPS% * 36), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "k" THEN PUT (dy%, dz%), SPRITES(EPS% * 37), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "d" THEN PUT (dy%, dz%), SPRITES(EPS% * 38), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "R" THEN PUT (dy%, dz%), SPRITES(EPS% * 39), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "r" THEN PUT (dy%, dz%), SPRITES(EPS% * 40), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "F" THEN PUT (dy%, dz%), SPRITES(EPS% * 4), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "f" THEN PUT (dy%, dz%), SPRITES(EPS% * 5), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "Q" THEN PUT (dy%, dz%), SPRITES(EPS% * 6), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "q" THEN PUT (dy%, dz%), SPRITES(EPS% * 7), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "n" THEN PUT (dy%, dz%), SPRITES(EPS% * 32), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "N" THEN PUT (dy%, dz%), SPRITES(EPS% * 33), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "M" THEN PUT (dy%, dz%), SPRITES(EPS% * 34), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "_" THEN PUT (dy%, dz%), SPRITES(EPS% * 67), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "=" THEN PUT (dy%, dz%), SPRITES(EPS% * 68), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "+" THEN PUT (dy%, dz%), SPRITES(EPS% * 69), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "L" THEN PUT (dy%, dz%), SPRITES(EPS% * 91), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "l" THEN PUT (dy%, dz%), SPRITES(EPS% * 92), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "*" THEN PUT (dy%, dz%), SPRITES(EPS% * 97), PSET: GOTO 105
IF MID$(MZ$(PO%(1) - zz%), PO%(2) - yy%, 1) = "#" THEN PUT (dy%, dz%), SPRITES(EPS% * 98), PSET: GOTO 105
105
dy% = (25 - yy%) * 8 - 8
dz% = (12 - zz%) * 8 - 8
IF PT%(2) - yy% <= 0 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 103
IF PT%(1) - zz% <= 0 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 103
IF PT%(2) - yy% >= 41 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 103
IF PT%(1) - zz% >= 41 THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 103

IF PT%(1) = PO%(1) + zz% AND PT%(2) = PO%(2) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * LK%), PSET: GOTO 103
IF BGB% > 0 THEN IF PT%(1) = BD%(1) + zz% AND PT%(2) = BD%(2) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * BK%), PSET: C% = 1: dp%(3) = dy%: dp%(4) = dz%: GOTO 103
IF BGA% > 0 THEN IF PT%(1) = BD%(3) + zz% AND PT%(2) = BD%(4) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * KB%), PSET: z% = 1: dp%(3) = dy%: dp%(4) = dz%: GOTO 103
IF I% = 1 THEN IF PT%(1) = BD%(1) + zz% AND PT%(2) = BD%(2) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * BK%), PSET: C% = 1: dp%(3) = dy%: dp%(4) = dz%: I% = 0: GOTO 103
IF K% = 1 THEN IF PT%(1) = BD%(3) + zz% AND PT%(2) = BD%(4) + yy% THEN PUT (dy%, dz%), SPRITES(EPS% * KB%), PSET: z% = 1: dp%(3) = dy%: dp%(4) = dz%: K% = 0: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = " " THEN PUT (dy%, dz%), SPRITES(EPS% * 17), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "1" THEN PUT (dy%, dz%), SPRITES(EPS% * 70), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "2" THEN PUT (dy%, dz%), SPRITES(EPS% * 71), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "3" THEN PUT (dy%, dz%), SPRITES(EPS% * 72), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "4" THEN PUT (dy%, dz%), SPRITES(EPS% * 73), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "5" THEN PUT (dy%, dz%), SPRITES(EPS% * 74), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "T" THEN PUT (dy%, dz%), SPRITES(EPS% * 75), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "t" THEN PUT (dy%, dz%), SPRITES(EPS% * 76), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "Y" THEN PUT (dy%, dz%), SPRITES(EPS% * 95), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "y" THEN PUT (dy%, dz%), SPRITES(EPS% * 96), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "S" THEN PUT (dy%, dz%), SPRITES(EPS% * 77), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "s" THEN PUT (dy%, dz%), SPRITES(EPS% * 78), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "6" THEN PUT (dy%, dz%), SPRITES(EPS% * 79), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "7" THEN PUT (dy%, dz%), SPRITES(EPS% * 80), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "8" THEN PUT (dy%, dz%), SPRITES(EPS% * 81), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "9" THEN PUT (dy%, dz%), SPRITES(EPS% * 82), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "0" THEN PUT (dy%, dz%), SPRITES(EPS% * 83), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "G" THEN PUT (dy%, dz%), SPRITES(EPS% * 84), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "W" THEN PUT (dy%, dz%), SPRITES(EPS% * 85), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "V" THEN PUT (dy%, dz%), SPRITES(EPS% * 86), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "v" THEN PUT (dy%, dz%), SPRITES(EPS% * 87), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "-" THEN PUT (dy%, dz%), SPRITES(EPS% * 88), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "A" THEN PUT (dy%, dz%), SPRITES(EPS% * 89), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "a" THEN PUT (dy%, dz%), SPRITES(EPS% * 90), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "Z" THEN PUT (dy%, dz%), SPRITES(EPS% * 93), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "z" THEN PUT (dy%, dz%), SPRITES(EPS% * 94), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "K" THEN PUT (dy%, dz%), SPRITES(EPS% * 35), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "D" THEN PUT (dy%, dz%), SPRITES(EPS% * 36), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "k" THEN PUT (dy%, dz%), SPRITES(EPS% * 37), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "d" THEN PUT (dy%, dz%), SPRITES(EPS% * 38), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "R" THEN PUT (dy%, dz%), SPRITES(EPS% * 39), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "r" THEN PUT (dy%, dz%), SPRITES(EPS% * 40), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "F" THEN PUT (dy%, dz%), SPRITES(EPS% * 4), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "f" THEN PUT (dy%, dz%), SPRITES(EPS% * 5), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "Q" THEN PUT (dy%, dz%), SPRITES(EPS% * 6), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "q" THEN PUT (dy%, dz%), SPRITES(EPS% * 7), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "n" THEN PUT (dy%, dz%), SPRITES(EPS% * 32), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "N" THEN PUT (dy%, dz%), SPRITES(EPS% * 33), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "M" THEN PUT (dy%, dz%), SPRITES(EPS% * 34), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "_" THEN PUT (dy%, dz%), SPRITES(EPS% * 67), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "=" THEN PUT (dy%, dz%), SPRITES(EPS% * 68), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "+" THEN PUT (dy%, dz%), SPRITES(EPS% * 69), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "L" THEN PUT (dy%, dz%), SPRITES(EPS% * 91), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "l" THEN PUT (dy%, dz%), SPRITES(EPS% * 92), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "*" THEN PUT (dy%, dz%), SPRITES(EPS% * 97), PSET: GOTO 103
IF MID$(MZ$(PT%(1) - zz%), PT%(2) - yy%, 1) = "#" THEN PUT (dy%, dz%), SPRITES(EPS% * 98), PSET: GOTO 103
103
NEXT zz%
NEXT yy%
PUT (12 * 8 - 8, 12 * 8 - 8), SPRITES(EPS% * LK%), PSET
PUT (25 * 8 - 8, 12 * 8 - 8), SPRITES(EPS% * KL%), PSET
IF a% = 1 THEN a% = 0: RETURN


DO
a$ = INKEY$
GOSUB MAP1
IF bm%(1) = 1 THEN TM% = TM% + 1
IF bm%(2) = 1 THEN MT% = MT% + 1
IF TM% > BSpeed& THEN TM% = 0: GOSUB MOVEBADGUY
IF MT% > BSpeed& THEN MT% = 0: GOSUB MOVEBADGUY1
LOOP UNTIL a$ <> ""
IF LK% = 9 THEN LK% = 1
IF LK% = 8 THEN LK% = 0
IF KL% = 11 THEN KL% = 3
IF KL% = 10 THEN KL% = 2
OP%(1) = PO%(1): OP%(2) = PO%(2)
TP%(1) = PT%(1): TP%(2) = PT%(2)
IF a$ = "D" OR a$ = "d" THEN PO%(2) = PO%(2) + 1: LK% = 1
IF a$ = "A" OR a$ = "a" THEN PO%(2) = PO%(2) - 1: LK% = 0
IF a$ = "S" OR a$ = "s" THEN PO%(1) = PO%(1) + 1
IF a$ = "W" OR a$ = "w" THEN PO%(1) = PO%(1) - 1
IF a$ = "1" OR a$ = "!" THEN GOSUB HIT1
IF a$ = "~" THEN keya1% = 99: keya2% = 99: keya3% = 99: GOSUB LIFE
IF gasa% <> 0 THEN IF a$ = "Q" OR a$ = "q" THEN GOSUB SHOOT
IF a$ = CHR$(0) + "M" THEN PT%(2) = PT%(2) + 1: KL% = 3
IF a$ = CHR$(0) + "K" THEN PT%(2) = PT%(2) - 1: KL% = 2
IF a$ = CHR$(0) + "P" THEN PT%(1) = PT%(1) + 1
IF a$ = CHR$(0) + "H" THEN PT%(1) = PT%(1) - 1
IF a$ = "]" OR a$ = "}" THEN GOSUB HIT2
IF a$ = "}" THEN keyb1% = 99: keyb2% = 99: keyb3% = 99: GOSUB LIFE
IF gasb% <> 0 THEN IF a$ = CHR$(13) THEN GOSUB SHOOT1
IF a$ = CHR$(27) THEN END
JH% = RND * (6)
JU% = RND * (10)
IF JH% > 0 THEN B1%(PT%(1), PT%(2)) = -1
IF JH% > 0 THEN B2%(PO%(1), PO%(2)) = -1
IF JU% = 1 THEN B1%(PO%(1), PO%(2)) = -1: B2%(PT%(1), PT%(2)) = -1
GOTO 100


386
MID$(MZ$(PO%(1)), PO%(2), 1) = " "
GOSUB LIFE
RETURN
486
MID$(MZ$(PT%(1)), PT%(2), 1) = " "
GOSUB LIFE
RETURN

LIFE:
IF EXTRALIFE1% = 1 THEN IF LFA% <= 0 THEN LFA% = 100: EXTRALIFE1% = 0
IF EXTRALIFE2% = 1 THEN IF LFB% <= 0 THEN LFB% = 100: EXTRALIFE2% = 0
COLOR 2
LOCATE 18, 1: PRINT "LIFE "; : COLOR 15: PRINT "       ="; LFA%
COLOR 2
LOCATE 18, 21: PRINT "LIFE "; : COLOR 15: PRINT "       ="; LFB%
COLOR 14
LOCATE 19, 1: PRINT "GOLD KEYS "; : COLOR 15: PRINT "  ="; keya1%
COLOR 14
LOCATE 19, 21: PRINT "GOLD KEYS "; : COLOR 15: PRINT "  ="; keyb1%
COLOR 7
LOCATE 20, 1: PRINT "SILVER KEYS "; : COLOR 15: PRINT "="; keya2%
COLOR 7
LOCATE 20, 21: PRINT "SILVER KEYS "; : COLOR 15: PRINT "="; keyb2%
COLOR 6
LOCATE 21, 1: PRINT "RUSTY KEYS "; : COLOR 15: PRINT " ="; keya3%
COLOR 6
LOCATE 21, 21: PRINT "RUSTY KEYS "; : COLOR 15: PRINT " ="; keyb3%
COLOR 4
LOCATE 22, 1: PRINT "GASOLINE "; : COLOR 15: PRINT "   ="; gasa%
COLOR 4
LOCATE 22, 21: PRINT "GASOLINE "; : COLOR 15: PRINT "   ="; gasb%
COLOR 1
LOCATE 23, 1: PRINT "ENEMY TOAD "; : COLOR 15: PRINT " ="; BGA%
COLOR 1
LOCATE 23, 21: PRINT "ENEMY TOAD "; : COLOR 15: PRINT " ="; BGB%
IF BGB% < 1 AND BGB% > -50 THEN GOTO EXPLOSION3
IF BGA% < 1 AND BGA% > -50 THEN GOTO EXPLOSION4
IF EXTRALIFE1% = 0 THEN IF LFA% <= 0 THEN GOTO EXPLOSION
IF EXTRALIFE2% = 0 THEN IF LFB% <= 0 THEN GOTO EXPLOSION1
RETURN

CHECK:
IF KL% = 3 THEN KL% = 11
IF KL% = 2 THEN KL% = 10
RETURN

CHECK1:
IF LK% = 1 THEN LK% = 9
IF LK% = 0 THEN LK% = 8
RETURN

SHOOT:
IF LK% = 1 THEN GOTO 899
IF LK% = 0 THEN GOTO 908
899
yy% = PO%(1)
zz% = PO%(2) + 1
901                                                                                                                  
IF yy% = PT%(1) AND zz% = PT%(2) THEN IF LK% = 1 THEN IF PO%(1) = PT%(1) THEN IF PT%(2) > PO%(2) THEN LFB% = LFB% - FIRE1%: GOSUB LIFE: GOSUB CHECK: GOTO 900
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF LK% = 1 THEN IF PO%(1) = BD%(3) THEN IF PO%(2) < BD%(4) THEN BGA% = BGA% - FIRE1%: GOTO 900
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF LK% = 0 THEN IF PO%(1) = BD%(3) THEN IF PO%(2) > BD%(4) THEN BGA% = BGA% - FIRE1%: GOTO 900
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF LK% = 1 THEN IF PO%(1) = BD%(1) THEN IF PO%(2) < BD%(2) THEN BGB% = BGB% - FIRE1%: GOTO 900
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF LK% = 0 THEN IF PO%(1) = BD%(1) THEN IF PO%(2) > BD%(2) THEN BGB% = BGB% - FIRE1%: GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 900
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 900
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 900
IF SUPERFLAME1% = 0 THEN MID$(MZ$(yy%), zz%, 1) = "F"
IF SUPERFLAME1% = 1 THEN MID$(MZ$(yy%), zz%, 1) = "Q": EXTRAFLAME1% = EXTRAFLAME1% - 1
zz% = zz% + 1
gasa% = gasa% - 1
IF gasa% = 0 THEN GOTO 900
GOTO 901
900
a% = 1
GOSUB 100
FOR Delay& = 1 TO Speed&: NEXT Delay&
GOSUB LIFE
yy% = PO%(1)
zz% = PO%(2) + 1
910
IF SUPERFLAME1% = 0 THEN IF MID$(MZ$(yy%), zz%, 1) = "F" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF SUPERFLAME1% = 1 THEN IF MID$(MZ$(yy%), zz%, 1) = "Q" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 909
zz% = zz% + 1
GOTO 910
909
IF EXTRAFLAME1% <= 0 THEN SUPERFLAME1% = 0: FIRE1% = 5
RETURN

908
yy% = PO%(1)
zz% = PO%(2) - 1
902                                                                                                                                                                                                                                                                                                                            
IF yy% = PT%(1) AND zz% = PT%(2) THEN IF LK% = 0 THEN IF PO%(1) = PT%(1) THEN IF PT%(2) < PO%(2) THEN LFB% = LFB% - FIRE1%: GOSUB LIFE: GOSUB CHECK: GOTO 903
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF LK% = 1 THEN IF PO%(1) = BD%(3) THEN IF PO%(2) < BD%(4) THEN BGA% = BGA% - FIRE1%: GOTO 903
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF LK% = 0 THEN IF PO%(1) = BD%(3) THEN IF PO%(2) > BD%(4) THEN BGA% = BGA% - FIRE1%: GOTO 903
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF LK% = 1 THEN IF PO%(1) = BD%(1) THEN IF PO%(2) < BD%(2) THEN BGB% = BGB% - FIRE1%: GOTO 903
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF LK% = 0 THEN IF PO%(1) = BD%(1) THEN IF PO%(2) > BD%(2) THEN BGB% = BGB% - FIRE1%: GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 903
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 903
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 903
IF SUPERFLAME1% = 0 THEN MID$(MZ$(yy%), zz%, 1) = "f"
IF SUPERFLAME1% = 1 THEN MID$(MZ$(yy%), zz%, 1) = "q": EXTRAFLAME1% = EXTRAFLAME1% - 1
zz% = zz% - 1
gasa% = gasa% - 1
IF gasa% = 0 THEN GOTO 903
GOTO 902
903
a% = 1
GOSUB 100
FOR Delay& = 1 TO Speed&: NEXT Delay&
GOSUB LIFE
yy% = PO%(1)
zz% = PO%(2) - 1
810
IF SUPERFLAME1% = 0 THEN IF MID$(MZ$(yy%), zz%, 1) = "f" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF SUPERFLAME1% = 1 THEN IF MID$(MZ$(yy%), zz%, 1) = "q" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 809
zz% = zz% - 1
GOTO 810
809
IF EXTRAFLAME1% <= 0 THEN SUPERFLAME1% = 0: FIRE1% = 5
RETURN

SHOOT1:
IF KL% = 3 THEN GOTO 699
IF KL% = 2 THEN GOTO 708
699
yy% = PT%(1)
zz% = PT%(2) + 1
701                                                                                                                    
IF yy% = PO%(1) AND zz% = PO%(2) THEN IF KL% = 3 THEN IF PT%(1) = PO%(1) THEN IF PO%(2) > PT%(2) THEN LFA% = LFA% - FIRE2%: GOSUB LIFE: GOSUB CHECK1: GOTO 700
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF KL% = 3 THEN IF PT%(1) = BD%(3) THEN IF PT%(2) < BD%(4) THEN BGA% = BGA% - FIRE2%: GOTO 700
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF KL% = 2 THEN IF PT%(1) = BD%(3) THEN IF PT%(2) > BD%(4) THEN BGA% = BGA% - FIRE2%: GOTO 700
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF KL% = 3 THEN IF PT%(1) = BD%(1) THEN IF PT%(2) < BD%(2) THEN BGB% = BGB% - FIRE2%: GOTO 700
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF KL% = 2 THEN IF PT%(1) = BD%(1) THEN IF PT%(2) > BD%(2) THEN BGB% = BGB% - FIRE2%: GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 700
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 700
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 700
IF SUPERFLAME2% = 0 THEN MID$(MZ$(yy%), zz%, 1) = "F"
IF SUPERFLAME2% = 1 THEN MID$(MZ$(yy%), zz%, 1) = "Q": EXTRAFLAME2% = EXTRAFLAME2% - 1
zz% = zz% + 1
gasb% = gasb% - 1
IF gasb% = 0 THEN GOTO 700
GOTO 701
700
a% = 1
GOSUB 100
FOR Delay& = 1 TO Speed&: NEXT Delay&
GOSUB LIFE
yy% = PT%(1)
zz% = PT%(2) + 1
710
IF SUPERFLAME2% = 0 THEN IF MID$(MZ$(yy%), zz%, 1) = "F" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF SUPERFLAME2% = 1 THEN IF MID$(MZ$(yy%), zz%, 1) = "Q" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 709
zz% = zz% + 1
GOTO 710
709
IF EXTRAFLAME2% <= 0 THEN SUPERFLAME2% = 0: FIRE2% = 5
RETURN

708
yy% = PT%(1)
zz% = PT%(2) - 1
702                                                      
IF yy% = PO%(1) AND zz% = PO%(2) THEN IF KL% = 2 THEN IF PT%(1) = PO%(1) THEN IF PO%(2) < PT%(2) THEN LFA% = LFA% - FIRE2%: GOSUB LIFE: GOSUB CHECK1: GOTO 703
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF KL% = 3 THEN IF PT%(1) = BD%(3) THEN IF PT%(2) < BD%(4) THEN BGA% = BGA% - FIRE2%: GOTO 703
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN IF KL% = 2 THEN IF PT%(1) = BD%(3) THEN IF PT%(2) > BD%(4) THEN BGA% = BGA% - FIRE2%: GOTO 703
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF KL% = 3 THEN IF PT%(1) = BD%(1) THEN IF PT%(2) < BD%(2) THEN BGB% = BGB% - FIRE2%: GOTO 703
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN IF KL% = 2 THEN IF PT%(1) = BD%(1) THEN IF PT%(2) > BD%(2) THEN BGB% = BGB% - FIRE2%: GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 703
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 703
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 703
IF SUPERFLAME2% = 0 THEN MID$(MZ$(yy%), zz%, 1) = "f"
IF SUPERFLAME2% = 1 THEN MID$(MZ$(yy%), zz%, 1) = "q": EXTRAFLAME2% = EXTRAFLAME2% - 1
zz% = zz% - 1
gasb% = gasb% - 1
IF gasb% = 0 THEN GOTO 703
GOTO 702
703
a% = 1
GOSUB 100
FOR Delay& = 1 TO Speed&: NEXT Delay&
GOSUB LIFE
yy% = PT%(1)
zz% = PT%(2) - 1
610
IF SUPERFLAME2% = 0 THEN IF MID$(MZ$(yy%), zz%, 1) = "f" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF SUPERFLAME2% = 1 THEN IF MID$(MZ$(yy%), zz%, 1) = "q" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 609
zz% = zz% - 1
GOTO 610
609
IF EXTRAFLAME2% <= 0 THEN SUPERFLAME2% = 0: FIRE2% = 5
RETURN

EXPLOSION:
v% = 210
803
PUT (12 * 8 - 8, 12 * 8 - 8), SPRITES(EPS% * v%), PSET
v% = v% + 1
FOR Delay& = 1 TO ESpeed&: NEXT Delay&
IF v% > 224 THEN v% = 223: a% = a% + 1
IF a% > 10 THEN CLS : SLEEP (1): GOTO 10
GOTO 803
EXPLOSION1:
v% = 280
403
PUT (25 * 8 - 8, 12 * 8 - 8), SPRITES(EPS% * v%), PSET
v% = v% + 1
FOR Delay& = 1 TO ESpeed&: NEXT Delay&
IF v% > 294 THEN v% = 293: a% = a% + 1
IF a% > 10 THEN CLS : SLEEP (1): GOTO 10
GOTO 403

EXPLOSION3:
a% = 1
H% = 1: I% = 1
J% = 1: K% = 1
GOSUB 100
v% = 245
8031
IF B% = 1 THEN PUT (dp%(1), dp%(2)), SPRITES(EPS% * v%), PSET
IF C% = 1 THEN PUT (dp%(3), dp%(4)), SPRITES(EPS% * v%), PSET
v% = v% + 1
FOR Delay& = 1 TO ESpeed&: NEXT Delay&
IF v% > 269 THEN TM% = 0: bm%(1) = 0: BGB% = -100: MID$(MZ$(BD%(1)), BD%(2)) = " ": BD%(1) = 0: BD%(2) = 0: RETURN
GOTO 8031

EXPLOSION4:
a% = 1
H% = 1: I% = 1
J% = 1: K% = 1
GOSUB 100
v% = 315
8032
IF y% = 1 THEN PUT (dp%(1), dp%(2)), SPRITES(EPS% * v%), PSET
IF z% = 1 THEN PUT (dp%(3), dp%(4)), SPRITES(EPS% * v%), PSET
v% = v% + 1
FOR Delay& = 1 TO ESpeed&: NEXT Delay&
IF v% > 339 THEN MT% = 0: bm%(2) = 0: BGA% = -100: MID$(MZ$(BD%(3)), BD%(4)) = " ": TM% = 0: BD%(3) = 0: BD%(4) = 0: RETURN
GOTO 8032

ALIVE:
bm%(1) = 1
BD%(1) = yy%: BD%(2) = zz%
DB%(1) = yy%: DB%(2) = zz%
BK% = 176
RETURN

ALIVE1:
bm%(2) = 1
BD%(3) = yy%: BD%(4) = zz%
DB%(3) = yy%: DB%(4) = zz%
KB% = 177
RETURN

MOVEBADGUY:
WW% = 0
FOR yy% = -1 TO 1
FOR zz% = -1 TO 1
IF zz% <> 0 AND yy% <> 0 THEN GOTO 38
IF WW% = 0 AND MID$(MZ$(BD%(1) + zz%), BD%(2) + yy%, 1) = " " THEN MN% = B1%(BD%(1) + zz%, BD%(2) + yy%): WW% = 1
IF MID$(MZ$(BD%(1) + zz%), BD%(2) + yy%, 1) = " " AND B1%(BD%(1) + zz%, BD%(2) + yy%) < MN% THEN MN% = B1%(BD%(1) + zz%, BD%(2) + yy%)
38
NEXT zz%
NEXT yy%

BV% = 0
IF B1%(BD%(1) + 1, BD%(2)) = MN% AND MID$(MZ$(BD%(1) + 1), BD%(2), 1) = " " AND BD%(1) < PT%(1) THEN BD%(1) = BD%(1) + 1: BV% = 1: GOTO 36
IF B1%(BD%(1) - 1, BD%(2)) = MN% AND MID$(MZ$(BD%(1) - 1), BD%(2), 1) = " " AND BD%(1) > PT%(1) THEN BD%(1) = BD%(1) - 1: BV% = 1: GOTO 36
IF B1%(BD%(1), BD%(2) + 1) = MN% AND MID$(MZ$(BD%(1)), BD%(2) + 1, 1) = " " AND BD%(2) < PT%(2) THEN BD%(2) = BD%(2) + 1: BV% = 1: BK% = 176: GOTO 36
IF B1%(BD%(1), BD%(2) - 1) = MN% AND MID$(MZ$(BD%(1)), BD%(2) - 1, 1) = " " AND BD%(2) > PT%(2) THEN BD%(2) = BD%(2) - 1: BV% = 1: BK% = 175
36

IF BV% = 0 THEN
IF B1%(BD%(1) + 1, BD%(2)) = MN% AND MID$(MZ$(BD%(1) + 1), BD%(2), 1) = " " THEN BD%(1) = BD%(1) + 1: GOTO 37
IF B1%(BD%(1) - 1, BD%(2)) = MN% AND MID$(MZ$(BD%(1) - 1), BD%(2), 1) = " " THEN BD%(1) = BD%(1) - 1: GOTO 37
IF B1%(BD%(1), BD%(2) + 1) = MN% AND MID$(MZ$(BD%(1)), BD%(2) + 1, 1) = " " THEN BD%(2) = BD%(2) + 1: BK% = 176: GOTO 37
IF B1%(BD%(1), BD%(2) - 1) = MN% AND MID$(MZ$(BD%(1)), BD%(2) - 1, 1) = " " THEN BD%(2) = BD%(2) - 1: BK% = 175
37
END IF

IF BD%(2) = PT%(2) AND BD%(1) = PT%(1) THEN BD%(1) = DB%(1): BD%(2) = DB%(2)
IF BD%(2) = PO%(2) AND BD%(1) = PO%(1) THEN BD%(1) = DB%(1): BD%(2) = DB%(2)

B1%(BD%(1), BD%(2)) = B1%(BD%(1), BD%(2)) + 1

IF BD%(1) = PT%(1) AND BD%(2) < PT%(2) AND BK% = 176 THEN GOSUB BADSHOOT3
IF BD%(1) = PT%(1) AND BD%(2) > PT%(2) AND BK% = 175 THEN GOSUB BADSHOOT4

FOR yy% = -1 TO 1
FOR zz% = -1 TO 1
IF BD%(1) + zz% = PT%(1) AND BD%(2) + yy% = PT%(2) THEN LFB% = LFB% - 1: GOSUB LIFE
IF zz% = 0 OR yy% = 0 THEN
IF BGB% < 150 AND MID$(MZ$(BD%(1) + zz%), BD%(2) + yy%, 1) = "n" THEN BD%(1) = BD%(1) + zz%: BD%(2) = BD%(2) + yy%: BGB% = BGB% + 5: MID$(MZ$(BD%(1)), BD%(2), 1) = " ": GOSUB LIFE
IF BGB% < 150 AND MID$(MZ$(BD%(1) + zz%), BD%(2) + yy%, 1) = "N" THEN BD%(1) = BD%(1) + zz%: BD%(2) = BD%(2) + yy%: BGB% = BGB% + 10: MID$(MZ$(BD%(1)), BD%(2), 1) = " ": GOSUB LIFE
IF BGB% < 150 AND MID$(MZ$(BD%(1) + zz%), BD%(2) + yy%, 1) = "M" THEN BD%(1) = BD%(1) + zz%: BD%(2) = BD%(2) + yy%: BGB% = BGB% + 50: MID$(MZ$(BD%(1)), BD%(2), 1) = " ": GOSUB LIFE
END IF
NEXT zz%
NEXT yy%

GOSUB MAP1
DB%(1) = BD%(1)
DB%(2) = BD%(2)
a% = 1
GOSUB 100
RETURN

MOVEBADGUY1:
WW% = 0
FOR yy% = -1 TO 1
FOR zz% = -1 TO 1
IF zz% <> 0 AND yy% <> 0 THEN GOTO 39
IF WW% = 0 AND MID$(MZ$(BD%(3) + zz%), BD%(4) + yy%, 1) = " " THEN MN% = B2%(BD%(3) + zz%, BD%(4) + yy%): WW% = 1
IF MID$(MZ$(BD%(3) + zz%), BD%(4) + yy%, 1) = " " AND B2%(BD%(3) + zz%, BD%(4) + yy%) < MN% THEN MN% = B2%(BD%(3) + zz%, BD%(4) + yy%)
39
NEXT zz%
NEXT yy%

BV% = 0
IF B2%(BD%(3) + 1, BD%(4)) = MN% AND MID$(MZ$(BD%(3) + 1), BD%(4), 1) = " " AND BD%(3) < PO%(1) THEN BD%(3) = BD%(3) + 1: BV% = 1: GOTO 59
IF B2%(BD%(3) - 1, BD%(4)) = MN% AND MID$(MZ$(BD%(3) - 1), BD%(4), 1) = " " AND BD%(3) > PO%(1) THEN BD%(3) = BD%(3) - 1: BV% = 1: GOTO 59
IF B2%(BD%(3), BD%(4) + 1) = MN% AND MID$(MZ$(BD%(3)), BD%(4) + 1, 1) = " " AND BD%(4) < PO%(2) THEN BD%(4) = BD%(4) + 1: BV% = 1: KB% = 178: GOTO 59
IF B2%(BD%(3), BD%(4) - 1) = MN% AND MID$(MZ$(BD%(3)), BD%(4) - 1, 1) = " " AND BD%(4) > PO%(2) THEN BD%(4) = BD%(4) - 1: BV% = 1: KB% = 177
59

IF BV% = 0 THEN
IF B2%(BD%(3) + 1, BD%(4)) = MN% AND MID$(MZ$(BD%(3) + 1), BD%(4), 1) = " " THEN BD%(3) = BD%(3) + 1: GOTO 49
IF B2%(BD%(3) - 1, BD%(4)) = MN% AND MID$(MZ$(BD%(3) - 1), BD%(4), 1) = " " THEN BD%(3) = BD%(3) - 1: GOTO 49
IF B2%(BD%(3), BD%(4) + 1) = MN% AND MID$(MZ$(BD%(3)), BD%(4) + 1, 1) = " " THEN BD%(4) = BD%(4) + 1: KB% = 178: GOTO 49
IF B2%(BD%(3), BD%(4) - 1) = MN% AND MID$(MZ$(BD%(3)), BD%(4) - 1, 1) = " " THEN BD%(4) = BD%(4) - 1: KB% = 177
49
END IF

IF BD%(4) = PT%(2) AND BD%(3) = PT%(1) THEN BD%(3) = DB%(3): BD%(4) = DB%(4)
IF BD%(4) = PO%(2) AND BD%(3) = PO%(1) THEN BD%(3) = DB%(3): BD%(4) = DB%(4)

B2%(BD%(3), BD%(4)) = B2%(BD%(3), BD%(4)) + 1
IF BD%(3) = PO%(1) AND BD%(4) < PO%(2) AND KB% = 178 THEN GOSUB BADSHOOT1
IF BD%(3) = PO%(1) AND BD%(4) > PO%(2) AND KB% = 177 THEN GOSUB BADSHOOT2

FOR yy% = -1 TO 1
FOR zz% = -1 TO 1
IF BD%(3) + zz% = PO%(1) AND BD%(4) + yy% = PO%(2) THEN LFA% = LFA% - 1: GOSUB LIFE
IF zz% = 0 OR yy% = 0 THEN
IF BGA% < 150 AND MID$(MZ$(BD%(3) + zz%), BD%(4) + yy%, 1) = "n" THEN BD%(3) = BD%(3) + zz%: BD%(4) = BD%(4) + yy%: BGA% = BGA% + 5: MID$(MZ$(BD%(3)), BD%(4), 1) = " ": GOSUB LIFE
IF BGA% < 150 AND MID$(MZ$(BD%(3) + zz%), BD%(4) + yy%, 1) = "N" THEN BD%(3) = BD%(3) + zz%: BD%(4) = BD%(4) + yy%: BGA% = BGA% + 10: MID$(MZ$(BD%(3)), BD%(4), 1) = " ": GOSUB LIFE
IF BGA% < 150 AND MID$(MZ$(BD%(3) + zz%), BD%(4) + yy%, 1) = "M" THEN BD%(3) = BD%(3) + zz%: BD%(4) = BD%(4) + yy%: BGA% = BGA% + 50: MID$(MZ$(BD%(3)), BD%(4), 1) = " ": GOSUB LIFE
END IF
NEXT zz%
NEXT yy%

GOSUB MAP1
DB%(3) = BD%(3)
DB%(4) = BD%(4)
a% = 1
GOSUB 100
RETURN

BADSHOOT3:
yy% = BD%(1)
zz% = BD%(2) + 1
199                                                                                                                  
IF yy% = PT%(1) AND zz% = PT%(2) THEN LFB% = LFB% - 5: GOSUB LIFE: GOSUB CHECK: GOTO 200
IF yy% = PO%(1) AND zz% = PO%(2) THEN LFA% = LFA% - 5: GOSUB LIFE: GOSUB CHECK1: GOTO 200
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN BGA% = BGA% - 5: GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 200
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 200
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 200
MID$(MZ$(yy%), zz%, 1) = "F"
zz% = zz% + 1
GOTO 199
200
a% = 1
GOSUB 100
GOSUB LIFE
yy% = BD%(1)
zz% = BD%(2) + 1
210
IF MID$(MZ$(yy%), zz%, 1) = "F" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 209
zz% = zz% + 1
GOTO 210
209
RETURN

BADSHOOT4:
yy% = BD%(1)
zz% = BD%(2) - 1
299
IF yy% = PT%(1) AND zz% = PT%(2) THEN LFB% = LFB% - 5: GOSUB LIFE: GOSUB CHECK: GOTO 300
IF yy% = PO%(1) AND zz% = PO%(2) THEN LFA% = LFA% - 5: GOSUB LIFE: GOSUB CHECK1: GOTO 300
IF BGA% > 0 THEN IF yy% = BD%(3) AND zz% = BD%(4) THEN BGA% = BGA% - 5: GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 300
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 300
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 300
MID$(MZ$(yy%), zz%, 1) = "f"
zz% = zz% - 1
GOTO 299
300
a% = 1
GOSUB 100
GOSUB LIFE
yy% = BD%(1)
zz% = BD%(2) - 1
310
IF MID$(MZ$(yy%), zz%, 1) = "f" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 309
zz% = zz% - 1
GOTO 310
309
RETURN

BADSHOOT1:
yy% = BD%(3)
zz% = BD%(4) + 1
1099                                                                                                                
IF yy% = PT%(1) AND zz% = PT%(2) THEN LFB% = LFB% - 5: GOSUB LIFE: GOSUB CHECK: GOTO 2000
IF yy% = PO%(1) AND zz% = PO%(2) THEN LFA% = LFA% - 5: GOSUB LIFE: GOSUB CHECK1: GOTO 2000
IF BGB% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN BGA% = BGA% - 5: GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 2000
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 2000
MID$(MZ$(yy%), zz%, 1) = "F"
zz% = zz% + 1
GOTO 1099
2000
a% = 1
GOSUB 100
GOSUB LIFE
yy% = BD%(3)
zz% = BD%(4) + 1
2100
IF MID$(MZ$(yy%), zz%, 1) = "F" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 2090
zz% = zz% + 1
GOTO 2100
2090
RETURN

BADSHOOT2:
yy% = BD%(3)
zz% = BD%(4) - 1
2990
IF yy% = PT%(1) AND zz% = PT%(2) THEN LFB% = LFB% - 5: GOSUB LIFE: GOSUB CHECK: GOTO 3000
IF yy% = PO%(1) AND zz% = PO%(2) THEN LFA% = LFA% - 5: GOSUB LIFE: GOSUB CHECK1: GOTO 3000
IF BGA% > 0 THEN IF yy% = BD%(1) AND zz% = BD%(2) THEN BGA% = BGA% - 5: GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN MID$(MZ$(yy%), zz%, 1) = "Z": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN MID$(MZ$(yy%), zz%, 1) = "z": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN MID$(MZ$(yy%), zz%, 1) = "Y": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN MID$(MZ$(yy%), zz%, 1) = "y": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN MID$(MZ$(yy%), zz%, 1) = "T": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN MID$(MZ$(yy%), zz%, 1) = "t": GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE: GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN MID$(MZ$(yy%), zz%, 1) = " ": GOSUB ALIVE1: GOTO 3000
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 3000
MID$(MZ$(yy%), zz%, 1) = "f"
zz% = zz% - 1
GOTO 2990
3000
a% = 1
GOSUB 100
GOSUB LIFE
yy% = BD%(3)
zz% = BD%(4) - 1
3100
IF MID$(MZ$(yy%), zz%, 1) = "f" THEN MID$(MZ$(yy%), zz%, 1) = " "
IF MID$(MZ$(yy%), zz%, 1) <> " " THEN GOTO 3090
zz% = zz% - 1
GOTO 3100
3090
RETURN

MAP:
CLS
FOR yy% = 1 TO 40
FOR zz% = 1 TO 40
IF MID$(MZ$(zz%), yy%, 1) <> " " THEN PSET (yy%, zz%), 15
IF MID$(MZ$(zz%), yy%, 1) = "_" THEN PSET (yy%, zz%), 116
IF MID$(MZ$(zz%), yy%, 1) = "=" THEN PSET (yy%, zz%), 118
IF MID$(MZ$(zz%), yy%, 1) = "+" THEN PSET (yy%, zz%), 120
IF MID$(MZ$(zz%), yy%, 1) = "n" THEN PSET (yy%, zz%), 68
IF MID$(MZ$(zz%), yy%, 1) = "N" THEN PSET (yy%, zz%), 70
IF MID$(MZ$(zz%), yy%, 1) = "M" THEN PSET (yy%, zz%), 72
IF MID$(MZ$(zz%), yy%, 1) = "k" THEN PSET (yy%, zz%), 7
IF MID$(MZ$(zz%), yy%, 1) = "K" THEN PSET (yy%, zz%), 14
IF MID$(MZ$(zz%), yy%, 1) = "R" THEN PSET (yy%, zz%), 6
IF MID$(MZ$(zz%), yy%, 1) = "d" THEN PSET (yy%, zz%), 7
IF MID$(MZ$(zz%), yy%, 1) = "D" THEN PSET (yy%, zz%), 14
IF MID$(MZ$(zz%), yy%, 1) = "r" THEN PSET (yy%, zz%), 6
IF MID$(MZ$(zz%), yy%, 1) = "l" THEN PSET (yy%, zz%), 94
IF MID$(MZ$(zz%), yy%, 1) = "L" THEN PSET (yy%, zz%), 94
IF MID$(MZ$(zz%), yy%, 1) = "*" THEN PSET (yy%, zz%), 12
IF MID$(MZ$(zz%), yy%, 1) = "#" THEN PSET (yy%, zz%), 9
NEXT zz%
NEXT yy%
RETURN

MAP1:
PSET (OP%(2), OP%(1)), 0
PSET (PO%(2), PO%(1)), 4
PSET (TP%(2), TP%(1)), 0
PSET (PT%(2), PT%(1)), 9
PSET (DB%(2), DB%(1)), 0
PSET (BD%(2), BD%(1)), 2
PSET (DB%(4), DB%(3)), 0
PSET (BD%(4), BD%(3)), 14
PSET (0, 0), 0
RETURN

HIT1:
FOR yy% = -1 TO 1
FOR zz% = -1 TO 1
IF PO%(1) + zz% = PT%(1) AND PO%(2) + yy% = PT%(2) THEN LFB% = LFB% - 1: GOSUB LIFE
IF PO%(1) + zz% = BD%(3) AND PO%(2) + yy% = BD%(4) THEN BGA% = BGA% - 1: GOSUB LIFE
IF PO%(1) + zz% = BD%(1) AND PO%(2) + yy% = BD%(2) THEN BGB% = BGB% - 1: GOSUB LIFE
NEXT zz%
NEXT yy%
RETURN

HIT2:
FOR yy% = -1 TO 1
FOR zz% = -1 TO 1
IF PT%(1) + zz% = PO%(1) AND PT%(2) + yy% = PO%(2) THEN LFA% = LFA% - 1: GOSUB LIFE
IF PT%(1) + zz% = BD%(3) AND PT%(2) + yy% = BD%(4) THEN BGA% = BGA% - 1: GOSUB LIFE
IF PT%(1) + zz% = BD%(1) AND PT%(2) + yy% = BD%(2) THEN BGB% = BGB% - 1: GOSUB LIFE
NEXT zz%
NEXT yy%
RETURN


DATA 16,1,3,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 67,68,69,32,33,34,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 35,37,39,98,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 36,38,40,97,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
DATA 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16

DEFSNG A-Z
SUB ABOUT
'TOADMAN v1.6
'============
'2000 DELTA CODE
'CREATED BY JOE KING

'WELCOME TO TOADMAN VERSION 1.6
'A TWO PLAYER GAME
'TWO TOADS OUT TO DESTROY EACH OTHER
'KEYS
'PLAYER 1
'========
'W = UP            = UP
'S = DOWN          = DOWN
'A = LEFT          = LEFT
'D = RIGHT         = RIGHT
'Q = SHOOT    ENTER = SHOOT
'1 = HIT          ] = HIT

'SPEED
'======
'I decided to leave this in here incase for some reason, the speed constants
'are goofed up
'THIS PROGRAM WAS MADE TO RUN A ON 486/66MHz COMPUTER
'YOU CAN ADJUST THE SPEED FOR A FASTER COMPUTER TOO
'JUST GO THROUGH THE FOR NEXT LOOPS AND CHANGE THE NUMBERS TO SLOW IT DOWN
'IF YOU CAN'T SEE THE FLAME WHEN YOU SHOOT GO DOWN TO THE SHOOTING SECTION TO
'SEE HOW TO SLOW IT DOWN SO YOU CAN SEE IT
'ALSO LOOK THROUGH THE CODE UNTIL YOU FIND THIS
'DO
'A$ = INKEY$
'GOSUB MAP1
'IF bm%(1) = 1 THEN tm% = tm% + 1
'IF bm%(2) = 1 THEN MT% = MT% + 1
'IF tm% > 1000 THEN tm% = 0: GOSUB MOVEBADGUY
'IF MT% > 1000 THEN MT% = 0: GOSUB MOVEBADGUY1
'LOOP UNTIL A$ <> ""
'TO SLOW SOME STUFF DOWN CHANGE IT TO
'DO
'A$ = INKEY$
'GOSUB MAP1
'IF bm%(1) = 1 THEN tm% = tm% + 1
'IF bm%(2) = 1 THEN MT% = MT% + 1
'IF tm% > (BIG NUMBER) THEN tm% = 0: GOSUB MOVEBADGUY
'IF MT% > (BIG NUMBER) THEN MT% = 0: GOSUB MOVEBADGUY1
'LOOP UNTIL A$ <> ""
'WHERE (BIG NUMBER) IS ABOVE 1000 FOR COMPUTERS FASTER THEN A 486/66MHz COMPUTER
'THIS STUFF SHOULD SLOW DOWN THE PROGRAM SO IT WILL BE FUN TO PLAY
'THIS WILL SLOW DOWN THE MOVEMENT OF THE ENEMY TOADS

'SHOOTING
'==========
'WHEN YOU SHOOT, YOU WILL LOSE AMMO
'THE FARTHER THE FLAME GOES, THE MORE AMMO YOU LOSE
'IF YOUR COMPUTER IS REALLY FAST, AND YOU CAN'T SEE THE FLAME THEN
'LOOK THROUGH THE CODE UNTIL YOU FIND THIS
'900
'A% = 1
'GOSUB 100
'GOSUB LIFE
'YY% = PO%(1)
'ZZ% = PO%(2) + 1
'CHANGE IT TO
'900
'A% = 1
'GOSUB 100
'(MAKE A FOR NEXT LOOP TO SLOW IT DOWN)
'GOSUB LIFE
'YY% = PO%(1)
'ZZ% = PO%(2) + 1
'AND ALSO FIND
'903
'A% = 1
'GOSUB 100
'GOSUB LIFE
'YY% = PO%(1)
'ZZ% = PO%(2) - 1
'CHANGE IT TO
'903
'A% = 1
'GOSUB 100
'(MAKE A FOR NEXT LOOP TO SLOW IT DOWN)
'GOSUB LIFE
'YY% = PO%(1)
'ZZ% = PO%(2) - 1

'HIT
'=====
'THE HIT KEY IN THIS PROGRAM WILL SCAN AROUND YOU ONE AWAY FROM YOU
'SO ANYTHING WITHIN 1 SPACE FROM YOU WILL GET HURT
'THE ONLY THING THAT CAN GET HURT IS THE OTHER PLAYER

'FROZEN TOADS
'============
'THERE ARE FROZEN TOADS IN THIS GAME
'IF YOU SHOOT AT THE THEY WILL UNFREEZE AND TRY TO DESTROY YOU
'THEY HAVE FLAMETHROWERS WITH UNLIMITED AMMO
'AND THEY WILL ALSO HIT YOU IF YOUR CLOSE BY
'THERE ARE TWO FROZEN TOADS IN THE GAME
'YOU CAN DESTROY THEM WITH YOU FLAMETHROWERS
'AND ALSO THE HIT KEY
'ONE GOES AFTER PLAYER 1 AND THE OTHER GOES AFTER PLAYER 2
'BUT BE CAREFUL
'IF ONE IS NEXT TO YOU THATS THE SAME ROW THAT YOU ARE ON, AND IT IS NOT
'AFTER YOU, BE CAREFUL
'IF THE ONE IT'S AFTER IS ON THE SAME ROW TO, THW UNFROZEN TOAD WILL SHOOT AT
'HIM, SO IF YOUR IN HIS WAY, HE WILL SHOOT AT YOU
'ALSO, THIS IS VERSION 1.6, THE TOADS WILL FIND YOU WERE EVER YOU GO

'LEVEL BUILDER
'=============
'I MADE THE LEVEL BUILDER SO IT WOULD BE EASY TO MAKE LEVELS
'INSTEAD OF TYPING IN NUMBERS AND LETTERS FOR THE LEVELS
'THERE IS AN EXAMPLE LEVEL I MADE, YOU CAN LOAD IT IN AND PLAY IT
'DON'T PUT TWO OF THE SAME FROZEN TOADS IN A LEVEL
'DON'T PUT MORE THAN ONE OF THE BONUS ITEMS IN A LEVEL
'IF YOUR GOING TO PLAY IT, MAKE SURE THAT YOU SAVE IT FIRST
'MAKE SURE YOU PUT STARTING SPOTS FOR BOTH PLAYER 1 AND PLAYER 2
'==========================
'KEYS FOR THE LEVEL BUILDER
'==========================
' = UP
' = DOWN
' = LEFT
' = RIGHT
'ENTER = GO TO OBJECT PAGE/SELECT OBJECT
'SPACE = PLACE AN OBJECT
'DELETE = DELETE AN OBJECT
'B = CHOOSE BOARDER
'P = SWITCH FROM TOP PAGE TO LOW PAGE/SWITCH FROM LOW PAGE TO TOP PAGE
'T = TURN ON/OFF TRACE MODE
'F = TURN ON/OFF FILL MODE
'S = SAVE LEVEL
'L = LOAD LEVEL
'ESCAPE = PLAY LEVEL

'KEYS
'============
'ENTER = GO TO OBJECT SCREEN
'SPACE = PUT OBJECT
'F = TURN ON/OFF BOX MODE
'P = SWICH FROM TOP PAGE TO LOW PAGE OR LOW PAGE TO TOP PAGE
'T = TURN ON/OFF TRACE MODE
'B = MAKE BOARDER
'S = SAVE
'L = LOAD
'============
'IF YOU ARE MISSING THEN 'TOADSAVE.DAT' FILE OR IT IS MESSED UP IN SOME WAY
'COPY THIS
'"EMPTY","EMPTY","EMPTY","EMPTY","EMPTY","EMPTY","EMPTY","EMPTY","EMPTY","EMPTY"
'WHERE "EMPTY" IS THE NAME OF A LEVEL FILE
'GO TO A NEW SCREEN
'PASTE IT
'AND SAVE IT AS 'TOADSAVE.DAT'
'============
'PROBLEMS
'========
'I HAVN'T FULLY TESTED THE LEVEL BUILDER
'SO DON'T BE SURPRISED IF THERE IS ANY PROBLEMS
'YOU ARE GOING TO HAVE TO FIX THEM YOURSELF

'DIFFERENCES FROM VERSIONS
'APPROXIMATIONS
'=========================
'VERSION 1.0
'4 LEVELS, NO LEVEL BUILDER, LOTS OF BUGS
'VERSION 1.1
'SAME AS 1.0 ACCEPT LOTS OF THE BUGS ARE GONE
'VERSION 1.2
'4 LEVELS, LEVEL BUILDER, MOST OF BUGS ARE FIXED
'VERSION 1.3
'6 LEVELS, LEVEL BUILDER
'VERSION 1.4 PLATINUM
'8 LEVELS, LEVEL BUILDER, SUPER SMART FROZEN TOADS, EVEN MORE BUGS FIXED
'PLUS BONUS ITEMS
'VERSION 1.5
'New speed constant, some additions from Steven Degutis
'VERSION 1.6
'Touched up from version 1.4 with three speed constants to get you the
'speed you want easily, and an easier to choose level arrow
'=======================================================================

'BONUS ITEMS
'===========
'THERE ARE BONUS ITEMS IN SOME LEVELS
'IF YOU GET THEM, AND YOU DON'T KNOW WHAT THEY DO, HERE'S AN EXPLAINATION
'OF WHAT THEY DO
'===============
'THE SUPERFLAME
'==============
'THE SUPERFLAME IS SOME RED AND YELLOW COLORS INSIDE A SILVER BOX
'WHEN YOU GET IT, THE POWER OF YOUR FLAME IS DOUBLED
'IT ONLY LAST FOR A CERTAIN AMOUNT OF SHOTS
'==========================================
'THE LIFE REVIVER
'================
'THE LIFE REVIVER IS A MEDIKIT THAT IS BLUE WITH A WHITE CROSS
'WHEN YOU GET IT, IT WILL RECHARGE YOUR LIFE BACK UP TO 100 WHEN IT REACHES 0

'ADVERTISEMENTS
'==============
'LOOK FOR MORE GAMES COMING SOON FROM DELTA CODE
'IF THEY EVER GET ON THE INTERNET
'============
'BUNNY COMMANDOS
'Created by Joe King
'Animation, 100*100 MAP GRID
'Four guns, eight handweapons
'Go scuba diving in the water
'Beats Toadman 10 TO 1
'============
'Larry The Dinosaur
'Why aren't there ant aliens
'Dinosaurs destroyed them
'Aliens try to take over the earth
'Only one man, actually on dinosaur can stop them
'Larry the dinosaur
'CREATED BY JOE KING
'===========
'POWER ELF
'CREATED BY JAMES HEATH
'TWO ELFS TRYING TO FIGHT THERE WAY ACROSS UNKNOWN WORLDS
'============================
'ALL THESE GAMES COMING SOON FROM
'DELTA CODE
'===========

'Members of Delta Code
'=====================
'Joe King  James Heath


'QUESTIONS, COMMENTS
'===================
'IF YOU HAVE ANY QUESTIONS OR COMMENTS
'PLEASE FEEL FREE TO WRITE ME
'MY ADDRESS IS
'===================
'JOE KING
'155 SOUTH 200 WEST
'DELTA UT, 84624
'===================
'OR YOU COULD E-MAIL ME
'JOEK@W.MILLARD.K12.UT.US
'========================
'I'D LIKE TO HERE FROM YOU
'===================

END SUB

SUB INTRO (SPRITES%(), EPS%, az%)
SCREEN 13: CLS
PUT (100, 60), SPRITES%(EPS% * 350), PSET
FOR TM% = -32000 TO 32000: NEXT TM%
PUT (108, 60), SPRITES%(EPS% * 351), PSET
FOR TM% = -32000 TO 32000: NEXT TM%
PUT (116, 60), SPRITES%(EPS% * 352), PSET
FOR TM% = -32000 TO 32000: NEXT TM%
PUT (124, 60), SPRITES%(EPS% * 353), PSET
FOR TM% = -32000 TO 32000: NEXT TM%
PUT (132, 60), SPRITES%(EPS% * 354), PSET
FOR TM% = -32000 TO 32000: NEXT TM%
PUT (140, 60), SPRITES%(EPS% * 355), PSET
FOR TM% = -32000 TO 32000: NEXT TM%
PUT (148, 60), SPRITES%(EPS% * 356), PSET
FOR a% = 1 TO 315 STEP 7
PUT (a%, 70), SPRITES%(EPS% * 4), PSET
FOR TM% = 1 TO 10000: NEXT TM%
NEXT a%
v% = 210
z% = 280
a% = 0
LOCATE 1, 14: COLOR 15: PRINT "VERSION 1.6"
LOCATE 15, 14: COLOR 14: PRINT "PRESS A KEY"
8030
a$ = INKEY$
IF a$ <> "" THEN GOTO 6000
PUT (183, 60), SPRITES%(EPS% * v%), PSET
PUT (163, 60), SPRITES%(EPS% * z%), PSET
z% = z% + 1
v% = v% + 1
FOR Delay& = 1 TO ESpeed&: NEXT Delay&
IF v% > 235 THEN v% = 210
IF z% > 305 THEN z% = 280
GOTO 8030
6000
y% = 3
CLS
COLOR 15
PRINT "CHOOSE>>>"
PRINT "=============="
PRINT "    ICE CAVE  "
PRINT "    TREE PLACE"
PRINT "    TOAD BAR  "
PRINT "    THE MUSEUM"
PRINT "    CRAZY PSYCHONISE"
PRINT "    BIG STUPID HOUSE"
PRINT "    CRATE HOUSE"
PRINT "    STUFF"
PRINT "    RANDOM"
PRINT "    LEVEL BUILDER"
PRINT "    CREDITS"
COLOR 14
DO
LOCATE y%, 2: PRINT ""
DO
a$ = INKEY$
LOOP UNTIL a$ <> ""
LOCATE y%, 2: PRINT " "
IF a$ = CHR$(0) + "P" THEN y% = y% + 1
IF a$ = CHR$(0) + "H" THEN y% = y% - 1
IF a$ = CHR$(13) THEN GOTO 10000
IF a$ = "L" OR a$ = "l" THEN az% = 99: GOTO 10000
IF a$ = "C" OR a$ = "c" THEN GOSUB Credits: CR% = 1: GOTO 10000
IF a$ = CHR$(27) THEN END
IF y% > 13 THEN y% = 3
IF y% < 3 THEN y% = 13
LOOP

Credits:
CLS
SCREEN 0
COLOR 15, 0
PRINT "  PROGRAMMING  *DELTACODE*  TESTERS"
PRINT "  ===========     1999      ======="
PRINT "    JOE KING                JOE KING"
PRINT "              "
PRINT "   WITH HELP              JAMES HEATH"
PRINT "FROM JAMES HEATH"
PRINT "                          DANIEL KING"
PRINT "   GRAPHICS   "
PRINT "   ========             JUSTIN STANWORTH"
PRINT "              "
PRINT "   JOE KING                JOHN HEATH"
PRINT "              "
PRINT " LEVEL DESIGN            SPECIAL THANKS"
PRINT " ============            =============="
PRINT "              "
PRINT "  ALL LEVELS               JAMES HEATH"
PRINT " WERE CREATED "
PRINT "  BY JOE KING                FROGMAN"
PRINT "              "
PRINT " PRESS ANY KEY            TIM TRUMAN'S"
PRINT " TO GO BACK TO MAIN       SPRITE EDITOR"
SLEEP
SCREEN 13
DO
LOOP UNTIL INKEY$ = ""
RETURN

10000
IF y% = 3 THEN az% = 1
IF y% = 4 THEN az% = 2
IF y% = 5 THEN az% = 3
IF y% = 6 THEN az% = 4
IF y% = 7 THEN az% = 5
IF y% = 8 THEN az% = 6
IF y% = 9 THEN az% = 7
IF y% = 10 THEN az% = 8
IF y% = 11 THEN az% = INT(8 * RND(1)) + 1
IF y% = 12 THEN az% = 99
IF y% = 13 THEN az% = 98: GOSUB Credits
END SUB

DEFINT A-Z
SUB LEVELBUILBER (MZ$(), SPRITES%(), EPS%, SP%(), LB%)
FOR zz% = 1 TO 40
MZ$(zz%) = "                                        "
NEXT zz%
PUSS% = 1: SSUP% = 2
GOSUB BOARDER
CLS
X% = 2: y% = 2
B% = 2: a% = 2
OX% = X%: OY% = y%
OB% = 2: OA% = 2
TR% = 0: RT% = 1
FL% = 0: LF% = 1
800
606
SELECT CASE PUS%
CASE IS = 1
CLS
FOR yy% = 1 TO 21
FOR zz% = 1 TO 40
GOSUB CHECKC
NEXT zz%
NEXT yy%
CASE IS = 2
CLS
FOR yy% = 19 TO 40
FOR zz% = 1 TO 40
YY1% = yy% - 17
GOSUB CHECKE
NEXT zz%
NEXT yy%
END SELECT
PUS% = 0
IF KK% = 1 THEN KK% = 0: RETURN
LOCATE y%, X%: COLOR 15: PRINT "+"
DO
a$ = INKEY$
LOOP UNTIL a$ <> ""
IF PUSS% = 1 THEN GOSUB CHECKD
IF PUSS% = 2 THEN GOSUB CHECKF
IF a$ = CHR$(0) + "M" THEN X% = X% + 1
IF a$ = CHR$(0) + "K" THEN X% = X% - 1
IF a$ = CHR$(0) + "P" THEN y% = y% + 1
IF a$ = CHR$(0) + "H" THEN y% = y% - 1
IF a$ = CHR$(0) + "S" AND PUSS% = 1 THEN MID$(MZ$(y%), X%, 1) = " "
IF a$ = CHR$(0) + "S" AND PUSS% = 2 THEN MID$(MZ$(y% + 17), X%, 1) = " "
IF a$ = "B" OR a$ = "b" THEN GOSUB BOARDER
IF a$ = "P" OR a$ = "p" THEN SWAP PUSS%, SSUP%: KL% = 1
IF a$ = "S" OR a$ = "s" THEN GOSUB SAVE: PUS% = PUSS%
IF a$ = "L" OR a$ = "l" THEN GOSUB LOAD: PUS% = PUSS%
IF a$ = " " THEN IF PUSS% = 1 THEN SPRTA% = SPRT%: GOSUB CHECKB
IF a$ = " " THEN IF PUSS% = 2 THEN SPRTA% = SPRT%: GOSUB CHECKG
IF a$ = CHR$(27) THEN LB% = 1: GOTO 10001
IF a$ = CHR$(13) THEN CLS : GOSUB LISTT
IF a$ = "T" OR a$ = "t" THEN SWAP TR%, RT%
IF a$ = "F" OR a$ = "f" THEN IF PUSS% = 1 THEN SWAP FL%, LF%: Q% = X%: W% = y%
IF a$ = "F" OR a$ = "f" THEN IF PUSS% = 2 THEN SWAP FL%, LF%: Q% = X%: W% = y% + 17
IF FL% = 1 THEN GOSUB FILLMODE
IF X% < 2 THEN X% = 39
IF X% > 39 THEN X% = 2
IF y% < 2 THEN y% = 21
IF y% > 21 THEN IF PUSS% = 1 THEN y% = 2
IF y% > 22 THEN IF PUSS% = 2 THEN y% = 2
OX% = X%: OY% = y%
OY1% = OY% + 17
Y1% = y% + 17
IF KL% = 1 THEN KL% = 0: PUS% = PUSS%
IF TR% = 1 AND PUSS% = 1 THEN SPRTA% = SPRT%: GOSUB CHECKB
IF TR% = 1 AND PUSS% = 2 THEN SPRTA% = SPRT%: GOSUB CHECKG
GOTO 800
LISTT:
FOR yy% = 1 TO 10
FOR zz% = 1 TO 40
READ AA%
SP%(yy%, zz%) = AA%
PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * AA%), PSET
NEXT zz%
NEXT yy%
RESTORE
801
LOCATE a%, B%: COLOR 15: PRINT "+"
DO
a$ = INKEY$
LOOP UNTIL a$ <> ""
PUT (OB% * 8 - 8, OA% * 8 - 8), SPRITES%(EPS% * (SP%(OA%, OB%))), PSET
IF a$ = CHR$(0) + "M" THEN B% = B% + 1
IF a$ = CHR$(0) + "K" THEN B% = B% - 1
IF a$ = CHR$(0) + "P" THEN a% = a% + 1
IF a$ = CHR$(0) + "H" THEN a% = a% - 1
IF a$ = CHR$(13) THEN FOR zz% = 1 TO (a% * 40) - 40 + B%: READ AA%: NEXT zz%: SPRT% = AA%: CLS : PUS% = PUSS%: RESTORE: RETURN
IF a$ = CHR$(27) THEN CLS : RETURN
IF B% < 1 THEN B% = 40
IF B% > 40 THEN B% = 1
IF a% > 10 THEN a% = 1
IF a% < 1 THEN a% = 10
OB% = B%: OA% = a%
GOTO 801
CHECKA:
IF SPRTA% = 16 THEN MID$(MZ$(yy%), zz%, 1) = " "
IF SPRTA% = 1 THEN MID$(MZ$(yy%), zz%, 1) = "B"
IF SPRTA% = 3 THEN MID$(MZ$(yy%), zz%, 1) = "b"
IF SPRTA% = 67 THEN MID$(MZ$(yy%), zz%, 1) = "_"
IF SPRTA% = 68 THEN MID$(MZ$(yy%), zz%, 1) = "="
IF SPRTA% = 69 THEN MID$(MZ$(yy%), zz%, 1) = "+"
IF SPRTA% = 32 THEN MID$(MZ$(yy%), zz%, 1) = "n"
IF SPRTA% = 33 THEN MID$(MZ$(yy%), zz%, 1) = "N"
IF SPRTA% = 34 THEN MID$(MZ$(yy%), zz%, 1) = "M"
IF SPRTA% = 70 THEN MID$(MZ$(yy%), zz%, 1) = "1"
IF SPRTA% = 71 THEN MID$(MZ$(yy%), zz%, 1) = "2"
IF SPRTA% = 72 THEN MID$(MZ$(yy%), zz%, 1) = "3"
IF SPRTA% = 73 THEN MID$(MZ$(yy%), zz%, 1) = "4"
IF SPRTA% = 74 THEN MID$(MZ$(yy%), zz%, 1) = "5"
IF SPRTA% = 75 THEN MID$(MZ$(yy%), zz%, 1) = "T"
IF SPRTA% = 76 THEN MID$(MZ$(yy%), zz%, 1) = "t"
IF SPRTA% = 77 THEN MID$(MZ$(yy%), zz%, 1) = "S"
IF SPRTA% = 78 THEN MID$(MZ$(yy%), zz%, 1) = "s"
IF SPRTA% = 79 THEN MID$(MZ$(yy%), zz%, 1) = "6"
IF SPRTA% = 80 THEN MID$(MZ$(yy%), zz%, 1) = "7"
IF SPRTA% = 81 THEN MID$(MZ$(yy%), zz%, 1) = "8"
IF SPRTA% = 82 THEN MID$(MZ$(yy%), zz%, 1) = "9"
IF SPRTA% = 83 THEN MID$(MZ$(yy%), zz%, 1) = "0"
IF SPRTA% = 84 THEN MID$(MZ$(yy%), zz%, 1) = "G"
IF SPRTA% = 85 THEN MID$(MZ$(yy%), zz%, 1) = "W"
IF SPRTA% = 86 THEN MID$(MZ$(yy%), zz%, 1) = "V"
IF SPRTA% = 87 THEN MID$(MZ$(yy%), zz%, 1) = "v"
IF SPRTA% = 88 THEN MID$(MZ$(yy%), zz%, 1) = "-"
IF SPRTA% = 89 THEN MID$(MZ$(yy%), zz%, 1) = "A"
IF SPRTA% = 90 THEN MID$(MZ$(yy%), zz%, 1) = "a"
IF SPRTA% = 91 THEN MID$(MZ$(yy%), zz%, 1) = "L"
IF SPRTA% = 92 THEN MID$(MZ$(yy%), zz%, 1) = "l"
IF SPRTA% = 93 THEN MID$(MZ$(yy%), zz%, 1) = "Z"
IF SPRTA% = 94 THEN MID$(MZ$(yy%), zz%, 1) = "z"
IF SPRTA% = 95 THEN MID$(MZ$(yy%), zz%, 1) = "Y"
IF SPRTA% = 96 THEN MID$(MZ$(yy%), zz%, 1) = "y"
IF SPRTA% = 35 THEN MID$(MZ$(yy%), zz%, 1) = "K"
IF SPRTA% = 37 THEN MID$(MZ$(yy%), zz%, 1) = "k"
IF SPRTA% = 39 THEN MID$(MZ$(yy%), zz%, 1) = "R"
IF SPRTA% = 36 THEN MID$(MZ$(yy%), zz%, 1) = "D"
IF SPRTA% = 38 THEN MID$(MZ$(yy%), zz%, 1) = "d"
IF SPRTA% = 40 THEN MID$(MZ$(yy%), zz%, 1) = "r"
IF SPRTA% = 97 THEN MID$(MZ$(yy%), zz%, 1) = "*"
IF SPRTA% = 98 THEN MID$(MZ$(yy%), zz%, 1) = "#"
RETURN
CHECKB:
IF SPRTA% = 16 THEN MID$(MZ$(y%), X%, 1) = " "
IF SPRTA% = 1 THEN MID$(MZ$(y%), X%, 1) = "B"
IF SPRTA% = 3 THEN MID$(MZ$(y%), X%, 1) = "b"
IF SPRTA% = 67 THEN MID$(MZ$(y%), X%, 1) = "_"
IF SPRTA% = 68 THEN MID$(MZ$(y%), X%, 1) = "="
IF SPRTA% = 69 THEN MID$(MZ$(y%), X%, 1) = "+"
IF SPRTA% = 32 THEN MID$(MZ$(y%), X%, 1) = "n"
IF SPRTA% = 33 THEN MID$(MZ$(y%), X%, 1) = "N"
IF SPRTA% = 34 THEN MID$(MZ$(y%), X%, 1) = "M"
IF SPRTA% = 70 THEN MID$(MZ$(y%), X%, 1) = "1"
IF SPRTA% = 71 THEN MID$(MZ$(y%), X%, 1) = "2"
IF SPRTA% = 72 THEN MID$(MZ$(y%), X%, 1) = "3"
IF SPRTA% = 73 THEN MID$(MZ$(y%), X%, 1) = "4"
IF SPRTA% = 74 THEN MID$(MZ$(y%), X%, 1) = "5"
IF SPRTA% = 75 THEN MID$(MZ$(y%), X%, 1) = "T"
IF SPRTA% = 76 THEN MID$(MZ$(y%), X%, 1) = "t"
IF SPRTA% = 77 THEN MID$(MZ$(y%), X%, 1) = "S"
IF SPRTA% = 78 THEN MID$(MZ$(y%), X%, 1) = "s"
IF SPRTA% = 79 THEN MID$(MZ$(y%), X%, 1) = "6"
IF SPRTA% = 80 THEN MID$(MZ$(y%), X%, 1) = "7"
IF SPRTA% = 81 THEN MID$(MZ$(y%), X%, 1) = "8"
IF SPRTA% = 82 THEN MID$(MZ$(y%), X%, 1) = "9"
IF SPRTA% = 83 THEN MID$(MZ$(y%), X%, 1) = "0"
IF SPRTA% = 84 THEN MID$(MZ$(y%), X%, 1) = "G"
IF SPRTA% = 85 THEN MID$(MZ$(y%), X%, 1) = "W"
IF SPRTA% = 86 THEN MID$(MZ$(y%), X%, 1) = "V"
IF SPRTA% = 87 THEN MID$(MZ$(y%), X%, 1) = "v"
IF SPRTA% = 88 THEN MID$(MZ$(y%), X%, 1) = "-"
IF SPRTA% = 89 THEN MID$(MZ$(y%), X%, 1) = "A"
IF SPRTA% = 90 THEN MID$(MZ$(y%), X%, 1) = "a"
IF SPRTA% = 91 THEN MID$(MZ$(y%), X%, 1) = "L"
IF SPRTA% = 92 THEN MID$(MZ$(y%), X%, 1) = "l"
IF SPRTA% = 93 THEN MID$(MZ$(y%), X%, 1) = "Z"
IF SPRTA% = 94 THEN MID$(MZ$(y%), X%, 1) = "z"
IF SPRTA% = 95 THEN MID$(MZ$(y%), X%, 1) = "Y"
IF SPRTA% = 96 THEN MID$(MZ$(y%), X%, 1) = "y"
IF SPRTA% = 35 THEN MID$(MZ$(y%), X%, 1) = "K"
IF SPRTA% = 37 THEN MID$(MZ$(y%), X%, 1) = "k"
IF SPRTA% = 39 THEN MID$(MZ$(y%), X%, 1) = "R"
IF SPRTA% = 36 THEN MID$(MZ$(y%), X%, 1) = "D"
IF SPRTA% = 38 THEN MID$(MZ$(y%), X%, 1) = "d"
IF SPRTA% = 40 THEN MID$(MZ$(y%), X%, 1) = "r"
IF SPRTA% = 97 THEN MID$(MZ$(y%), X%, 1) = "*"
IF SPRTA% = 98 THEN MID$(MZ$(y%), X%, 1) = "#"
RETURN
CHECKC:
IF MID$(MZ$(yy%), zz%, 1) = " " THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 16), PSET
IF MID$(MZ$(yy%), zz%, 1) = "B" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 1), PSET
IF MID$(MZ$(yy%), zz%, 1) = "b" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 3), PSET
IF MID$(MZ$(yy%), zz%, 1) = "_" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 67), PSET
IF MID$(MZ$(yy%), zz%, 1) = "=" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 68), PSET
IF MID$(MZ$(yy%), zz%, 1) = "+" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 69), PSET
IF MID$(MZ$(yy%), zz%, 1) = "n" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 32), PSET
IF MID$(MZ$(yy%), zz%, 1) = "N" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 33), PSET
IF MID$(MZ$(yy%), zz%, 1) = "M" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 34), PSET
IF MID$(MZ$(yy%), zz%, 1) = "1" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 70), PSET
IF MID$(MZ$(yy%), zz%, 1) = "2" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 71), PSET
IF MID$(MZ$(yy%), zz%, 1) = "3" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 72), PSET
IF MID$(MZ$(yy%), zz%, 1) = "4" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 73), PSET
IF MID$(MZ$(yy%), zz%, 1) = "5" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 74), PSET
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 75), PSET
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 76), PSET
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 77), PSET
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 78), PSET
IF MID$(MZ$(yy%), zz%, 1) = "6" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 79), PSET
IF MID$(MZ$(yy%), zz%, 1) = "7" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 80), PSET
IF MID$(MZ$(yy%), zz%, 1) = "8" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 81), PSET
IF MID$(MZ$(yy%), zz%, 1) = "9" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 82), PSET
IF MID$(MZ$(yy%), zz%, 1) = "0" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 83), PSET
IF MID$(MZ$(yy%), zz%, 1) = "G" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 84), PSET
IF MID$(MZ$(yy%), zz%, 1) = "W" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 85), PSET
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 86), PSET
IF MID$(MZ$(yy%), zz%, 1) = "v" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 87), PSET
IF MID$(MZ$(yy%), zz%, 1) = "-" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 88), PSET
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 89), PSET
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 90), PSET
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 91), PSET
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 92), PSET
IF MID$(MZ$(yy%), zz%, 1) = "Y" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 95), PSET
IF MID$(MZ$(yy%), zz%, 1) = "Z" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 93), PSET
IF MID$(MZ$(yy%), zz%, 1) = "z" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 94), PSET
IF MID$(MZ$(yy%), zz%, 1) = "y" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 96), PSET
IF MID$(MZ$(yy%), zz%, 1) = "K" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 35), PSET
IF MID$(MZ$(yy%), zz%, 1) = "k" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 37), PSET
IF MID$(MZ$(yy%), zz%, 1) = "R" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 39), PSET
IF MID$(MZ$(yy%), zz%, 1) = "D" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 36), PSET
IF MID$(MZ$(yy%), zz%, 1) = "d" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 38), PSET
IF MID$(MZ$(yy%), zz%, 1) = "r" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 40), PSET
IF MID$(MZ$(yy%), zz%, 1) = "*" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 97), PSET
IF MID$(MZ$(yy%), zz%, 1) = "#" THEN PUT (zz% * 8 - 8, yy% * 8 - 8), SPRITES%(EPS% * 98), PSET
RETURN
CHECKD:        
IF MID$(MZ$(OY%), OX%, 1) = " " THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 16), PSET
IF MID$(MZ$(OY%), OX%, 1) = "B" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 1), PSET
IF MID$(MZ$(OY%), OX%, 1) = "b" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 3), PSET
IF MID$(MZ$(OY%), OX%, 1) = "_" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 67), PSET
IF MID$(MZ$(OY%), OX%, 1) = "=" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 68), PSET
IF MID$(MZ$(OY%), OX%, 1) = "+" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 69), PSET
IF MID$(MZ$(OY%), OX%, 1) = "n" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 32), PSET
IF MID$(MZ$(OY%), OX%, 1) = "N" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 33), PSET
IF MID$(MZ$(OY%), OX%, 1) = "M" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 34), PSET
IF MID$(MZ$(OY%), OX%, 1) = "1" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 70), PSET
IF MID$(MZ$(OY%), OX%, 1) = "2" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 71), PSET
IF MID$(MZ$(OY%), OX%, 1) = "3" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 72), PSET
IF MID$(MZ$(OY%), OX%, 1) = "4" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 73), PSET
IF MID$(MZ$(OY%), OX%, 1) = "5" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 74), PSET
IF MID$(MZ$(OY%), OX%, 1) = "T" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 75), PSET
IF MID$(MZ$(OY%), OX%, 1) = "t" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 76), PSET
IF MID$(MZ$(OY%), OX%, 1) = "S" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 77), PSET
IF MID$(MZ$(OY%), OX%, 1) = "s" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 78), PSET
IF MID$(MZ$(OY%), OX%, 1) = "6" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 79), PSET
IF MID$(MZ$(OY%), OX%, 1) = "7" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 80), PSET
IF MID$(MZ$(OY%), OX%, 1) = "8" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 81), PSET
IF MID$(MZ$(OY%), OX%, 1) = "9" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 82), PSET
IF MID$(MZ$(OY%), OX%, 1) = "0" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 83), PSET
IF MID$(MZ$(OY%), OX%, 1) = "G" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 84), PSET
IF MID$(MZ$(OY%), OX%, 1) = "W" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 85), PSET
IF MID$(MZ$(OY%), OX%, 1) = "V" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 86), PSET
IF MID$(MZ$(OY%), OX%, 1) = "v" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 87), PSET
IF MID$(MZ$(OY%), OX%, 1) = "-" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 88), PSET
IF MID$(MZ$(OY%), OX%, 1) = "A" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 89), PSET
IF MID$(MZ$(OY%), OX%, 1) = "a" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 90), PSET
IF MID$(MZ$(OY%), OX%, 1) = "L" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 91), PSET
IF MID$(MZ$(OY%), OX%, 1) = "l" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 92), PSET
IF MID$(MZ$(OY%), OX%, 1) = "Y" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 95), PSET
IF MID$(MZ$(OY%), OX%, 1) = "y" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 96), PSET
IF MID$(MZ$(OY%), OX%, 1) = "Z" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 93), PSET
IF MID$(MZ$(OY%), OX%, 1) = "z" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 94), PSET
IF MID$(MZ$(OY%), OX%, 1) = "K" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 35), PSET
IF MID$(MZ$(OY%), OX%, 1) = "k" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 37), PSET
IF MID$(MZ$(OY%), OX%, 1) = "R" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 39), PSET
IF MID$(MZ$(OY%), OX%, 1) = "D" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 36), PSET
IF MID$(MZ$(OY%), OX%, 1) = "d" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 38), PSET
IF MID$(MZ$(OY%), OX%, 1) = "r" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 40), PSET
IF MID$(MZ$(OY%), OX%, 1) = "*" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 97), PSET
IF MID$(MZ$(OY%), OX%, 1) = "#" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 98), PSET
RETURN
CHECKE:
IF MID$(MZ$(yy%), zz%, 1) = " " THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 16), PSET
IF MID$(MZ$(yy%), zz%, 1) = "B" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 1), PSET
IF MID$(MZ$(yy%), zz%, 1) = "b" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 3), PSET
IF MID$(MZ$(yy%), zz%, 1) = "_" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 67), PSET
IF MID$(MZ$(yy%), zz%, 1) = "=" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 68), PSET
IF MID$(MZ$(yy%), zz%, 1) = "+" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 69), PSET
IF MID$(MZ$(yy%), zz%, 1) = "n" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 32), PSET
IF MID$(MZ$(yy%), zz%, 1) = "N" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 33), PSET
IF MID$(MZ$(yy%), zz%, 1) = "M" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 34), PSET
IF MID$(MZ$(yy%), zz%, 1) = "1" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 70), PSET
IF MID$(MZ$(yy%), zz%, 1) = "2" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 71), PSET
IF MID$(MZ$(yy%), zz%, 1) = "3" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 72), PSET
IF MID$(MZ$(yy%), zz%, 1) = "4" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 73), PSET
IF MID$(MZ$(yy%), zz%, 1) = "5" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 74), PSET
IF MID$(MZ$(yy%), zz%, 1) = "T" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 75), PSET
IF MID$(MZ$(yy%), zz%, 1) = "t" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 76), PSET
IF MID$(MZ$(yy%), zz%, 1) = "S" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 77), PSET
IF MID$(MZ$(yy%), zz%, 1) = "s" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 78), PSET
IF MID$(MZ$(yy%), zz%, 1) = "6" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 79), PSET
IF MID$(MZ$(yy%), zz%, 1) = "7" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 80), PSET
IF MID$(MZ$(yy%), zz%, 1) = "8" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 81), PSET
IF MID$(MZ$(yy%), zz%, 1) = "9" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 82), PSET
IF MID$(MZ$(yy%), zz%, 1) = "0" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 83), PSET
IF MID$(MZ$(yy%), zz%, 1) = "G" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 84), PSET
IF MID$(MZ$(yy%), zz%, 1) = "W" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 85), PSET
IF MID$(MZ$(yy%), zz%, 1) = "V" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 86), PSET
IF MID$(MZ$(yy%), zz%, 1) = "v" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 87), PSET
IF MID$(MZ$(yy%), zz%, 1) = "-" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 88), PSET
IF MID$(MZ$(yy%), zz%, 1) = "A" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 89), PSET
IF MID$(MZ$(yy%), zz%, 1) = "a" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 90), PSET
IF MID$(MZ$(yy%), zz%, 1) = "L" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 91), PSET
IF MID$(MZ$(yy%), zz%, 1) = "l" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 92), PSET
IF MID$(MZ$(yy%), zz%, 1) = "Y" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 95), PSET
IF MID$(MZ$(yy%), zz%, 1) = "y" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 96), PSET
IF MID$(MZ$(yy%), zz%, 1) = "Z" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 93), PSET
IF MID$(MZ$(yy%), zz%, 1) = "z" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 94), PSET
IF MID$(MZ$(yy%), zz%, 1) = "K" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 35), PSET
IF MID$(MZ$(yy%), zz%, 1) = "k" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 37), PSET
IF MID$(MZ$(yy%), zz%, 1) = "R" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 39), PSET
IF MID$(MZ$(yy%), zz%, 1) = "D" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 36), PSET
IF MID$(MZ$(yy%), zz%, 1) = "d" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 38), PSET
IF MID$(MZ$(yy%), zz%, 1) = "r" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 40), PSET
IF MID$(MZ$(yy%), zz%, 1) = "*" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 97), PSET
IF MID$(MZ$(yy%), zz%, 1) = "#" THEN PUT (zz% * 8 - 8, YY1% * 8 - 8), SPRITES%(EPS% * 98), PSET
RETURN
CHECKF:     
IF MID$(MZ$(OY1%), OX%, 1) = " " THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 16), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "B" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 1), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "b" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 3), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "_" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 67), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "=" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 68), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "+" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 69), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "n" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 32), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "N" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 33), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "M" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 34), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "1" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 70), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "2" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 71), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "3" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 72), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "4" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 73), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "5" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 74), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "T" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 75), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "t" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 76), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "S" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 77), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "s" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 78), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "6" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 79), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "7" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 80), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "8" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 81), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "9" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 82), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "0" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 83), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "G" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 84), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "W" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 85), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "V" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 86), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "v" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 87), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "-" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 88), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "A" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 89), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "a" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 90), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "Y" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 95), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "y" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 96), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "Z" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 93), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "z" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 94), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "L" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 91), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "l" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 92), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "K" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 35), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "k" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 37), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "R" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 39), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "D" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 36), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "d" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 38), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "r" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 40), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "*" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 97), PSET
IF MID$(MZ$(OY1%), OX%, 1) = "#" THEN PUT (OX% * 8 - 8, OY% * 8 - 8), SPRITES%(EPS% * 98), PSET
RETURN
CHECKG:
IF SPRTA% = 16 THEN MID$(MZ$(Y1%), X%, 1) = " "
IF SPRTA% = 1 THEN MID$(MZ$(Y1%), X%, 1) = "B"
IF SPRTA% = 3 THEN MID$(MZ$(Y1%), X%, 1) = "b"
IF SPRTA% = 67 THEN MID$(MZ$(Y1%), X%, 1) = "_"
IF SPRTA% = 68 THEN MID$(MZ$(Y1%), X%, 1) = "="
IF SPRTA% = 69 THEN MID$(MZ$(Y1%), X%, 1) = "+"
IF SPRTA% = 32 THEN MID$(MZ$(Y1%), X%, 1) = "n"
IF SPRTA% = 33 THEN MID$(MZ$(Y1%), X%, 1) = "N"
IF SPRTA% = 34 THEN MID$(MZ$(Y1%), X%, 1) = "M"
IF SPRTA% = 70 THEN MID$(MZ$(Y1%), X%, 1) = "1"
IF SPRTA% = 71 THEN MID$(MZ$(Y1%), X%, 1) = "2"
IF SPRTA% = 72 THEN MID$(MZ$(Y1%), X%, 1) = "3"
IF SPRTA% = 73 THEN MID$(MZ$(Y1%), X%, 1) = "4"
IF SPRTA% = 74 THEN MID$(MZ$(Y1%), X%, 1) = "5"
IF SPRTA% = 75 THEN MID$(MZ$(Y1%), X%, 1) = "T"
IF SPRTA% = 76 THEN MID$(MZ$(Y1%), X%, 1) = "t"
IF SPRTA% = 77 THEN MID$(MZ$(Y1%), X%, 1) = "S"
IF SPRTA% = 78 THEN MID$(MZ$(Y1%), X%, 1) = "s"
IF SPRTA% = 79 THEN MID$(MZ$(Y1%), X%, 1) = "6"
IF SPRTA% = 80 THEN MID$(MZ$(Y1%), X%, 1) = "7"
IF SPRTA% = 81 THEN MID$(MZ$(Y1%), X%, 1) = "8"
IF SPRTA% = 82 THEN MID$(MZ$(Y1%), X%, 1) = "9"
IF SPRTA% = 83 THEN MID$(MZ$(Y1%), X%, 1) = "0"
IF SPRTA% = 84 THEN MID$(MZ$(Y1%), X%, 1) = "G"
IF SPRTA% = 85 THEN MID$(MZ$(Y1%), X%, 1) = "W"
IF SPRTA% = 86 THEN MID$(MZ$(Y1%), X%, 1) = "V"
IF SPRTA% = 87 THEN MID$(MZ$(Y1%), X%, 1) = "v"
IF SPRTA% = 88 THEN MID$(MZ$(Y1%), X%, 1) = "-"
IF SPRTA% = 89 THEN MID$(MZ$(Y1%), X%, 1) = "A"
IF SPRTA% = 90 THEN MID$(MZ$(Y1%), X%, 1) = "a"
IF SPRTA% = 91 THEN MID$(MZ$(Y1%), X%, 1) = "L"
IF SPRTA% = 92 THEN MID$(MZ$(Y1%), X%, 1) = "l"
IF SPRTA% = 93 THEN MID$(MZ$(Y1%), X%, 1) = "Z"
IF SPRTA% = 94 THEN MID$(MZ$(Y1%), X%, 1) = "z"
IF SPRTA% = 95 THEN MID$(MZ$(Y1%), X%, 1) = "Y"
IF SPRTA% = 96 THEN MID$(MZ$(Y1%), X%, 1) = "y"
IF SPRTA% = 35 THEN MID$(MZ$(Y1%), X%, 1) = "K"
IF SPRTA% = 37 THEN MID$(MZ$(Y1%), X%, 1) = "k"
IF SPRTA% = 39 THEN MID$(MZ$(Y1%), X%, 1) = "R"
IF SPRTA% = 36 THEN MID$(MZ$(Y1%), X%, 1) = "D"
IF SPRTA% = 38 THEN MID$(MZ$(Y1%), X%, 1) = "d"
IF SPRTA% = 40 THEN MID$(MZ$(Y1%), X%, 1) = "r"
IF SPRTA% = 97 THEN MID$(MZ$(Y1%), X%, 1) = "*"
IF SPRTA% = 98 THEN MID$(MZ$(Y1%), X%, 1) = "#"
RETURN
BOARDER:
CLS
LOCATE 1, 1: COLOR 15
PRINT "70 = ": PUT (40, 0 * 8), SPRITES%(EPS% * 70)
PRINT "71 = ": PUT (40, 1 * 8), SPRITES%(EPS% * 71)
PRINT "72 = ": PUT (40, 2 * 8), SPRITES%(EPS% * 72)
PRINT "73 = ": PUT (40, 3 * 8), SPRITES%(EPS% * 73)
PRINT "74 = ": PUT (40, 4 * 8), SPRITES%(EPS% * 74)
PRINT "75 = ": PUT (40, 5 * 8), SPRITES%(EPS% * 75)
PRINT "76 = ": PUT (40, 6 * 8), SPRITES%(EPS% * 76)
PRINT "77 = ": PUT (40, 7 * 8), SPRITES%(EPS% * 77)
PRINT "78 = ": PUT (40, 8 * 8), SPRITES%(EPS% * 78)
PRINT "79 = ": PUT (40, 9 * 8), SPRITES%(EPS% * 79)
PRINT "80 = ": PUT (40, 10 * 8), SPRITES%(EPS% * 80)
PRINT "81 = ": PUT (40, 11 * 8), SPRITES%(EPS% * 81)
PRINT "82 = ": PUT (40, 12 * 8), SPRITES%(EPS% * 82)
PRINT "83 = ": PUT (40, 13 * 8), SPRITES%(EPS% * 83)
PRINT "84 = ": PUT (40, 14 * 8), SPRITES%(EPS% * 84)
PRINT "85 = ": PUT (40, 15 * 8), SPRITES%(EPS% * 85)
PRINT "86 = ": PUT (40, 16 * 8), SPRITES%(EPS% * 86)
PRINT "87 = ": PUT (40, 17 * 8), SPRITES%(EPS% * 87)
PRINT "88 = ": PUT (40, 18 * 8), SPRITES%(EPS% * 88)
PRINT "89 = ": PUT (40, 19 * 8), SPRITES%(EPS% * 89)
PRINT "90 = ": PUT (40, 20 * 8), SPRITES%(EPS% * 90)
PRINT "93 = ": PUT (40, 21 * 8), SPRITES%(EPS% * 93)
PRINT "94 = ": PUT (40, 22 * 8), SPRITES%(EPS% * 94)
LOCATE 22, 8: PRINT "95 = ": PUT (96, 21 * 8), SPRITES%(EPS% * 95)
LOCATE 23, 8: PRINT "96 = ": PUT (96, 22 * 8), SPRITES%(EPS% * 96)
LOCATE 1, 10: PRINT "CHOOSE BOARDER"
LOCATE 2, 10: PRINT "/\/\/\/\/\/\/\"
LOCATE 4, 10: INPUT "ENTER NUMBER/", NM%
FOR X% = 1 TO 40
Y1% = 1
SPRTA% = NM%
GOSUB CHECKG
NEXT X%
FOR X% = 1 TO 40
Y1% = 40
SPRTA% = NM%
GOSUB CHECKG
NEXT X%
FOR Y1% = 2 TO 39
X% = 1
SPRTA% = NM%
GOSUB CHECKG
NEXT Y1%
FOR Y1% = 2 TO 39
X% = 40
SPRTA% = NM%
GOSUB CHECKG
NEXT Y1%
CLS
PUS% = PUSS%
RETURN
FILLMODE:
SELECT CASE PUSS%
CASE IS = 1
FOR yy% = W% TO y%
FOR zz% = Q% TO X%
SPRTA% = SPRT%: GOSUB CHECKA
NEXT zz%
NEXT yy%
CASE IS = 2
FOR yy% = W% TO y% + 17
FOR zz% = Q% TO X%
SPRTA% = SPRT%: GOSUB CHECKA
NEXT zz%
NEXT yy%
END SELECT
KK% = 1
IF PUSS% = 1 THEN PUS% = 1
IF PUSS% = 2 THEN PUS% = 2
GOSUB 606
RETURN
SAVE:
OPEN "TOADSAVE.DAT" FOR INPUT AS #1
INPUT #1, a$, B$, C$, D$, E$, F$, G$, H$, I$, J$
CLOSE
CLS
LOCATE 1, 1: COLOR 15
PRINT "SAVE ON WHICH FILE"
PRINT "/\/\/\/\/\/\/\/\/\"
PRINT "(1) "; a$
PRINT "(2) "; B$
PRINT "(3) "; C$
PRINT "(4) "; D$
PRINT "(5) "; E$
PRINT "(6) "; F$
PRINT "(7) "; G$
PRINT "(8) "; H$
PRINT "(9) "; I$
PRINT "(0) "; J$
DO
z$ = INKEY$
LOOP UNTIL z$ <> ""
IF z$ = CHR$(27) THEN RETURN
IF z$ = "1" THEN a% = 1
IF z$ = "2" THEN a% = 2
IF z$ = "3" THEN a% = 3
IF z$ = "4" THEN a% = 4
IF z$ = "5" THEN a% = 5
IF z$ = "6" THEN a% = 6
IF z$ = "7" THEN a% = 7
IF z$ = "8" THEN a% = 8
IF z$ = "9" THEN a% = 9
IF z$ = "0" THEN a% = 10
IF a% <> 0 THEN GOSUB SAVENAME
RETURN
SAVENAME:
LOCATE 22, 1: COLOR 15
INPUT "ENTER NAME/", NM$
IF LEN(NM$) > 8 THEN LOCATE 23, 1: COLOR 4: PRINT "CANNOT BE MORE THAN EIGHT LETTERS": SLEEP: GOTO SAVE
OPEN NM$ + ".TD1" FOR OUTPUT AS #1
FOR zz% = 1 TO 40
WRITE #1, MZ$(zz%)
NEXT zz%
CLOSE
IF a% = 1 THEN a$ = NM$
IF a% = 2 THEN B$ = NM$
IF a% = 3 THEN C$ = NM$
IF a% = 4 THEN D$ = NM$
IF a% = 5 THEN E$ = NM$
IF a% = 6 THEN F$ = NM$
IF a% = 7 THEN G$ = NM$
IF a% = 8 THEN H$ = NM$
IF a% = 9 THEN I$ = NM$
IF a% = 0 THEN J$ = NM$
OPEN "TOADSAVE.DAT" FOR OUTPUT AS #1
WRITE #1, a$, B$, C$, D$, E$, F$, G$, H$, I$, J$
CLOSE
CLS
RETURN
LOAD:
OPEN "TOADSAVE.DAT" FOR INPUT AS #1
INPUT #1, a$, B$, C$, D$, E$, F$, G$, H$, I$, J$
CLOSE
CLS
LOCATE 1, 1: COLOR 15
PRINT "LOAD ON WHICH FILE"
PRINT "/\/\/\/\/\/\/\/\/\"
PRINT "(1) "; a$
PRINT "(2) "; B$
PRINT "(3) "; C$
PRINT "(4) "; D$
PRINT "(5) "; E$
PRINT "(6) "; F$
PRINT "(7) "; G$
PRINT "(8) "; H$
PRINT "(9) "; I$
PRINT "(0) "; J$
DO
z$ = INKEY$
LOOP UNTIL z$ <> ""
IF z$ = CHR$(27) THEN RETURN
IF z$ = "1" THEN a% = 1
IF z$ = "2" THEN a% = 2
IF z$ = "3" THEN a% = 3
IF z$ = "4" THEN a% = 4
IF z$ = "5" THEN a% = 5
IF z$ = "6" THEN a% = 6
IF z$ = "7" THEN a% = 7
IF z$ = "8" THEN a% = 8
IF z$ = "9" THEN a% = 9
IF z$ = "0" THEN a% = 10
IF a% = 0 THEN RETURN
IF a% = 1 THEN OPEN a$ + ".TD1" FOR INPUT AS #1
IF a% = 2 THEN OPEN B$ + ".TD1" FOR INPUT AS #1
IF a% = 3 THEN OPEN C$ + ".TD1" FOR INPUT AS #1
IF a% = 4 THEN OPEN D$ + ".TD1" FOR INPUT AS #1
IF a% = 5 THEN OPEN E$ + ".TD1" FOR INPUT AS #1
IF a% = 6 THEN OPEN F$ + ".TD1" FOR INPUT AS #1
IF a% = 7 THEN OPEN G$ + ".TD1" FOR INPUT AS #1
IF a% = 8 THEN OPEN H$ + ".TD1" FOR INPUT AS #1
IF a% = 9 THEN OPEN I$ + ".TD1" FOR INPUT AS #1
IF a% = 0 THEN OPEN J$ + ".TD1" FOR INPUT AS #1
FOR zz% = 1 TO 40
INPUT #1, MZ$(zz%)
NEXT zz%
CLOSE
CLS
RETURN

RETURN
10001
END SUB

DEFSNG A-Z
SUB MAZE1 (MZ$())
 MZ$(1) = "1111111111111111111111111111111111111111"
 MZ$(2) = "1            1K+M+M+M+M+M+1       1    1"
 MZ$(3) = "1      11111 1+M+M+M+M+M+M1    b  1  l 1"
 MZ$(4) = "1      1     1M+M+M+M+M+M+111 11111    1"
 MZ$(5) = "1B     1 11111111111r11111111          1"
 MZ$(6) = "11111111                      1111111111"
 MZ$(7) = "1      1  1 11111111 1 1               1"
 MZ$(8) = "1  L   1  1          1 1 S s S s S s S 1"
 MZ$(9) = "1         1 1111111111 1               1"
MZ$(10) = "11111111111 1          1 s S s S s S s 1"
MZ$(11) = "1         1 1  nnnnn   1               1"
MZ$(12) = "1  +++++  1 1  nnnnn   11111111111111111"
MZ$(13) = "1  +++++  1 1                          1"
MZ$(14) = "1         1 1                          1"
MZ$(15) = "1         1 1  -----------------       1"
MZ$(16) = "1         1 1  -               -       1"
MZ$(17) = "1         1 1  - M  M   M   M  - NNNNN 1"
MZ$(18) = "1         1 1  -               -       1"
MZ$(19) = "1         1 1  -               -       1"
MZ$(20) = "----  ----- ----               -       1"
MZ$(21) = "-                              ---------"
MZ$(22) = "-  S  s  S  s  S  s  S  s  S  s  S  s  -"
MZ$(23) = "-                                      -"
MZ$(24) = "-                                      -"
MZ$(25) = "-  s  S  s  S  s  S  s  S  s  S  s  S  -"
MZ$(26) = "-                                      -"
MZ$(27) = "-                                      -"
MZ$(28) = "-  S  s  S  s  S  s  S  s  S  s  S  s  -"
MZ$(29) = "-                                      -"
MZ$(30) = "-                                      -"
MZ$(31) = "-  s  S  s  S  s  S  s  S  s  S  s  S  -"
MZ$(32) = "-                                      -"
MZ$(33) = "-                  R                   -"
MZ$(34) = "-----D----------------------------------"
MZ$(35) = "A             a  a  a  a               A"
MZ$(36) = "A                                      A"
MZ$(37) = "A  a  a  a  a            a  a  a  a  11A"
MZ$(38) = "Ad111111          *#             11111kA"
MZ$(39) = "A______1                               A"
MZ$(40) = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
END SUB

DEFINT A-Z
SUB MAZE2 (MZ$())
 MZ$(1) = "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
 MZ$(2) = "T                               T      T"
 MZ$(3) = "T TTTTTTTTTTTT     TTTTTTTTTTTT T      T"
 MZ$(4) = "T            MT   T+            T      T"
 MZ$(5) = "T    t     t MMT T++ t     t    T      T"
 MZ$(6) = "T t     t    TTTrTTT    t     t T      T"
 MZ$(7) = "T            T=   =T            T      T"
 MZ$(8) = "TTTTTTTT  t  T=   =T  t  TTTTTTTT      T"
 MZ$(9) = "TNNNNNNT     T= T =T     TNNNNNNT      T"
MZ$(10) = "TN    NTTTTTTT= T =TTTTTTTN    NT      T"
MZ$(11) = "TN L   R       BTb      R   l  NT      T"
MZ$(12) = "TN    NTTTTTTT= T =TTTTTTTN    NT      T"
MZ$(13) = "TNNNNNNT     T= T =T     TNNNNNNT      T"
MZ$(14) = "TTTTTTTT  t  T=   =T  t  TTTTTTTT      T"
MZ$(15) = "T            T=   =T            T      T"
MZ$(16) = "T t     t    TTTrTTT    t     t T      T"
MZ$(17) = "T    t     t ++T TMM t     t    T      T"
MZ$(18) = "T            +T   TM            T      T"
MZ$(19) = "T TTTTTTTTTTTT     TTTTTTTTTTTT T      T"
MZ$(20) = "T                               T      T"
MZ$(21) = "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT      T"
MZ$(22) = "T                                      T"
MZ$(23) = "T                                      T"
MZ$(24) = "T                                      T"
MZ$(25) = "T                                      T"
MZ$(26) = "T                                      T"
MZ$(27) = "T                                      T"
MZ$(28) = "T                                      T"
MZ$(29) = "T                                      T"
MZ$(30) = "T                                      T"
MZ$(31) = "T                                      T"
MZ$(32) = "T                                      T"
MZ$(33) = "T                                      T"
MZ$(34) = "T                                      T"
MZ$(35) = "T                                      T"
MZ$(36) = "T                                      T"
MZ$(37) = "T                                      T"
MZ$(38) = "T                                      T"
MZ$(39) = "T                                      T"
MZ$(40) = "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
END SUB

SUB MAZE3 (MZ$())
 MZ$(1) = "2222222222222222222222222222222525225525"
 MZ$(2) = "2                2   99                2"
 MZ$(3) = "2 B         222  299    2 222255225255 5"
 MZ$(4) = "2  2  2  2  2    22222222 200000000005 2"
 MZ$(5) = "2+M2+M2+M2+M2 2222 V      200000000005 5"
 MZ$(6) = "2222222222222 2222 2222222200000000005 5"
 MZ$(7) = "2111112             3 9=N9222255255552 2"
 MZ$(8) = "21nnn12  A A a A a  3    #2            2"
 MZ$(9) = "21nnn12             r   992 222225555555"
MZ$(10) = "211d112  a A A a A  3   9M2 5          3"
MZ$(11) = "266  =2             39    2 5    MM  b 3"
MZ$(12) = "266   2  A a A a a  3  99 2 2    MM ++ 3"
MZ$(13) = "266                 3_ 99*2R5       ++ 3"
MZ$(14) = "222222222222   2222222222225522222     3"
MZ$(15) = "2l    99  L2   2                 2     3"
MZ$(16) = "2 99  9    2     7777 777 7777         3"
MZ$(17) = "2 99    99 2   2  7 7 7 7  7 7   2     3"
MZ$(18) = "2    99 99 2   2  777 777  777   2     3"
MZ$(19) = "22  22222222   2  7 7 7 7  7  7  2     3"
MZ$(20) = "2                7777 7 7  7   7       3"
MZ$(21) = "GGGGGGGGGGGG T 2                 2     3"
MZ$(22) = "GWWWWWWWWWWG   22222222222222 2222     3"
MZ$(23) = "GWWWWWWWWWWG t 33333333333      3      3"
MZ$(24) = "GWWWWWWWWWWG   3         3      33333333"
MZ$(25) = "GWWWWWWWWWWG T 3 A a A A 3      3      3"
MZ$(26) = "GWWWWWWWWWWG   3         3      3 3333 3"
MZ$(27) = "GGGGGGGGGGGG t 3 a a A a 33333333 3 k3 3"
MZ$(28) = "3   T   T      3         3   3    3 33 3"
MZ$(29) = "3 t   t   T    3           3   3  3    3"
MZ$(30) = "3 GGGGG 333333   33333333333333333333333"
MZ$(31) = "2 GWWWG 3    33333K             2   2 =2"
MZ$(32) = "2 GWWWG 3       2222222222222  22 2   22"
MZ$(33) = "2 GWWWG 3 ++ MM 2           2   2 222222"
MZ$(34) = "2 GWWWG 3       2  3333333  22  2      2"
MZ$(35) = "2 GWWWG 3 MM ++ 2 T3WWWWW3T 2   2  22  2"
MZ$(36) = "2 GWWWG 3       2  3WWWWW3  2n2    2   2"
MZ$(37) = "2 GGGGG 3333D3332 T3WWWWW3T 22222222 222"
MZ$(38) = "2    t         t   3333333  2   2    2n2"
MZ$(39) = "2t          T                 2   2    2"
MZ$(40) = "2222222222222222222222222222222222222222"

END SUB

SUB MAZE4 (MZ$())
 MZ$(1) = "2222222222222222222222222222222222222222"
 MZ$(2) = "2B         233  3                      3"
 MZ$(3) = "2 222  222 233  3                      3"
 MZ$(4) = "2 2K2  2k2 233  3  3  3333  33333  33333"
 MZ$(5) = "2 2 2  2 2 233     3  3         3  3  33"
 MZ$(6) = "2 2      2 233333333  3  33333  3  3  33"
 MZ$(7) = "2 22222222 2          3  33333  3  3  33"
 MZ$(8) = "2          D          3  33333  3     33"
 MZ$(9) = "22222222222233333333333  33333  33333333"
MZ$(10) = "66666666666666666666666  66666  66666666"
MZ$(10) = "6                                      6"
MZ$(11) = "6                                      6"
MZ$(12) = "6  66666666666666666666  666666666666  6"
MZ$(13) = "6   6______6             6nnnnnnd      6"
MZ$(14) = "6   d______6             6nnnnnn6      6"
MZ$(15) = "666666666666  66666666666666666666666666"
MZ$(16) = "888888888888  88888888888111111111111111"
MZ$(17) = "8          8            81             1"
MZ$(18) = "8          88888888888  81             1"
MZ$(19) = "8  888888            8  81  1111  111  1"
MZ$(20) = "8  8    8            8  81  1     *#1  1"
MZ$(21) = "8  8  8 88888888  8  8   r  1   11111  1"
MZ$(22) = "8     8       K8  8     81111   1      1"
MZ$(23) = "8888888888888888  88888881l     1L     1"
MZ$(24) = "7777777777777777  7777777711111111111111"
MZ$(25) = "7                        777777777777777"
MZ$(26) = "7                                      7"
MZ$(27) = "7  77777  7777777777777                7"
MZ$(28) = "7      7  7     7     77777777  77777  7"
MZ$(29) = "7      7  7R 7     7  D             7  7"
MZ$(30) = "77777777  7777777777777777          7  7"
MZ$(31) = "33333333  333333333333333777777777777777"
MZ$(32) = "3                       3332222222222222"
MZ$(33) = "3                       3  D           2"
MZ$(34) = "3  3    3333333   3333333  2 22222222  2"
MZ$(35) = "3  3    3                  2 2      2  2"
MZ$(36) = "3  3    3                  2 2 2  2 2  2"
MZ$(37) = "3  333333  3333   3333333332 2k2  2K2  2"
MZ$(38) = "3             3            2 222  222  2"
MZ$(39) = "3             3            2          b2"
MZ$(40) = "3333333333333333333333333332222222222222"

END SUB

SUB MAZE5 (MZ$())
 MZ$(1) = "2222222222222222222222222222222222222222"
 MZ$(2) = "2B                                    L2"
 MZ$(3) = "2                                      2"
 MZ$(4) = "2                                      2"
 MZ$(5) = "2      2222    k                       2"
 MZ$(6) = "2      2nn2                            2"
 MZ$(7) = "2      2nn2                            2"
 MZ$(8) = "2      22r2                 2222       2"
 MZ$(9) = "2                           2__2       2"
MZ$(10) = "2                           d__2       2"
MZ$(11) = "2                           2222       2"
MZ$(12) = "2                                      2"
MZ$(13) = "2                                      2"
MZ$(14) = "2                                      2"
MZ$(15) = "2           2222                       2"
MZ$(16) = "2           2NND                       2"
MZ$(17) = "2           2NN2                       2"
MZ$(18) = "2           2222                       2"
MZ$(19) = "2                              R       2"
MZ$(20) = "2   K                                  2"
MZ$(21) = "2                                      2"
MZ$(22) = "2    2222                              2"
MZ$(23) = "2    2__2                              2"
MZ$(24) = "2    2__2                              2"
MZ$(25) = "2    22r2              K               2"
MZ$(26) = "2                                      2"
MZ$(27) = "2                                      2"
MZ$(28) = "2                        2222          2"
MZ$(29) = "2                        D++2          2"
MZ$(30) = "2                        2MM2          2"
MZ$(31) = "2                        2222          2"
MZ$(32) = "2        k                             2"
MZ$(33) = "2    22d2                              2"
MZ$(34) = "2    2==2                              2"
MZ$(35) = "2    2==2                              2"
MZ$(36) = "2    2222                      R       2"
MZ$(37) = "2                                      2"
MZ$(38) = "2                                      2"
MZ$(39) = "2l                                    b2"
MZ$(40) = "2222222222222222222222222222222222222222"
END SUB

SUB MAZE6 (MZ$())
 MZ$(1) = "2222222222222222222222222222222222222222"
 MZ$(2) = "2MM      ++r   R     R2                2"
 MZ$(3) = "2       4  2M     +   2   2222222222+++2"
 MZ$(4) = "2 4444444  222222222222   2        2MMM2"
 MZ$(5) = "2 4 444    d          2   2        22222"
 MZ$(6) = "2++      MM2          22r22           k2"
 MZ$(7) = "2222222d2222                          k2"
 MZ$(8) = "2kk        2          22222        22222"
 MZ$(9) = "2          222222d22222   2        2   2"
MZ$(10) = "2          2              2222222222   2"
MZ$(11) = "2          d                           2"
MZ$(12) = "2        kk22222222222222222222222222d22"
MZ$(13) = "2222d222r222  n 21n                    2"
MZ$(14) = "2kk   2n  _     21n          __2__   kk2"
MZ$(15) = "2     2    n   _2111111122222222       2"
MZ$(16) = "2     2 n   _   222222222      2NN   RR2"
MZ$(17) = "2     2_       n  2     2      222222222"
MZ$(18) = "2     2222222222222     d  *   r 0000002"
MZ$(19) = "2     2    k            2      2 0000002"
MZ$(20) = "2     d                 22222222      02"
MZ$(21) = "2     2              k  d      r  00++02"
MZ$(22) = "2     2222222222222222222      20 000002"
MZ$(23) = "2   Kk2n  n  n  n  n  k2       200000002"
MZ$(24) = "222d222 __ __ __ __ __ 2       222222222"
MZ$(25) = "2k     n  n  n  n  n   d       d       2"
MZ$(26) = "22d222222222222222222222       2     k 2"
MZ$(27) = "2  2          2        2       2       2"
MZ$(28) = "2  2  #       2 222222 222222222  ------"
MZ$(29) = "2  2     2r2222 2nnnn2            -  RR-"
MZ$(30) = "2  2     2      2____22222 2    ---    -"
MZ$(31) = "2  2222222 222222        D 22222----d---"
MZ$(32) = "2          D      11111  2             2"
MZ$(33) = "222222222222   1111MMM1  222222222222222"
MZ$(34) = "2K t      2    1++++++D    2    T    tK2"
MZ$(35) = "2 T T  T     B 1MMM1111 b         t    2"
MZ$(36) = "2    t    22   11111       2   T   T   2"
MZ$(37) = "2  T   T   222         22222T      T   2"
MZ$(38) = "2t    T  t T 22222     2kk   t   t     2"
MZ$(39) = "2  T     T   kkkk2l   L2kkT    t     T 2"
MZ$(40) = "2222222222222222222222222222222222222222"

END SUB

SUB MAZE7 (MZ$())
 MZ$(1) = "1111111111111111111111111111111111111111"
 MZ$(2) = "1N  T     T    t1     1  VVV        LM+1"
 MZ$(3) = "1=T  NT t   tM  1 1+1 1  111111111111111"
 MZ$(4) = "11111111111111t 1 1+1 1  VVV        lM+1"
 MZ$(5) = "1  nnNMMNnn  1  1 1M1 1  111111111111111"
 MZ$(6) = "1 1111111111 1  1 111 1  111111111111111"
 MZ$(7) = "1 VnnNMMNnnV r  1     1  111111111111111"
 MZ$(8) = "1 1111111111 1  111 111   t T   t      1"
 MZ$(9) = "1  nnNMMNnn  1          t     T   T  t 1"
MZ$(10) = "222222222222222222222222222222222222D222"
MZ$(11) = "2N9                        9         2K2"
MZ$(12) = "2  9 99  9 9 99999 9999 9999  99999992 2"
MZ$(13) = "29    n9           9                 5 2"
MZ$(14) = "2   9  9  99999999 9 9999999999 9 9  2 5"
MZ$(15) = "2 9       M    _ 9 9 9          9 9  5 2"
MZ$(16) = "5=   9      __  n9 9 9 99999999 9 9  5 2"
MZ$(17) = "59 9   =9999999999 9 9          9 9  2 5"
MZ$(18) = "2  n  9 9          9 999d999999 9 9  2 2"
MZ$(19) = "2n  9_  9 9999999999 9nnnnnnn9  9    2 2"
MZ$(20) = "29      9            9NNNNNNN9 9999  5 5"
MZ$(21) = "2N   99N99999999999999MMMMMMM9  9k99 5 5"
MZ$(22) = "59+99NM9    a     9  9999999999 9    2 2"
MZ$(23) = "2 9   A  9    9                 999992 2"
MZ$(24) = "2                2252222252522A   2522 2"
MZ$(25) = "2a  99 A a  999  52 _ _ _ _ VV    VV 2 5"
MZ$(26) = "29  99      999  22 _ _ _ _ 25    22 2 2"
MZ$(27) = "5       9 A 999  52 _ _ _ _ 22    22 5 5"
MZ$(28) = "5R  A           a25 _ _ _ _ 52    52   2"
MZ$(29) = "225252  2252522255225222555222    255252"
MZ$(30) = "Tt   T    t T t  TTTTTTTTTTTTT         t"
MZ$(31) = "T  t   T        TT                     t"
MZ$(32) = "tT   T   T T T TTT  TTT  TtTTTttTTtTTT t"
MZ$(33) = "t  T   t t      MT    T  T       +     T"
MZ$(34) = "TTtTTtTttTTt TTt TTtt T++t T t T T t T t"
MZ$(35) = "T+           t      T tMMTM           +T"
MZ$(36) = "tT T T T T   TTtTT  T TMMTT t T t T T TT"
MZ$(37) = "TM  T    ++T T      t T++TM            t"
MZ$(38) = "T     t  T   T TTtTtT t  t T t T t+T T t"
MZ$(39) = "tB t      MT T        T  TM           bT"
MZ$(40) = "TTtTtTTtTtTtTTtTtTttTTTTTtTTTtTTTTtTTtTT"

END SUB

SUB MAZE8 (MZ$())
 MZ$(1) = "1111111111111111111111111111111GGGGGGGGG"
 MZ$(2) = "1                           k1    nGGG_G"
 MZ$(3) = "1         11111111111111111111 G G     G"
 MZ$(4) = "1    l                         9 G  G9 G"
 MZ$(5) = "1         11111111111111111111 G G  G_ G"
 MZ$(6) = "1K        1                    Gn_9  n9G"
 MZ$(7) = "11111111111 1111111111111111111GGGGGGGGG"
 MZ$(8) = "2252522222      252252255222255225252R 2"
 MZ$(9) = "5nnn___  5      2WWWWWWW2M2+   +5WWW22 2"
MZ$(10) = "2225255  d      222525WW5 2 A+a 2WWW5  5"
MZ$(11) = "5n n n n 2      5==N      5+    2WWW2 52"
MZ$(12) = "2A=a=A=a=2      2555D2252222222r55222  5"
MZ$(13) = "2252225552                          22 2"
MZ$(14) = "5                                 5    5"
MZ$(15) = "22252225 5522222252222222252225222555222"
MZ$(16) = "T     T              +            t    t"
MZ$(17) = "t      b  B   T     t  T      T      T t"
MZ$(18) = "T  t                      T M          T"
MZ$(19) = "T   M            T                     t"
MZ$(20) = "t       T     t      T     t     T     T"
MZ$(21) = "T   T                         *        t"
MZ$(22) = "T          T           T           T   T"
MZ$(23) = "t T   t    +    T M            t       T"
MZ$(24) = "TTTT TTttTTtTTT ttTtTT TttTTttt TTTt TtT"
MZ$(25) = "S          s      +       S      S     S"
MZ$(26) = "s  s  +              s       S         s"
MZ$(27) = "S     s       S                M     S S"
MZ$(28) = "S                   #                  S"
MZ$(29) = "s S      S       S        S    s       s"
MZ$(30) = "s    S         +                   S   S"
MZ$(31) = "SSS SSsSSsSSSssssSSSSSS SSSSssssSsSSSssS"
MZ$(32) = "8 8 8            =+NMn6 60   =N0006N77+7"
MZ$(33) = "8 8 8 8_8_8_8 8  Mn=_+6 60  0N=0006N77M7"
MZ$(34) = "8 8 8  _ _ _  8  666666 60  6666666N77+7"
MZ$(35) = "8     7_7_7_7 8  6          60         7"
MZ$(36) = "8      _ _ _  8  6  6666666660  7NN7 777"
MZ$(37) = "8     6_6_6_6 8  6  6           7NN7 MM7"
MZ$(38) = "888888888888888  6  6 66666 67777777 777"
MZ$(39) = "8Lnnnnnnnnnnnnn  6              7++++++7"
MZ$(40) = "7767668876886878866666666666677777777777"

END SUB


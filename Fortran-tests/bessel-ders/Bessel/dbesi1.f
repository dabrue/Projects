*DECK DBESI1
      DOUBLE PRECISION FUNCTION DBESI1 (X)
C***BEGIN PROLOGUE  DBESI1
C***PURPOSE  Compute the modified (hyperbolic) Bessel function of the
C            first kind of order one.
C***LIBRARY   SLATEC (FNLIB)
C***CATEGORY  C10B1
C***TYPE      DOUBLE PRECISION (BESI1-S, DBESI1-D)
C***KEYWORDS  FIRST KIND, FNLIB, HYPERBOLIC BESSEL FUNCTION,
C             MODIFIED BESSEL FUNCTION, ORDER ONE, SPECIAL FUNCTIONS
C***AUTHOR  Fullerton, W., (LANL)
C***DESCRIPTION
C
C DBESI1(X) calculates the double precision modified (hyperbolic)
C Bessel function of the first kind of order one and double precision
C argument X.
C
C Series for BI1        on the interval  0.          to  9.00000E+00
C                                        with weighted error   1.44E-32
C                                         log weighted error  31.84
C                               significant figures required  31.45
C                                    decimal places required  32.46
C
C***REFERENCES  (NONE)
C***ROUTINES CALLED  D1MACH, DBSI1E, DCSEVL, INITDS, ZErMsg
C***REVISION HISTORY  (YYMMDD)
C   770701  DATE WRITTEN
C   890531  Changed all specific intrinsics to generic.  (WRB)
C   890531  REVISION DATE from Version 3.2
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   900315  CALLs to XERROR changed to CALLs to ZErMsg.  (THJ)
C***END PROLOGUE  DBESI1
      DOUBLE PRECISION X, BI1CS(17), XMAX, XMIN, XSML, Y, D1MACH,
     1  DCSEVL, DBSI1E
      LOGICAL FIRST
      SAVE BI1CS, NTI1, XMIN, XSML, XMAX, FIRST
      DATA BI1CS(  1) / -.1971713261 0998597316 1385032181 49 D-2     /
      DATA BI1CS(  2) / +.4073488766 7546480608 1553936520 14 D+0     /
      DATA BI1CS(  3) / +.3483899429 9959455866 2450377837 87 D-1     /
      DATA BI1CS(  4) / +.1545394556 3001236038 5984010584 89 D-2     /
      DATA BI1CS(  5) / +.4188852109 8377784129 4588320041 20 D-4     /
      DATA BI1CS(  6) / +.7649026764 8362114741 9597039660 69 D-6     /
      DATA BI1CS(  7) / +.1004249392 4741178689 1798080372 38 D-7     /
      DATA BI1CS(  8) / +.9932207791 9238106481 3712980548 63 D-10    /
      DATA BI1CS(  9) / +.7663801791 8447637275 2001716813 49 D-12    /
      DATA BI1CS( 10) / +.4741418923 8167394980 3880919481 60 D-14    /
      DATA BI1CS( 11) / +.2404114404 0745181799 8631720320 00 D-16    /
      DATA BI1CS( 12) / +.1017150500 7093713649 1211007999 99 D-18    /
      DATA BI1CS( 13) / +.3645093565 7866949458 4917333333 33 D-21    /
      DATA BI1CS( 14) / +.1120574950 2562039344 8106666666 66 D-23    /
      DATA BI1CS( 15) / +.2987544193 4468088832 0000000000 00 D-26    /
      DATA BI1CS( 16) / +.6973231093 9194709333 3333333333 33 D-29    /
      DATA BI1CS( 17) / +.1436794822 0620800000 0000000000 00 D-31    /
      DATA FIRST /.TRUE./
C***FIRST EXECUTABLE STATEMENT  DBESI1
      IF (FIRST) THEN
         NTI1 = INITDS (BI1CS, 17, 0.1*REAL(D1MACH(3)))
         XMIN = 2.0D0*D1MACH(1)
         XSML = SQRT(4.5D0*D1MACH(3))
         XMAX = LOG (D1MACH(2))
      ENDIF
      FIRST = .FALSE.
C
      Y = ABS(X)
      IF (Y.GT.3.0D0) GO TO 20
C
      DBESI1 = 0.D0
      IF (Y.EQ.0.D0)  RETURN
C
      IF (Y .LE. XMIN) CALL ZErMsg ('SLATEC', 'DBESI1',
     +   'ABS(X) SO SMALL I1 UNDERFLOWS', 1, 1)
      IF (Y.GT.XMIN) DBESI1 = 0.5D0*X
      IF (Y.GT.XSML) DBESI1 = X*(0.875D0 + DCSEVL (Y*Y/4.5D0-1.D0,
     1  BI1CS, NTI1))
      RETURN
C
 20   IF (Y .GT. XMAX) CALL ZErMsg ('SLATEC', 'DBESI1',
     +   'ABS(X) SO BIG I1 OVERFLOWS', 2, 2)
C
      DBESI1 = EXP(Y) * DBSI1E(X)
C
      RETURN
      END
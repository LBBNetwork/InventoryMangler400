     FNOTES     UF A E           K DISK
     DDUMMYSTR         S            100A
     DDUMMYNBR         S              8A
     DDUMMY            C                   CONST('Notes for Asset ')
     C     *ENTRY        PLIST
     C                   PARM                    LAUNCH            8
     C
     C                   MOVEL     LAUNCH        DUMMYNBR
     C     DUMMY         CAT       DUMMYNBR      DUMMYSTR
     C
     C                   MOVEL     '0000'        PAGENBR
     C                   MOVEL     DUMMYSTR      NOTE
     C
     C                   WRITE     NOTEREC
     C
     C                   MOVEL     *ON           *INLR
     C                   RETURN

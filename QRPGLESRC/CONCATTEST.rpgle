     DSTRING1          S              9A
     DSTRING2          S             10A
     DFINALSTR         S             10A
     DTEMPNBR          S              8A
     DSOMEDTA          S              8P 0
     C                   EVAL      SOMEDTA = 12345678
     C                   MOVEL     SOMEDTA       TEMPNBR
     C     '"'           CAT       TEMPNBR       STRING1
     C     STRING1       CAT       '"'           FINALSTR
     C     FINALSTR      DSPLY
     C                   MOVEL     *ON           *INLR
     C                   RETURN

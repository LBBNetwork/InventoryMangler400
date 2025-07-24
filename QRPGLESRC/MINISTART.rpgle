     FMINIDETAILCF   E             WORKSTN
     DDUMMYSTR         S            100A
     DDUMMYNBR         S              8A
     DALWEXIT          S              1P 0
     DASSETID          S              8P 0
     C     EDTPARM       PLIST
     C                   PARM                    CLPARM           10
     C
     C                   DOU       ALWEXIT = 1
     C                   EXFMT     MINISTART
     C
     C                   IF        INOPT = '1'
     C                   CALL      'GOBIG'
     C                   ADD       1             ALWEXIT
     C                   ELSEIF    INOPT = '2'
     C                   EXSR      GOHOME
     C                   ADD       1             ALWEXIT
     C                   ENDIF
     C                   ENDDO
     C
     C                   MOVEL     *ON           *INLR
     C                   RETURN
      *---------------------------------
     C     GOHOME        BEGSR
     C                   EXFMT     MINIMENU
     C
     C                   DOU       ALWEXIT = 1
     C                   SELECT
     C                   WHEN      INMNUOPT = '1'
     C                   CALL      'ADDNEWMINI'
     C                   WHEN      INMNUOPT = '2'
     C                   EXSR      STREDT
     C                   WHEN      INMNUOPT = '3'
     C                   EXSR      STRVIEW
     C                   WHEN      INMNUOPT = '9'
     C                   CALL      'SIGNOFF'
     C                   ENDSL
     C                   ENDDO
     C                   ENDSR
      *---------------------------------
     C     BCDLKUP       BEGSR
     C                   EXFMT     MINIBARCDE
     C
     C                   MOVE      INBARCDE      ASSETID
     C                   ENDSR
      *---------------------------------
     C     STREDT        BEGSR
     C                   EXSR      BCDLKUP
     C                   MOVE      ASSETID       CLPARM
     C                   CALL      'STRMINIEDT'  EDTPARM
     C                   ENDSR
      *---------------------------------
     C     STRVIEW       BEGSR
     C                   ENDSR

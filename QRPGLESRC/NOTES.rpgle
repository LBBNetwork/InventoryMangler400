     FNOTES     UF A E           K DISK
     FNOTESSCR  CF   E             WORKSTN
     DCURPAGENBR       S              4P 0
     DALWFWD           S              1P 0
     DNEWORUPD         S              1P 0
      *--------------------------------------------------------------------
     C*    *ENTRY        PLIST
     C*                  PARM                    LAUNCH            9
     C*-----------------------------------------------------------------------
     C                   MOVEL     1             ALWFWD
     C                   MOVEL     0             NEWORUPD
     C                   EVAL      *IN60 = *ON
     C
     C                   READ      NOTES
     C                   MOVEL     PAGENBR       CURPAGENBR
     C                   MOVEL     NOTE          INCONTENT
     C                   MOVEL     PAGENBR       OUTPAGENBR
     C
     C                   DOW       *IN03 = *OFF
     C
     C                   IF        *IN05 = *ON
     C                   EXSR      PAGEFWD
     C                   EVAL      *IN05 = *OFF
     C                   ENDIF
     C
     C                   IF        *IN08 = *ON
     C                   EXSR      PAGEBACK
     C                   EVAL      *IN08 = *OFF
     C                   ENDIF
     C
     C                   IF        *IN10 = *ON
     C                   EXSR      WRITERCD
     C                   EVAL      *IN10 = *OFF
     C                   ENDIF
     C
     C                   EXFMT     MAINADMIN
     C                   ENDDO
     C
     C                   MOVEL     *ON           *INLR
     C                   RETURN
     C*---------------------------------------------------------------------
     C     WRITERCD      BEGSR
     C                   IF        NEWORUPD = 0
     C                   EXSR      UPDRCD
     C                   ELSE
     C                   EXSR      CRTRCD
     C                   ENDIF
     C                   ENDSR
     C*---------------------------------------------------------------------
     C     UPDRCD        BEGSR
     C     CURPAGENBR    SETLL     NOTEREC
     C                   READ      NOTES
     C                   MOVEL     CURPAGENBR    PAGENBR
     C                   MOVEL     INCONTENT     NOTE
     C                   UPDATE    NOTEREC
     C
     C                   MOVEL     1             ALWFWD
     C                   EVAL      *IN60 = *ON
     C                   ENDSR
     C*---------------------------------------------------------------------
     C     CRTRCD        BEGSR
     C     CURPAGENBR    SETLL     NOTEREC
     C                   READ      NOTES
     C                   MOVEL     CURPAGENBR    PAGENBR
     C                   MOVEL     INCONTENT     NOTE
     C                   WRITE     NOTEREC
     C
     C                   MOVEL     1             ALWFWD
     C                   MOVEL     0             NEWORUPD
     C                   EVAL      *IN60 = *ON
     C                   ENDSR
     C*---------------------------------------------------------------------
     C     PAGEFWD       BEGSR
     C                   CLEAR                   INCONTENT
     C                   IF        ALWFWD = 1
     C                   ADD       1             CURPAGENBR
     C                   ENDIF
     C
     C     CURPAGENBR    CHAIN     NOTEREC                            95
     C                   IF        *IN95 = *OFF
     C                   READE     NOTES
     C                   MOVEL     PAGENBR       OUTPAGENBR
     C                   MOVEL     NOTE          INCONTENT
     C                   ELSE
     C                   MOVEL     0             ALWFWD
     C                   MOVEL     1             NEWORUPD
     C                   MOVEL     CURPAGENBR    OUTPAGENBR
     C                   EVAL      *IN60 = *OFF
     C                   ENDIF
     C                   ENDSR
     C*------------------------------------------------------------------------
     C     PAGEBACK      BEGSR
     C                   IF        CURPAGENBR = 0
     C
     C                   ELSE
     C                   SUB       1             CURPAGENBR
     C                   ENDIF
     C
     C                   CLEAR                   INCONTENT
     C                   CLEAR                   INEXTRA
     C     CURPAGENBR    CHAIN     NOTEREC                            96
     C                   READE     NOTES
     C                   MOVEL     PAGENBR       OUTPAGENBR
     C                   MOVEL     NOTE          INCONTENT
     C                   MOVEL     1             ALWFWD
     C                   MOVEL     0             NEWORUPD
     C                   EVAL      *IN60 = *ON
     C                   ENDSR
     C*------------------------------------------------------------------------
     C     CHKPARM       BEGSR
     C*                  MOVEL     LAUNCH        USERPROF
     C*                  MOVEL     EXHIBIT       EDTEXHB
     C                   ENDSR

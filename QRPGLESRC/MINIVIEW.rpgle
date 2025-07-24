     FASSETS    UF A E           K DISK
     FMINIDETAILCF   E             WORKSTN
     DASTID            S              8P 0
     DPARMSTR1         S              9A
     DPARMSTR2         S             10A
     DPARMNBR          S              8A
      *--------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    ASSETNBR          8
      *--------------------------------
     C     NOTEPARM      PLIST
     C                   PARM                    CLPARM           10
      *--------------------------------
     C                   EXSR      CHKPARM
     C
     C     ASTID         SETLL     ASSTREC
     C                   READ      ASSETS
     C
     C                   MOVE      ASSTNBR       OANBR
     C                   MOVEL     ASSTNAME      OANAME
     C                   MOVE      ASSTTYP       OATYPE
     C                   MOVE      ASSTACQT      OAATYPE
     C                   MOVEL     ASSTQTY       OAQTY
     C                   MOVE      ASSTACQ       OADATEACQ
     C                   MOVE      ASSTEMPL      OAEID
     C                   MOVE      ASSTREMB      OAREIMB
     C                   MOVEL     ASSTSN        OASN
     C*                  MOVEL     ASSTLCN       OALCN
     C
     C*                  CLOSE     ASSETS
     C
     C                   EXFMT     DETAIL
     C
     C                   DO
     C                   IF        *IN03 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C
     C                   IF        *IN05 = *ON
     C*CALL ASSTEDT WITH THIS ASSET NBR
     C                   ENDIF
     C
     C*                  IF        *IN08 = *ON
     C*PRINT THIS ASSET TO SYSTEM PTR
     C*                  ENDIF
     C
     C                   IF        *IN12 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C                   ENDDO
      *--------------------------------
     C     DIE           BEGSR
     C                   MOVEL     *ON           *INLR
     C                   RETURN
     C                   ENDSR
      *--------------------------------
     C     CHKPARM       BEGSR
     C                   MOVEL     ASSETNBR      ASTID
     C                   ENDSR

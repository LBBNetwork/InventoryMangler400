     FASSETS    UF A E           K DISK
     FOVERVIEW  CF   E             WORKSTN
     F                                     SFILE(OVRSFL:RRN)
     DRRN              S              8P 0
     DASST             S              8P 0
      *--------------------------------
     C     PARMLIST      PLIST
     C                   PARM                    AID               8
      *--------------------------------
     C                   MOVEL     *OFF          *IN50
     C                   WRITE     OVRCTL
     C
     C                   EVAL      RRN = *ZERO
     C
     C                   MOVEL     *ON           *IN50
     C
     C                   READ      ASSETS                                 90
     C
     C                   DOU       %EOF(ASSETS)
     C                   EVAL      RRN = RRN + 1
     C                   MOVEL     ASSTNBR       SFLASSTNBR
     C                   MOVEL     ASSTNAME      SFLNAME
     C                   MOVEL     ASSTTYP       SFLTYPE
     C                   MOVEL     ASSTSTS       SFLSTS
     C                   MOVEL     ASSTMT        SFLMT
     C                   MOVEL     ASSTM         SFLM
     C                   MOVEL     ASSTSN        SFLSN
     C
     C                   WRITE     OVRSFL
     C
     C                   READ      ASSETS                                 90
     C                   ENDDO
     C
     C*                  CLOSE     ASSETS
     C
     C                   EXFMT     OVRCTL
     C
     C                   READC     OVRSFL
     C
     C                   SELECT
     C                   WHEN      SFLOPT = '1'
     C                   EXSR      VIEWDTL
     C                   ENDSL
     C
     C                   MOVEL     *ON           *INLR
     C                   RETURN
      *--------------------------------
     C     VIEWDTL       BEGSR
     C                   MOVE      SFLASSTNBR    ASST
     C     ASST          CHAIN     ASSETS                             91
     C                   IF        *IN91 = *OFF
     C                   MOVE      ASSTNBR       AID
     C*                  MOVEL     1             AID
     C                   CLOSE     ASSETS
     C                   CALL      'ASSETVIEW'   PARMLIST
     C                   ENDIF
     C                   ENDSR

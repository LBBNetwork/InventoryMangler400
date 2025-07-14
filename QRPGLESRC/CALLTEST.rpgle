     DASST             S              8P 0
      *--------------------------------
     C     PARMLIST      PLIST
     C                   PARM                    AID               8
     C                   EXSR      VIEWDTL
     C                   MOVEL     *ON           *INLR
     C                   RETURN
      *--------------------------------
     C     VIEWDTL       BEGSR
     C                   MOVEL     1             ASST
     C                   MOVEL     1             AID
     C                   CALL      'ASSETVIEW'   PARMLIST
     C                   ENDSR

     FASSETS    UF A E           K DISK
     FINVDETAIL CF   E             WORKSTN
     DASTID            S              8P 0
      *--------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    ASSETNBR          8
      *--------------------------------
     C                   EXSR      CHKPARM
     C
     C     ASTID         SETLL     ASSTREC
     C                   READ      ASSETS
     C
     C                   MOVEL     ASSTNBR       OANBR
     C                   MOVEL     ASSTVAL       OAVALUE
     C                   MOVEL     ASSTNAME      OANAME
     C                   MOVEL     ASSTDESC      OADESC
     C                   MOVEL     ASSTTYP       OATYPE
     C                   MOVEL     ASSTSTS       OASTS
     C                   MOVEL     ASSTFUNC      OAFUNC
     C                   MOVEL     ASSTACQT      OAATYPE
     C                   MOVEL     ASSTQTY       OAQTY
     C                   MOVEL     ASSTDONOR     OADONOR
     C                   MOVEL     ASSTACQ       OADATEACQ
     C                   MOVEL     ASSTDISP      OADATEDIS
     C                   MOVEL     ASSTEMPL      OAEID
     C                   MOVEL     ASSTREMB      OAREIMB
     C                   MOVEL     ASSTTAX       OATAX
     C                   MOVEL     ASSTMT        OAMT
     C                   MOVEL     ASSTM         OAM
     C                   MOVEL     ASSTSN        OASN
     C
     C                   EXFMT     DETAIL
     C
     C                   MOVEL     *ON           *INLR
     C                   RETURN
      *--------------------------------
     C     CHKPARM       BEGSR
     C                   MOVEL     ASSETNBR      ASTID
     C                   ENDSR

     FASSETS    UF A E           K DISK
     FINVDETAIL CF   E             WORKSTN
     DASTID            S              8P 0
     DALWEXT           S              1P 0
     DERRTEST          C                   CONST('this is only a test')
     DERRNAME          C                   CONST('Must provide asset name')
     DERRTYPE          C                   CONST('Invalid Asset Type')
     DERRSTS           C                   CONST('Status must be (A)ctive, +
     D                                            on (L)oan, or (D)isposed')
     DERRFUNC          C                   CONST('Func must be (W)orking, +
     D                                            (B)roken, (P)arts, (N)A')
     DERRACQT          C                   CONST('Acq Type must be (D)onate,+
     D                                            (P)urchase, or (L)oan')
     DERRTAX           C                   CONST('Tax Receipt must be Y or N')
     DERREMPL          C                   CONST('Must provide initials of +
     D                                            acquiring employee')
     DERRREMB          C                   CONST('Must specify if employee +
     D                                            was reimbursed')
     DERRLOC           C                   CONST('Must specify a location')
     DERRMULTI         C                   CONST('Multiple errors found, +
     D                                            correct fields')
      *--------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    ASSETNBR          8
      *--------------------------------
     C                   EXSR      CHKPARM
     C
     C                   MOVEL     0             ALWEXT
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
     C                   MOVEL     ERRTEST       ERRORLINE
     C                   EXFMT     DETAILEDT
     C
     C                   DOW       ALWEXT = *ZERO
     C                   EXSR      VALIDATE
     C                   EXFMT     DETAILEDT
     C
     C                   IF        ALWEXT = 1
     C*                  MOVEL     OANBR         ASSTNBR
     C                   MOVEL     OAVALUE       ASSTVAL
     C                   MOVEL     OANAME        ASSTNAME
     C                   MOVEL     OADESC        ASSTDESC
     C                   MOVEL     OATYPE        ASSTTYP
     C                   MOVEL     OASTS         ASSTSTS
     C                   MOVEL     OAFUNC        ASSTFUNC
     C                   MOVEL     OAATYPE       ASSTACQT
     C                   MOVEL     OAQTY         ASSTQTY
     C                   MOVEL     OADONOR       ASSTDONOR
     C*                  MOVEL     OADATEACQ     ASSTACQ
     C                   MOVEL     OADATEDIS     ASSTDISP
     C                   MOVEL     OAEID         ASSTEMPL
     C                   MOVEL     OAREIMB       ASSTREMB
     C                   MOVEL     OATAX         ASSTTAX
     C                   MOVEL     OAMT          ASSTMT
     C                   MOVEL     OAM           ASSTM
     C                   MOVEL     OASN          ASSTSN
     C
     C                   UPDATE    ASSTREC
     C                   MOVEL     *ON           *INLR
     C                   RETURN
     C                   ENDIF
     C                   ENDDO
      *--------------------------------
     C     VALIDATE      BEGSR
     C                   IF        OANAME = *BLANK
     C                   MOVEL     *ON           *IN70
     C                   MOVEL     ERRNAME       ERRORLINE
     C                   ELSE
     C                   EVAL      ALWEXT = 1
     C                   ENDIF
     C                   ENDSR
      *--------------------------------
     C     CHKPARM       BEGSR
     C                   MOVEL     ASSETNBR      ASTID
     C                   ENDSR

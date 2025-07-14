     FASSETS    UF A E           K DISK
     FINVDETAIL CF   E             WORKSTN
     DASTID            S              8P 0
     DALWSAV           S              1P 0
     DNEWOREDT         S              1P 0
     DTAXNBR           S              8P 0
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
     DERRLCN           C                   CONST('Must specify a location')
     DERRSAVED         C                   CONST('Asset record was saved')
     DERRMULTI         C                   CONST('Multiple errors found, +
     D                                            correct fields')
     DERRNEW           C                   CONST('Creating new asset')
      *--------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    ASSETNBR          8
     C                   PARM                    EMPID             3
     C                   PARM                    TAXABLE           1
      *--------------------------------
     C                   EXSR      CHKPARM
     C
     C                   MOVEL     0             ALWSAV
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
     C                   EXFMT     DETAILEDT
     C
     C                   DO
     C                   IF        *IN03 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C
     C                   IF        *IN05 = *ON
     C                   EXSR      VALIDATE
     C                   IF        ALWSAV = 1
     C                   EXSR      WRITERCD
     C                   MOVEL     ERRSAVED      ERRORLINE
     C                   ENDIF
     C                   EXFMT     DETAILEDT
     C                   ENDIF
     C
     C                   IF        *IN12 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C                   ENDDO
      *--------------------------------
     C     LOADASST      BEGSR
     C                   ENDSR
      *--------------------------------
     C     CRTASST       BEGSR
     C                   MOVEL     ERRNEW        ERRORLINE
     C                   ENDSR
      *--------------------------------
     C     TAXLOOP       BEGSR
     C                   ENDSR
      *--------------------------------
     C     VALIDATE      BEGSR
     C                   IF        OANAME = *BLANK
     C                   MOVEL     *ON           *IN70
     C                   MOVEL     ERRNAME       ERRORLINE
     C                   ELSE
     C                   EVAL      ALWSAV = 1
     C                   ENDIF
     C                   ENDSR
      *--------------------------------
     C     WRITERCD      BEGSR
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
     C                   MOVEL     OALCN         ASSTLCN
     C
     C                   UPDATE    ASSTREC
     C                   ENDSR
      *--------------------------------
     C     DIE           BEGSR
     C                   MOVEL     *ON           *INLR
     C                   RETURN
     C                   ENDSR
      *--------------------------------
     C     CHKPARM       BEGSR
     C                   IF        ASSETNBR = 'NEW'
     C                   EXSR      CRTASST
     C                   ENDIF
     C                   MOVEL     ASSETNBR      ASTID
     C                   ENDSR

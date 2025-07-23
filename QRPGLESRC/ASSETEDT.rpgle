     FASSETS    UF A E           K DISK
     FTYPETBL   IF   E           K DISK
     FINVDETAIL CF   E             WORKSTN
     DASTID            S              8P 0
     DALWSAV           S              2P 0
     DNEWOREDT         S              1P 0
     DTAXNBR           S              8P 0
     DNEWQTY           S              4P 0
     DNOTENBR          S              8A
     DEMPLNAM          S              3A
     DCURDATE          S               D
     DDUMMYDATE        C                   CONST('0001-01-01')
     DERRTEST          C                   CONST('Validty check error')
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
     DERRMULTI         C                   CONST('Errors found, +
     D                                            correct fields            ')
     DERRQTY           C                   CONST('Invalid quantity specified')
     DERRDATE          C                   CONST('Invalid date specified')
     DERRNEW           C                   CONST('Creating new asset, fill +
     D                                            highlighted fields')
      *--------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    ASSETNBR          8
     C                   PARM                    EMPID             3
      *--------------------------------
     C     NOTEPARM      PLIST
     C                   PARM                    CLPARM            8
      *--------------------------------
      *PERFORM PROGRAM SETUP HERE
     C                   EVAL      ALWSAV = 0
     C                   EVAL      CURDATE = %DATE
      *--------------------------------
      *BEGIN MAIN PROGRAM HERE
     C                   EXSR      CHKPARM
     C
     C                   DOU       ALWSAV = 1
     C                   EXFMT     DETAILEDT
     C
     C                   IF        *IN03 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C
     C                   IF        *IN05 = *ON
     C                   EXSR      VALIDATE
     C                   IF        ALWSAV = 1
     C                   EXSR      WRITERCD
     C                   MOVEL     ERRSAVED      ERRORLINE
     C                   EXSR      SETUPNEW
     C                   ENDIF
     C                   ENDIF
     C
     C                   IF        *IN12 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C                   ENDDO
     C
     C                   EXSR      DIE
      *--------------------------------
     C     SETUPEDT      BEGSR
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
     C                   ENDSR
      *--------------------------------
     C     SETUPNEW      BEGSR
     C                   MOVEL     EMPLNAM       OAEID
     C
     C     *LOVAL        SETLL     ASSETS
     C                   READ      ASSETS
     C
     C                   DOU       %EOF(ASSETS)
     C                   READ      ASSETS
     C                   ENDDO
     C                   MOVEL     ASSTNBR       ASTID
     C                   ADD       1             ASTID
     C                   MOVEL     ASTID         OANBR
     C
     C                   ADD       1             NEWQTY
     C                   MOVEL     NEWQTY        OAQTY
     C
     C                   MOVEL     CURDATE       OADATEACQ
     C                   MOVEL     DUMMYDATE     OADATEDIS
     C
     C                   EVAL      *IN70 = *ON
     C                   EVAL      *IN71 = *ON
     C                   EVAL      *IN72 = *ON
     C                   EVAL      *IN73 = *ON
     C                   EVAL      *IN74 = *ON
     C                   ENDSR
      *--------------------------------
     C     VALIDATE      BEGSR
     C                   IF        OANAME = *BLANK
     C                   MOVEL     ERRNAME       ERRORLINE
     C                   ELSE
     C                   EVAL      *IN70 = *OFF
     C                   ADD       1             ALWSAV
     C                   ENDIF
     C
     C                   IF        OAQTY = *BLANK
     C                   MOVEL     ERRQTY        ERRORLINE
     C                   ELSE
     C                   ADD       1             ALWSAV
     C                   ENDIF
     C
     C                   ADD       1             ALWSAV
     C
     C                   IF        OATYPE = *BLANK
     C                   MOVEL     ERRTYPE       ERRORLINE
     C                   ELSE
     C     OATYPE        CHAIN     TYPEREC
     C                   IF        %FOUND()
     C                   EVAL      *IN71 = *OFF
     C                   ADD       1             ALWSAV
     C                   ELSE
     C                   MOVEL     ERRTYPE       ERRORLINE
     C                   ENDIF
     C                   ENDIF
     C
     C                   SELECT
     C                   WHEN      OAATYPE = *BLANK
     C                   MOVEL     ERRACQT       ERRORLINE
     C                   WHEN      OAATYPE = 'D'
     C                   EVAL      *IN72 = *OFF
     C                   ADD       1             ALWSAV
     C                   WHEN      OAATYPE = 'P'
     C                   EVAL      *IN72 = *OFF
     C                   ADD       1             ALWSAV
     C                   WHEN      OAATYPE = 'L'
     C                   EVAL      *IN72 = *OFF
     C                   ADD       1             ALWSAV
     C                   OTHER
     C                   MOVEL     ERRACQT       ERRORLINE
     C                   ENDSL
     C
     C                   IF        OADATEACQ = *BLANK
     C                   MOVEL     ERRDATE       ERRORLINE
     C                   ELSE
     C                   ADD       1             ALWSAV
     C                   ENDIF
     C
     C                   IF        OALCN = *BLANK
     C                   MOVEL     ERRTEST       ERRORLINE
     C                   ELSE
     C                   EVAL      *IN73 = *OFF
     C                   ADD       1             ALWSAV
     C                   ENDIF
     C
     C                   IF        OAREIMB = *BLANK
     C                   MOVEL     ERRREMB       ERRORLINE
     C                   ELSEIF    OAREIMB = 'Y'
     C                   EVAL      *IN74 = *OFF
     C                   ADD       1             ALWSAV
     C                   EVAL      *IN74 = *OFF
     C                   ELSEIF    OAREIMB = 'N'
     C                   ADD       1             ALWSAV
     C                   ELSE
     C                   MOVEL     ERRREMB       ERRORLINE
     C                   ENDIF
     C
     C                   IF        ALWSAV = 8
     C                   EXSR      WRITERCD
     C                   EVAL      ALWSAV = 0
     C                   ELSE
     C                   MOVEL     ERRMULTI      ERRORLINE
     C                   EVAL      *IN05 = *OFF
     C                   EVAL      ALWSAV = 0
     C                   ENDIF
     C                   ENDSR
      *--------------------------------
     C     WRITERCD      BEGSR
     C                   MOVEL     ASTID         ASSTNBR
     C                   MOVEL     OAVALUE       ASSTVAL
     C                   MOVEL     OANAME        ASSTNAME
     C                   MOVEL     OADESC        ASSTDESC
     C                   MOVEL     OATYPE        ASSTTYP
     C                   MOVEL     OASTS         ASSTSTS
     C                   MOVEL     OAFUNC        ASSTFUNC
     C                   MOVEL     OAATYPE       ASSTACQT
     C                   MOVEL     OAQTY         ASSTQTY
     C                   MOVEL     OADONOR       ASSTDONOR
     C                   MOVEL     OADATEACQ     ASSTACQ
     C                   MOVEL     OADATEDIS     ASSTDISP
     C                   MOVEL     OAREIMB       ASSTREMB
     C                   MOVEL     OATAX         ASSTTAX
     C                   MOVEL     OAMT          ASSTMT
     C                   MOVEL     OAM           ASSTM
     C                   MOVEL     OASN          ASSTSN
     C                   MOVEL     OALCN         ASSTLCN
     C
     C                   IF        NEWOREDT = 0
     C                   UPDATE    ASSTREC
     C                   ELSE
     C                   MOVEL     EMPLNAM       ASSTEMPL
     C                   WRITE     ASSTREC
     C
     C                   MOVEL     OANBR         NOTENBR
     C                   MOVEL     NOTENBR       CLPARM
     C                   CALL      'CRTNOTES'    NOTEPARM
     C                   ENDIF
     C
     C                   EXSR      DIE
     C                   ENDSR
      *--------------------------------
     C     DIE           BEGSR
     C                   MOVEL     *ON           *INLR
     C                   RETURN
     C                   ENDSR
      *--------------------------------
     C     CHKPARM       BEGSR
     C                   MOVEL     EMPID         EMPLNAM
     C
     C                   IF        ASSETNBR = 'NEW'
     C                   MOVEL     1             NEWOREDT
     C                   MOVEL     ERRNEW        ERRORLINE
     C                   EXSR      SETUPNEW
     C                   ELSE
     C                   MOVEL     0             NEWOREDT
     C                   MOVEL     ASSETNBR      ASTID
     C                   EXSR      SETUPEDT
     C                   ENDIF
     C                   ENDSR

     FTAXRCPT   UF A E           K DISK
     FASSETS    UF A E           K DISK
     FTAXSCR    CF   E             WORKSTN
     DSTRADD           S              1P 0
     DPHYSDON          S              1P 0
     DLSTTAXID         S              8P 0
     DNEWTAXID         S              8P 0
     DSTRASSET         S              8P 0
     DENDASSET         S              8P 0
     DALWEXIT          S              1P 0
     DCURDATE          S               D
     DERRCHECK         C                   CONST('Check highlighted')
      *----------------------------------------------------------
      *This program handles the donor specific things for the CCC
      *
      *Program starts with two launch parameters, STRASTID and ENDASTID
      *When run it will attach every asset ID from STR to END to the
      *specific donor ID in the master ASSETS file
      *
      *The DONOR file will be a keyed index that just houses the donor
      *information.
      *The key will be the DONORID, a numeric ID matching the same length
      *as ASSETID in ASSETS
      *
      *The DONOR file should also have extra fields for one-time non-tang
      *ible donations; a month's free rent, $1,000 cash donation, etc
      *----------------------------------------------------------
     C                   EVAL      CURDATE = %DATE
     C
     C                   EXSR      GETLSTRCPT
     C
     C                   DOU       STRADD = 1
     C                   EXFMT     TAXSTART
     C
     C                   IF        *IN01 = *ON
     C                   SETON                                        71
     C                   EVAL      STRADD = 1
     C                   EVAL      PHYSDON = 1
     C                   ELSEIF    *IN02 = *ON
     C                   SETON                                        70
     C                   EVAL      STRADD = 1
     C                   EVAL      PHYSDON = 0
     C                   ELSEIF    *IN12 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C                   ENDDO
     C
     C                   EXSR      ADDDATA
      *----------------------------------------------------
     C     ADDDATA       BEGSR
     C                   MOVEL     CURDATE       INDATE
     C                   DOU       ALWEXIT = 3
     C                   EXFMT     TAXADD
     C
     C                   IF        *IN05 = *ON
     C                   EXSR      VALIDATE
     C                   IF        ALWEXIT = 3
     C                   EXSR      WRITERCD
     C                   ELSE
     C                   EVAL      ALWEXIT = 0
     C                   ENDIF
     C                   ELSEIF    *IN06 = *ON
     C                   EXSR      VALIDATE
     C                   EXSR      WRITERCD
     C*                  EXSR      PRTRCPT
     C                   ELSEIF    *IN12 = *ON
     C                   EXSR      DIE
     C                   ENDIF
     C
     C                   EVAL      *IN05 = *OFF
     C                   ENDDO
     C
     C                   ENDSR
      *----------------------------------------------------------
     C     GETLSTRCPT    BEGSR
     C     *LOVAL        SETLL     TAXRCPT
     C                   READ      TAXRCPT
     C
     C                   DOU       %EOF(TAXRCPT)
     C                   READ      TAXRCPT
     C                   ENDDO
     C
     C                   MOVEL     TAXNBR        LSTTAXID
     C                   MOVEL     TAXNBR        NEWTAXID
     C                   ADD       1             NEWTAXID
     C                   MOVEL     NEWTAXID      OUTRNBR
     C                   ENDSR
      *----------------------------------------------------------
     C     VALIDATE      BEGSR
     C                   IF        INDNAME = *BLANKS
     C                   EVAL      *IN80 = *ON
     C                   MOVEL     ERRCHECK      ERRLINE
     C                   ELSE
     C                   ADD       1             ALWEXIT
     C                   ENDIF
     C
     C                   SELECT
     C                   WHEN      PHYSDON = 1
     C                   IF        INSASSET = *BLANKS
     C                   EVAL      *IN81 = *ON
     C                   MOVEL     ERRCHECK      ERRLINE
     C                   ELSE
     C                   ADD       1             ALWEXIT
     C                   ENDIF
     C
     C                   IF        INEASSET = *BLANKS
     C                   EVAL      *IN82 = *ON
     C                   MOVEL     ERRCHECK      ERRLINE
     C                   ELSE
     C                   ADD       1             ALWEXIT
     C                   ENDIF
     C
     C                   WHEN      PHYSDON = 0
     C                   IF        INNTDESC = *BLANKS
     C                   EVAL      *IN83 = *ON
     C                   MOVEL     ERRCHECK      ERRLINE
     C                   ELSE
     C                   ADD       2             ALWEXIT
     C                   ENDIF
     C
     C                   ENDSL
     C
     C                   ENDSR
      *---------------------------------------------------------
     C     WRITERCD      BEGSR
     C                   MOVE      NEWTAXID      TAXNBR
     C                   MOVEL     INDNAME       TAXNAME
     C                   MOVEL     INDADDR       TAXSTREET
     C                   MOVEL     INDCITY       TAXCITY
     C                   MOVEL     INDST         TAXSTATE
     C                   MOVEL     INDZIP4       TAXZIP
     C                   MOVEL     INDTEL        TAXTEL
     C
     C                   IF        PHYSDON = 1
     C                   MOVEL     'NA'          TAXNTITM
     C                   MOVEL     0             TAXNTVALU
     C
     C                   MOVE      INSASSET      STRASSET
     C                   MOVE      INEASSET      ENDASSET
     C
     C                   SUB       1             STRASSET
     C     STRASSET      CHAIN     ASSTREC
     C                   IF        STRASSET = ENDASSET
     C                   MOVEL     NEWTAXID      ASSTTID
     C                   MOVEL     'Y'           ASSTTAX
     C                   MOVEL     INDNAME       ASSTDONOR
     C                   UPDATE    ASSTREC
     C                   ELSE
     C                   DOU       STRASSET = ENDASSET
     C                   MOVEL     NEWTAXID      ASSTTID
     C                   MOVEL     'Y'           ASSTTAX
     C                   MOVEL     INDNAME       ASSTDONOR
     C                   UPDATE    ASSTREC
     C                   ADD       1             STRASSET
     C                   READ      ASSETS
     C                   ENDDO
     C                   ENDIF
     C
     C                   ELSE
     C                   MOVEL     INNTDESC      TAXNTITM
     C                   MOVE      INNTVALUE     TAXNTVALU
     C                   ENDIF
     C
     C                   WRITE     TAXREC
     C*                  CLOSE     TAXRCPT

     C                   ENDSR
      *----------------------------------------------------------
     C     DIE           BEGSR
     C                   MOVEL     *ON           *INLR
     C                   RETURN
     C                   ENDSR

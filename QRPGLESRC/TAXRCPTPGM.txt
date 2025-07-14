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

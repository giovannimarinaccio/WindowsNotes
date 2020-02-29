# Retrieve ProductKey

## Get OEM ProductKey from BIOS

    # cmd
    wmic path softwarelicensingservice get OA3xOriginalProductKey

NOTE: if new key is installed it will still show the one from BIOS

## Current License details (via slmgr.vbs)

    # cmd
    slmgr /dlv    # License details
    slmgr /xpr    # License expiration
 
## Nirsoft ProduKey

[ProduKey Page](https://www.nirsoft.net/utils/product_cd_key_viewer.html)  
[Download ProduKey for x64](https://www.nirsoft.net/utils/produkey-x64.zip)  

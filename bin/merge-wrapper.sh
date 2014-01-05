#!/bin/sh
# merge is called by git with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode
/home/dmwp37/bin/bdiff %1 %2 %3 %4 /title1="local" /title2="remote" /title3="base" /title4="$PWD/$MERGED" 

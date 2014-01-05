#!/bin/sh
# diff is called by git with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode
echo version compare for $5, mode: $7
~/bin/bdiff `cygpath -wp $2` `cygpath -wp $5` | cat

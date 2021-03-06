#!/bin/sh
rm -f cscope.files cscope.in.out cscope.po.out cscope.out tags
find -path '.*/.*' -prune , -type f -name "*.h" -o -name "*.c" -o -name "*.cpp" > cscope.files
cscope -bkq -i cscope.files
ctags -R --fields=+lS

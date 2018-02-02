#!/bin/bash

run_exit=0

for scheme_file in $(find ./* -type f -name '*.scm');
do
   echo "$scheme_file test..."
   mit-scheme < $scheme_file 1>/dev/null 2>&1
   ret_code=$?
   if [ $ret_code != 0 ]; then
        echo ""
        echo "run $scheme_file failed!"
        echo ""
       run_exit=$(($run_exit + 1))
   fi
done
echo $run_exit
exit $run_exit
#!/bin/bash
echo $1
taskset -c 2 q "/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/Qscript.q" -q -name $1
exit 0;
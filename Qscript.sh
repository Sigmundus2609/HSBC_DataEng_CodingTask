#!/bin/bash
QHOME=~/q rlwrap -r ~/q/l64/q /home/marek/REPOS/Q/HSBC_DataEng_CodingTask/Qscript.q -startDate $1 -endDate $2 -currencyPair $3
exit 0;
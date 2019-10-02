#!/bin/bash

#Periperial functions-------------------------------------
function usage()
{
	echo ""
	echo "This script is designed pass the user input to the Q script"
	echo "that does import the csv table with currency transaction data and"
	echo "calculates the VWAP for the given currency pair"
	echo "#############################################################"
	echo "# Script is designed to be used as follows: ./Qscript.sh [startDate] [endDate] [currencyPair]"
	echo "# Example ./Qscript.sh 2000.01.01 2000.01.03 chfpln"
	echo "# Above command will return the VWAP for the chfpln pair for the indicated period"
	echo "#############################################################"
}
#--------------------------------------
function availablePairs()
{
	QHOME=~/q rlwrap -r ~/q/l64/q /home/marek/REPOS/Q/HSBC_DataEng_CodingTask/Qpair.q
	exit 0;
}
#----------------------
MAIN-----------
if [ $# -lt 3 ]; then
	usage
	availablePairs
else
	QHOME=~/q rlwrap -r ~/q/l64/q /home/marek/REPOS/Q/HSBC_DataEng_CodingTask/Qscript.q -startDate $1 -endDate $2 -currencyPair $3
	exit 0;
fi



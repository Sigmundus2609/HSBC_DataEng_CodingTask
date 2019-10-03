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
	$HOME/$QPATH/q $PWD/Qpair.q
	exit 0;
}
#----------------------
#MAIN
#----------------------

#PATH DECLARATION
#Please declare the path to your q framework files
QPATH='q/l64'

if [ $# -lt 3 ]; then
	echo ""
	echo "You have passed less than 3 parameters, please reffer to the help menu"
	echo "The pairs present in the loaded table are:"
	echo ""
	usage
	availablePairs
elif [ $# -eq 3 ];then
	$HOME/$QPATH/q $PWD/Qscript.q -startDate $1 -endDate $2 -currencyPair $3
	exit 0;
elif [ $# -gt 3 ]; then
	echo ""
	echo "You have passed more than 3 parameters, please reffer to the help menu"
	echo "The pairs present in the loaded table are:"
	echo ""
	usage
	availablePairs
fi



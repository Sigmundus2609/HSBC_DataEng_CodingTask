#!/bin/bash

#Periperial functions-------------------------------------
function usage()
{
	echo ""
	echo "This script is designed pass the user input to the Q script"
	echo "that does import the csv table with currency transaction data and"
	echo "calculates the TWAP/VWAP for the given currency pair over requested period"
	echo "#############################################################"
	echo "# Script is designed to be used as follows: ./Qscript.sh [twap/vwap] [startDate] [endDate] [currencyPair]"
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

if [ $# -lt 4 ]; then
	echo ""
	echo "You have passed less than 3 parameters, please reffer to the help menu"
	echo "The pairs present in the loaded table are:"
	echo ""
	usage
	availablePairs
elif [ $# -gt 4 ]; then
	echo ""
	echo "You have passed more than 3 parameters, please reffer to the help menu"
	echo "The pairs present in the loaded table are:"
	echo ""
	usage
	availablePairs
fi

case "$1" in
	twap)
	if [ $# -eq 4 ];then
		$HOME/$QPATH/q $PWD/TWAP.q -startDate $2 -endDate $3 -currencyPair $4
		exit 0;
	fi
	;;
	vwap)
	if [ $# -eq 4 ];then
		$HOME/$QPATH/q $PWD/VWAP.q -startDate $2 -endDate $3 -currencyPair $4
		exit 0;
	fi
	;;
	*)
		echo"Wrong first parameter, are you sure you have"
		echo"typed either twap or wvap?"
		usage
		availablePairs
		;;
esac





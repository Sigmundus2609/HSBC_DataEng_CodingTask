Table of Contents
=================


  * [Coding taks subject](#coding-task-subject)
  * [Prequisites](#prequisites)
    * [Table creation](#table-creation)
    * [Data saving](#Data-saving)
  * [Volume Weighted Average Price (VWAP) Function](#Volume-Weighted-Average-Price-VWAP-Function)
  * [Q Script structure](#Q-Script-structure)
  * [Time Weighted Average Price (TWAP) Introduction](#Time-Weighted-Average-Price-TWAP-Introduction)
  * [Usage example](#Usage-example)
  * [Tests performed](#Tests-performed)
 
  
# Coding task subject
```
The purpose of this mini project is for you to create a table which holds a timeseries of 
pricing data with prices and sizes for different fx (foreign exchange) currencies and 
write a function (API) to calculate the VWAP (volume-weighted average price) for this data.
If time permits, you can extend this to also write a TWAP (time-weighted average price) function.
```
 

Using q as the language of choice, there should be 5 outcomes for this project:

 

  1. An input file with data you have created in csv format
  		*Stored in the INPUT directory*

  2. A function which, given a time range and a list of symbols as inputs, returns the VWAP (TWAP) for each of these symbols as a table
  		*Stored in the QScripts directory*

  3. A command to start a q process which will load this function
  		*Please see Usage example section of this document*

  4. Example of how to call the function
  		*Please see the Usage example section of this document*

  5. Test(s) to ensure validity of code
  		*Please see test section fo this document*
 
```
Notes:

1. The choice of how to structure the output in terms of files, names, locations for each of the above
outputs is entirely yours.

2. Treat the structure of the data and code as if it is production quality code that needs to run in a stable
and supportable manner.

3. All of the above should be loaded to a online account (github or bitbucket) and the link should be shared
with us over email, pointing to the location of each of the above 5 outcomes for our review.
```
# Prequisites
In order to be able to progress with the task I was obliged to create a table with the data, of the format below:

| date | time | CurrencyPair | Quantity | Price |
|------|------|--------------|----------|-------|
|example date|example time| example pair| example quantity| example price|

and populate each column with random data. To achieve that, I have prepared a set of following lists, represented by header
of the table above:
  -date
  -time
  -CurrencyPair
  -Quantity
  -Price
  
each of which contains exactly same number of entrie aka is a vector of the same lenght.

## Table creation

Generation of dates, all from the range of 2000.01.01 till 2000.01.31, so time series from the January 2000.
```
q)dates: 2000.01.01+1000000?31
```
Trade time genreation, again one milion element list:
```
`q)times:1000000?24:00:00.000
```
Generation of the currency pairs, in this case they are all related to the chf:
```
q)pair: `chfpln`chfeur`chfgbp`chfusd`chfczk`chfrub`chfhuf`chfjpy`chfsgd`chfnok
'chfsgd
```
Generation of the quantities for transactions:
```
q)qtys: 100*1+1000000?100
```
Generation of the transaction prices for given pairs:
```
q) pxs: (1+1000000?.7)*4.0 0.98 0.76 0.92 200.0 2349.0 345.0 1235.0 2.4 756.0
```

In order to ensure that the **pair** and **pxs** lists, representing the currency pairs and the purchase prices 
respectively remain vectors of the same length it was necessary to create an auxiliary list that could be used later for casting its original valuues. 

The list *ixs* was created for that purpose

```
q)ixs:1000000?9
```

resulting in creation of the **pair** and **pxs** list in the final form below:

```
pair:pair ixs
```
```
pxs:pxs ixs
```

The table, described earlier in thsi section could be established, using the following:

```
q)t:([] date:dates;time:times;cp:pairs;qty:qtys;px:pxs)
```
The result of above is as follows:
```
q)t
date       time         cp     qty    px       
-----------------------------------------------
2000.01.21 01:12:30.450 chfpln 416000 5.74694  
2000.01.13 06:21:06.850 chfusd 444500 0.9085409
2000.01.30 07:38:36.568 chfpln 78100  1.028068 
2000.01.07 20:31:07.805 chfeur 332000 2665.273 
2000.01.23 17:09:49.235 chfnok 923600 1.272533 
2000.01.03 10:10:53.902 chfczk 128200 376.6586 
2000.01.26 01:46:02.792 chfpln 270600 5.778307 
2000.01.22 17:10:06.895 chfpln 663100 5.802463 
2000.01.07 01:51:15.087 chfczk 627800 781.7764 
2000.01.31 20:14:23.239 chfpln 637200 1.215696 
2000.01.04 09:29:32.944 chfczk 891500 384.8944 
2000.01.30 08:18:44.758 chfeur 361600 3293.138 
2000.01.11 03:13:44.871 chfczk 870100 816.9039 
2000.01.06 03:45:57.842 chfeur 362200 3.369973 
2000.01.28 10:45:54.620 chfnok 617100 1.046635 
2000.01.24 05:07:59.730 chfeur 627800 2.907919 
2000.01.15 04:29:18.742 chfczk 813100 1052.909 
2000.01.28 13:17:41.673 chfnok 825000 1.362618 
2000.01.29 11:44:47.715 chfpln 690200 4.324001 
2000.01.13 20:35:14.769 chfczk 731800 353.8758 
..
```

## Data saving
Once the tale is assigned to the *t*, it can be exported and stored on the HDD, In order to do that, one shall execute the following:

```
q)save `$"/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv"
`:/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv
```
the ` :/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/table` states for scucessfully saved file.

Viola! the data that will be taken into account for further tasks is now in the $PATH/INPUT location.


# Volume Weighted Average Price (VWAP) Function


The VWAP can be understood as a trading benchmark, used by investors to justify if their 
purchase was benefitial or not, over a given period of time. It can be easily calculated as the sum of products of quantity bought at given price, divided by the sum of quantity bought.

Considering that table **t** from the previous  example is used, the aim is to create a table of the following structure:

```
q)pair_trade_vwap
date       time        | cp     vwap     
-----------------------| ----------------
2000.01.03 00:00:06.160| chfsgd 5.291644 
2000.01.03 00:00:06.604| chfrub 1.447896 
2000.01.03 00:00:06.782| chfpln 2511.818 
2000.01.03 00:00:07.786| chfpln 3740.091 
2000.01.03 00:00:13.353| chfpln 3683.64  
2000.01.03 00:00:13.738| chfpln 1.06814  
2000.01.03 00:00:13.997| chfusd 2.61201  
2000.01.03 00:00:16.081| chfusd 1942.851 
2000.01.03 00:00:16.464| chfsgd 5.390094 
2000.01.03 00:00:18.740| chfusd 3.651731 
2000.01.03 00:00:19.997| chfusd 2.910347 
2000.01.03 00:00:28.078| chfusd 1505.604 
2000.01.03 00:00:29.579| chfczk 1.374346 
2000.01.03 00:00:32.151| chfczk 1.478632 
2000.01.03 00:00:34.525| chfczk 0.9778234
2000.01.03 00:00:38.137| chfusd 1356.994 
2000.01.03 00:00:39.177| chfczk 0.9676395
2000.01.03 00:00:41.674| chfsgd 6.560826 
2000.01.03 00:00:43.151| chfsgd 496.4387 
2000.01.03 00:00:50.822| chfusd 3.695032 
```
where the user decides on the date/time ranges for a given pair. This is equivalent to the SQL query of the following syntax:

```
pair_trade_vwap:select cp,  vwap: qty wavg px by date, time from t 
where date within 2000.01.03 2000.01.07
```
or specyfically, staying coherent with the subject of the task:
```
q)select vwap: qty wavg px by cp from t where date within 2000.01.01 2000.01.30, cp=`chfpln
```
which results in returning the following table (currency pair and vwap)
```
cp    | vwap    
------| --------
chfpln| 1583.461
```

-------------------------

Input from the user side shall be **date range** and the currency pair of user's
 interest with default execution set to show the VWAP for all pairs.



## Q Script structure

The `Qscript.sh` file is a bash script that passes to the Qscript.q all necessary parameters like: the initial and final dates for calculation of the VWAP.

**IMPORTANT**
```
Please edit the QPATH variable in the Qscript.sh (line28, so that it matches the path of your q framework files
```


Line by line the Qcript.q script does the following
  Casting the variables to the form, used by the query function

  	```
	startDate:"D"$raze d[`startDate]
	endDate:"D"$raze d[`endDate]
	currencyPair:`$ raze d[`currencyPair]
	```


   Loading the table that was previously prepared:
 	```
	 t:("DTSHF";enlist ",") 0:  `:/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv
	```

  Defining the function to query for VWAP
	```
	VWAP:{[startDate;endDate;pair] select vwap: qty wavg px by cp from t where date within (startDate;endDate), cp in pair}
	```

  Passing the variables to the function vwap
```
  	vwap:VWAP[startDate;endDate;currencyPair]
```
	Showing the results;
```	
	show "Requested result:"
	show vwap
```

`Below example listening`
```
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh 2000.01.01 2000.01.20 chfpln,chfusd
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

"Calculating VWAP"
"Requested result:"
cp    | vwap    
------| --------
chfpln| 1586.031
chfusd| 836.6778

```

# Time Weighted Average Price (TWAP) Introduction

This is the benchmarkt which function can be expressed mathematically as the average of four
prices during the day: price at open, price at close, max during the given day and min during the 
given day.

The Q script that is responsible for calculating the TWAP is a twin one to the VWAP one.
The only difference there is a query that is used. In this case it is as shown below:

```
TWAP:{[startDate;endDate;pair] select open:first px, close: last px, lo:min px, hi:max px, TWAP:avg(min px; max px; first px; last px) by date from t where date within (startDate;endDate), cp in pair}

```

# Usage example

**WARNING**

**Before you start use the script, please ensure that you have fed the line #28 of `Qscript.sh` file with
correct path pointing to the directory where you hold your q framwerok files!**

Once the line is set correctly, please execute the following form the path the script is located:
```
./Qscript.sh -h
```
this shall return you the following, help menu, output:
```
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh 2000.01.01 2000.01.23 chfpln

You have passed less than 4 parameters, please reffer to the help menu
The pairs present in the loaded table are:


This script is designed pass the user input to the Q script
that does import the csv table with currency transaction data and
calculates the TWAP/VWAP for the given currency pair over requested period
#############################################################
# Script is designed to be used as follows: ./Qscript.sh [twap/vwap] [startDate] [endDate] [currencyPair]
# Example ./Qscript.sh 2000.01.01 2000.01.03 chfpln
# Above command will return the VWAP for the chfpln pair for the indicated period
#############################################################
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

cp    
------
chfusd
chfsgd
chfczk
chfeur
chfpln
chfrub
InitialDate FinalDate 
----------------------
2000.01.01  2000.01.31

```

The prompt lists available currency pairs and the time range for the given set.

Example1:
```
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh twap 2000.01.01 2000.01.4 chfusd
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

"Calculating TWAP"
"Requested TWAP result:"
date      | open     close    lo       hi       TWAP    
----------| --------------------------------------------
2000.01.01| 3.474475 3.325189 2.400032 2099.247 527.1117
2000.01.02| 2.499072 1686.776 2.400535 2099.236 947.7279
2000.01.03| 1553.803 3.11718  2.400055 2098.914 914.5586
2000.01.04| 1387.478 2.750105 2.400484 2099.222 872.9626
```
The TWAP for dates within 2000.01.01 and 2000.01.04 for chfusd are returned

Example2:
```
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh vwap 2000.01.01 2000.01.4 chfusd,chfpln
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

"Calculating VWAP"
"Requested result:"
cp    | vwap    
------| --------
chfpln| 1587.693
chfusd| 848.7513
```

The VWAP for dates within 2000.01.01 and 2000.01.04 for two currency pairs are returned.

# Tests performed

- [x] Checking that the VWAP.q and TWAP.q are properly called via the `Qscript.sh` bash script

```
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh vwap 2000.01.01 2000.01.05 chfpln
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

"Calculating VWAP"
"Requested result:"
cp    | vwap   
------| -------
chfpln| 1588.57
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh twap 2000.01.01 2000.01.05 chfpln
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

"Calculating TWAP"
"Requested TWAP result:"
date      | open      close     lo        hi       TWAP    
----------| -----------------------------------------------
2000.01.01| 0.7710761 2954.875  0.7600032 3993.153 1737.39 
2000.01.02| 1.064102  0.801557  0.7604753 3992.887 998.8783
2000.01.03| 1.247656  0.9082884 0.760047  3992.636 998.888 
2000.01.04| 0.9275889 3623.797  0.7600095 3992.706 1904.548
2000.01.05| 1.216297  3145.897  0.7600941 3992.976 1785.212
```

- [x] Checking if the help menu returns understandable output and if the `Qpair.q` script is called 
properly.

```
marek@mgruchal ~/REPOS/Q/HSBC_DataEng_CodingTask $ ./Qscript.sh twap 2000.01.01 2000.01.05

You have passed less than 4 parameters, please reffer to the help menu
The pairs present in the loaded table are:


This script is designed pass the user input to the Q script
that does import the csv table with currency transaction data and
calculates the TWAP/VWAP for the given currency pair over requested period
#############################################################
# Script is designed to be used as follows: ./Qscript.sh [twap/vwap] [startDate] [endDate] [currencyPair]
# Example ./Qscript.sh 2000.01.01 2000.01.03 chfpln
# Above command will return the VWAP for the chfpln pair for the indicated period
#############################################################
KDB+ 3.6 2019.08.20 Copyright (C) 1993-2019 Kx Systems
l64/ 4(16)core 7882MB marek mgruchal 127.0.1.1 EXPIRE 2020.08.30 siara39@op.pl KOD #4166537

cp    
------
chfusd
chfsgd
chfczk
chfeur
chfpln
chfrub
InitialDate FinalDate 
----------------------
2000.01.01  2000.01.31

```

- [x] Checking if the repositorycan be used on a different machine/OS.

```
In order to prove that I have installed fresh mandriva distro on the VM and plled the last up to date
version of the code, installed q in different location and checked if the output of those remains
consistent with above ones.
```

- [x] Numerical chcecking for VWAP solutions. In order to do that the new table of the following scheme was created:
```
q)t
date       time         cp     qty    px       
-----------------------------------------------
2000.01.28 10:45:54.620 chfpln 100 1 
2000.01.24 05:07:59.730 chfpln 200 2 
2000.01.15 04:29:18.742 chfpln 300 4

```

and the numerical output of the VWAP function was checked and compared with calculation "by hand". Results did match, both were 2.8(3).

- [x] Numerical chcecking for TWAP solutions. Methodology was similar to above. New table was created, with limited number of entries and results were cross checked using simple excel formulas.


What I'd aim to test if this was for the wide community of users:

- [ ] Compatibility with other shells (csh).
- [ ] Compatibility with older version of KDB+ (whole test aimed to ensure proper working under the 
`KDB+ 3.6 2019.08.20` version)

Table of Contents
=================


  * [Coding taks subject](#coding-task-subject)
  * [Prequisites](#prequisites)
    * [Table creation](#table-creation)
    * [Data saving](#data-savingn)

# Coding task subject <a name="Coding task subject"></a>
```
The purpose of this mini project is for you to create a table which holds a timeseries of 
pricing data with prices and sizes for different fx (foreign exchange) currencies and 
write a function (API) to calculate the VWAP (volume-weighted average price) for this data.
If time permits, you can extend this to also write a TWAP (time-weighted average price) function.
```
 

Using q as the language of choice, there should be 5 outcomes for this project:

 

  1. An input file with data you have created in csv format

  2. A function which, given a time range and a list of symbols as inputs, returns the VWAP (TWAP) for each of these symbols as a table

  3. A command to start a q process which will load this function

  4. Example of how to call the function

  5. Test(s) to ensure validity of code

 
```
Notes:

1. The choice of how to structure the output in terms of files, names, locations for each of the above
outputs is entirely yours.

2. Treat the structure of the data and code as if it is production quality code that needs to run in a stable
and supportable manner.

3. All of the above should be loaded to a online account (github or bitbucket) and the link should be shared
with us over email, pointing to the location of each of the above 5 outcomes for our review.
```
## Prequisites <a name="Prequisites"></a>
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

## Table creation <a name="Table creation"></a>

```
q)dates: 2000.01.01+1000000?31
```
```
`q)times:1000000?24:00:00.000
```
```
q)pair: `chfpln `chfeur `chfgbp `chfusd `chfczk `chfrub `chfhuf `chfjpy `chfsgd `chfnok
'chfsgd
```
```
q)qtys: 100*1+1000000?100
```
```
pxs: (1+1000000?.7)*4.0 0.98 0.76 0.92 200.0 2349.0 345.0 1235.0 2.4 756.0
```

In order to ensure that the **pair** and **pxs** lists, representing the currency pairs and the purchase prices 
respectively remain vectors of the same length it was necessary to create an auxiliary list that could be used latter for casting its original valuues. 

The list *ixs* was created for that purpose

```
q)ixs:10000000?9
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

## Data saving <a name="data saving"></a>

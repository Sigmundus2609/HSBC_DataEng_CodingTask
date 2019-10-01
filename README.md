# HSBC_DataEng_CodingTask

## Coding task subject <a name="Coding task subject"></a>
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
In order to be able to process with the taks I was obliged to create a table with the data, of the format below:

| date | time | CurrencyPair | Quantity | Price |
|------|------|--------------|----------|-------|
|example date|example time| example pair| example quantity| example price|

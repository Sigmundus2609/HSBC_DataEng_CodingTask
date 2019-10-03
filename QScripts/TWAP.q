show "Calculating TWAP"
d:.Q.opt .z.x

/Casting the variables to the form used by the query function

startDate:"D"$raze d[`startDate]
endDate:"D"$raze d[`endDate]
currencyPair:`$"," vs raze d[`currencyPair]

/Loading the data from the table

t:("DTSHF";enlist ",") 0: `:/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv


/Defining the function to query for VWAP

TWAP:{[startDate;endDate;pair] select open:first px, close: last px, lo:min px, hi:max px, TWAP:avg(min px; max px; first px; last px) by date from t where date within (startDate;endDate), cp in pair}

twap:TWAP[startDate;endDate;currencyPair]
show "Requested TWAP result:"
show twap
\\
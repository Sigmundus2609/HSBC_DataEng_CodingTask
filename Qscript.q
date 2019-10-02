show "Calculating VWAP"
d:.Q.opt .z.x

/Casting the variables to the form used by the query function

startDate:"D"$raze d[`startDate]
endDate:"D"$raze d[`endDate]
currencyPair:`$"," vs raze d[`currencyPair]

/Loading the data from the table

t:("DTSHF";enlist ",") 0: `:/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv


/Defining the function to query for VWAP

VWAP:{[startDate;endDate;pair] select vwap: qty wavg px by cp from t where date within (startDate;endDate), cp in pair}

vwap:VWAP[startDate;endDate;currencyPair]
show "Requested result:"
show vwap
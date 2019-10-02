d:.Q.opt .z.x

/Loading the data from the table

t:("DTSHF";enlist ",") 0: `:/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv


/Defining the function

f:{[startDate;endDate;pair] select vwap: qty wavg px by cp from t where date within startDate endDate, cp=pair}


t:("DTSHF";enlist ",") 0: `:/home/marek/REPOS/Q/HSBC_DataEng_CodingTask/INPUT/t.csv
pairs:select distinct cp from t
show pairs
dates: select InitialDate:min date, FinalDate: max date from t
show dates
exit 0;
*Importing csv file;
proc import datafile = '/folders/myfolders/project/rawdata/prices-split-adjusted.csv'
 out = adjusted
 dbms = CSV
 ;
run;

*Sort imported data by symbol;
proc sort data=adjusted;
  by symbol;
run;

*Counting symbol x date in order to sort which stock to consider for our data;
*We need symbols(stocks) whose observation is 1762 which is total dates of the whole period;
data count;
  set adjusted (keep= symbol);
  by symbol;
  if first.symbol then count=0;
  count+1;
  if last.symbol then output;
run;

*Create a column for symbols whose number of records is 1762;
proc sql;
	create table valid_sym as
		select symbol from count 
		where count = 1762;		
quit;

*Remove symbols whose number of records is not 1762 from adjusted(originally imported dataset);
proc sql;
	create table adjusted_cleaning as
		select adjusted.date, adjusted.symbol from adjusted 
			where symbol in(
			select symbol from valid_sym);
quit;
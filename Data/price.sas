*Importing csv file;
proc import datafile = '/folders/myfolders/project/rawdata/prices-split-adjusted.csv'
 out = adjusted
 dbms = CSV
 ;
run;
proc import datafile = '/folders/myfolders/project/rawdata/fundamentals.csv'
 out = fundamentals_raw
 dbms = CSV
 ;
run;
proc import datafile = '/folders/myfolders/project/rawdata/securities.csv'
 out = securities_raw
 dbms = CSV
 ;
run;
proc import datafile = '/folders/myfolders/project/stocks.csv'
 out = stocks
 dbms = CSV
 ;
run;


	
*Sort imported data by symbol;
proc sort data=adjusted;
  by symbol;
run;


*Remove symbols whose number of records is not 1762 from adjusted(originally imported dataset);
proc sql;
	create table price as
		select adjusted.date, adjusted.symbol, adjusted.close from adjusted 
			where symbol in(
			select stocks from stocks);
quit;

proc sql;
	create table fundamentals as
		select * from fundamentals_raw 
			where Ticker_Symbol in(
			select stocks from stocks);
quit;

proc sql;
	create table securities as
		select * from securities_raw 
			where Ticker_Symbol in(
			select stocks from stocks);
quit;
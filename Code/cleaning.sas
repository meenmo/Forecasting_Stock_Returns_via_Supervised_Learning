*Importing csv file;
proc import datafile = '/folders/myfolders/project/rawdata/prices-split-adjusted.csv'
 out = adjusted
 dbms = CSV;
run;

proc import datafile = '/folders/myfolders/project/rawdata/fundamentals.csv'
 out = fundamentals_raw
 dbms = CSV;
run;

proc import datafile = '/folders/myfolders/project/rawdata/securities.csv'
 out = securities_raw
 dbms = CSV;
run;

*This is Samuel's csv file about list of tickers that are contained in all three datasets;
proc import datafile = '/folders/myfolders/project/stocks.csv'
 out = stocks
 dbms = CSV;
run;

/*Remove columns that are not contained in stocks.csv imported above, 
order by ticker, and rename some of them*/
proc sql;
	create table prices as
		select * from adjusted (rename=(symbol = Ticker)) 
			where Ticker in(select stocks from stocks)
			order by Ticker;
quit;

proc sql;
	create table fundamentals (drop=VAR1) as
		select * from fundamentals_raw (rename=(Ticker_Symbol = Ticker)) 
			where Ticker in(select stocks from stocks)
			order by Date, Ticker;
quit;

proc sql;
	create table securities as
		select * from securities_raw (rename=(Ticker_Symbol = Ticker)) 
			where Ticker in(select stocks from stocks)
			order by Ticker;
quit;

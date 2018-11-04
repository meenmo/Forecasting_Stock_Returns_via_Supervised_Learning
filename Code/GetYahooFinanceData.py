"""
Create .csv file for any Stock data from any date from Yahoo Finance

# GetYahooFinanceData.py

NOTE - Do not run this code in terminal --> it won't work. 
"""



from pandas_datareader import data as pdr
import pandas as pd

### Set Parameters
fileName = "UNG"
stock = fileName  # "IJS"
startDate = "2014-11-11"  # yyyy-mm-dd
endDate = "2016-09-01"

    # start_date = datetime.datetime(2014, 11, 11)
    # end_date = datetime.datetime(2016, 9, 1)

### Get Data
df = pdr.get_data_yahoo(stock, startDate, endDate)

### Write to CSV
filePath  = r"/Users/YoungFreeesh/QSTrader Data/" + fileName + ".csv"  # file path 
df.to_csv(filePath)

















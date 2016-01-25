# yahoo_stocks

Python, Bash, and R Scripts for grabbing stock prices, inserting into a MYSQL data table,
and then aggregating and plotting them on a line graph.

For main script to call sub-programs, see sql_stocks.sh:
- pulls the data from google with sql_stocks.py for GOOG (Google) and places it into a MYSQL database
- converts that sql database into a csv with output_mysql.sh
- graphs the data with ticker_graph.R
- outputs log with date prefix

I added an entry to my crontab to run this script every 10 minutes during trading hours. (see results at mikeandpj.com/projects/stocks)

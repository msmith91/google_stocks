#!/bin/bash

#master script - pulls the data from google with sql_stocks.py for GOOG (Google) and places it into a MYSQL database
#              - converts that sql database into a csv with output_mysql.sh
#              - graphs the data with ticker_graph.R
#              - outputs log with date prefix
#I added this to my crontab to run this script every 10 minutes during trading hours. (see results at mikeandpj.com/projects/stocks)

exec > $(date +%m%d%Y_%H:%M).log

/usr/bin/python sql_stocks.py GOOG

/usr/bin/sh output_mysql.sh

/usr/bin/Rscript ticker_graph.R GOOG


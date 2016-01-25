#!/bin/bash

#puts mysql data into a csv and adds in column headers.
#run like "sh output_mysql.sh"

DBNAME=develop
TABLE=stocks_py_date

FNAME=$TABLE.csv

#(1)creates empty file and sets up column names using the information_schema
mysql -u username -p password $DBNAME -B -e "SELECT COLUMN_NAME FROM information_schema.COLUMNS C WHERE table_name = '$TABLE';" | awk '{print $1}' | grep -iv ^COLUMN_NAME$ | tr '\n' ',' > $FNAME

#(2)appends newline to mark beginning of data vs. column titles
echo "" >> $FNAME

#(3)dumps data from DB into /var/mysql/tempfile.csv
mysql -u username -p password $DBNAME -B -e "SELECT * INTO OUTFILE 'tempfile.csv' fields terminated by ','  lines terminated by '\n' FROM $TABLE;"

#(4)merges data file and file w/ column names
cat tempfile.csv >> $FNAME

#(5)deletes tempfile
rm -rf tempfile.csv

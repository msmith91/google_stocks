#!/usr/bin/python -tt

#GoogleFinanceAPI class give a funciton that you call with the desired ticker symbol and exchange(assumes NYSE) and it scrapes the json data from
#Google Finance and returns the stock and datetime into a sql database.
#call this script with "python sql_stocks.py GOOG" to return the current price for Google and insert the observation into the MYSQL db.

import sys
import json
import urllib2
import MySQLdb as mdb
import time

class GoogleFinanceAPI:
    def __init__(self):
        self.prefix = "http://finance.google.com/finance/info?client=ig&q="

    def get(self,symbol,exchange):
        url = self.prefix+"%s:%s"%(exchange,symbol)
        u = urllib2.urlopen(url)
        content = u.read()

        obj = json.loads(content[3:])
        return obj[0]

if __name__ == "__main__":

    current_time = time.localtime(time.time())
    con = mdb.connect('localhost', 'user', 'password', 'db library');
    stock = sys.argv[1]
    c = GoogleFinanceAPI()
    quote = c.get(stock,"NASDAQ")

    with con:
        cur = con.cursor()
        cur.execute("INSERT INTO stocks_py_date(Stock,Price,Month,Day,Year,Hour,Minute) VALUES(%s,%s,%s,%s,%s,%s,%s)",(quote[u't'],quote[u'l_cur'],current_time[1],current_time[2],current_time[0],(current_time[3]-5),current_time[4]))
    print "Time: %s/%s/%s %s:%s"%(current_time[1],current_time[2],current_time[0],current_time[3],current_time[4])
    print "Ticker: %s"%(quote[u't'])
    print "Price: %s"%(quote[u'l_cur'])

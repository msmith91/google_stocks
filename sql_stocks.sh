#!/bin/bash

exec > $(date +%m%d%Y_%H:%M).log

/usr/bin/python sql_stocks.py NLSN

/usr/bin/python sql_stocks.py GOOG

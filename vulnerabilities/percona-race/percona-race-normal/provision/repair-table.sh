#!/bin/bash

mysql -uvagrant -pvagrant<<MYSQL_SCRIPT
REPAIR TABLE normal.links EXTENDED;
MYSQL_SCRIPT
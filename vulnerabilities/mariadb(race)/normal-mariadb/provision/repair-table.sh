#!/bin/bash

# log into mysql as vagrant user (not root) and repair the links table by issuing mysql query
mysql -uvagrant -pvagrant<<MYSQL_SCRIPT
REPAIR TABLE normal.links EXTENDED;
MYSQL_SCRIPT

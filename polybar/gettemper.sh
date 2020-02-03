#!/bin/sh

#echo $(sensors | grep temp1 | awk  '{printf $2}'| tr -d '+')
sensors | grep temp1 | awk  '{printf $2}'| tr -d '+'

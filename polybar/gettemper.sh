#!/bin/sh

temp = $(sensors | grep temp1 | awk  '{printf $2}'| tr -d '+')
eche 

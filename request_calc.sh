#!/bin/bash
#

HOST="http://127.0.0.1/calc?vf=200&vi=5&t=123"

while [ 1 ]; do
    if curl -m 2 -f $HOST --connect-timeout 2 &>/dev/null ; then 
      echo -n "."
    else 
      echo -n "e"
    fi
    sleep 1
done
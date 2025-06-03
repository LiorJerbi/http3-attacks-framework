#!/bin/bash

while true
do
    curl -k -w "Time: %{time_total}s\n" -I https://10.0.2.15 
    sleep 2
done


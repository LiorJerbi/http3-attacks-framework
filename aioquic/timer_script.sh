#!/bin/bash

while true
do
    curl -k -w "Time: %{time_total}s\n" -I https://129.159.150.72
    sleep 2
done


#!/bin/bash
# daily-report.sh -- summarize one day of Prairie Sky readings
#   usage: ./daily-report.sh DATE
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $0 DATE" >&2
    exit 2
fi

logs=~/psk/logs
day=$1

echo "Prairie Sky daily report for $day"
for f in $logs/*-$day.csv; do
    id=$(basename $f -$day.csv)
    high=$(tail -n +2 $f | cut -d, -f2 | sort -n | tail -1)
    low=$(tail -n +2 $f | cut -d, -f2 | sort -n | head -1)
    rain=$(tail -n +2 $f | cut -d, -f5 | paste -sd+ - | bc)
    echo "$id: high $high, low $low, rain $rain"
done

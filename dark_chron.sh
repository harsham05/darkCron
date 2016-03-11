#!/bin/bash
yesterday=$(date -d 'yesterday' '+%Y-%m-%d')

outfile=$yesterday"weap.out"

#cd path/to/dark/script
cd ~/Downloads/darkCron
#cd /usr/local/memex/darkWeapons/chron

#10000000
python es_allSearch.py wea.txt outFiles/$outfile weapDir 100 _type $yesterday

mv $outfile outFiles/

outFiles/weaToday2.out 


updates=$yesterday"Updates.txt"

python refactoredMover.py --inCSV outFiles/$outfile --outCSV $updates --nutchDumpPath /data2/USCWeaponsStatsGathering/nutch/full_dump

    


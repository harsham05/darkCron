#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
yesterday=$(date -d 'yesterday' '+%Y-%m-%d')
outfile=$yesterday"weap.out"

#cd path/to/dark/script  #cd ~/Downloads/darkCron
cd /usr/local/memex/darkWeapons/dark_Cron_production

#10000000 =>  **************** CHANGE THIS **************
python es_allSearch.py wea.txt outFiles/$outfile weapDir 1000 _type $yesterday

updates=$yesterday"Updates.csv"
python refactoredMover.py --inCSV outFiles/$outfile --outCSV updates/$updates --nutchDumpPath /data2/USCWeaponsStatsGathering/nutch/full_dump
#cd /usr/local/memex/imagecat/tmp/parser-indexer
#java -cp target/nutch-tika-solr-1.0-SNAPSHOT.jar edu.usc.cs.ir.cwork.files.DarkDumpPoster
#-nutch /data2/USCWeaponsStatsGathering/nutch/runtime/local
#!/bin/bash
ulimit -n 1000000
echo "################## HTTP #################"
echo "################## Run 135B #################"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 2000 -d 2m http://example.com/135.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 135.txt &&
sleep 2
echo "################# Run 1M #################"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m http://example.com/1M.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 1M.txt &&
sleep 2
echo "################# Run MIX #################"
echo "15k"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m http://example.com/15k.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 15k.txt &
echo "37k"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m http://example.com/37k.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 37k.txt &
echo "91k"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m http://example.com/91k.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 91k.txt
sleep 120
echo "##########################################################################################"
echo "################## HTTPS #################"
echo "################## Run 135B #################"; wrk -s responses_code.lua --latency --timeout 60s -t 100 -c 2000 -d 2m https://example.com/135.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 135.txt &&
sleep 2
echo "################# Run 1M #################"; wrk -s responses_code.lua --latency --timeout 60s -t 100 -c 650 -d 2m https://example.com/1M.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 1M.txt &&
sleep 2
echo "################# Run MIX #################"
echo "15k"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m https://example.com/15k.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 15k.txt &
echo "37k"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m https://example.com/37k.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 37k.txt &
echo "91k"; wrk -s responses_code.lua --latency --timeout 60s -t 120 -c 650 -d 2m https://example.com/91k.html -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/99.0.4844.51 Safari/537.36" -H "Accept: */*" -H "Connection: close"| grep -v 0,0,0 | tee -a 91k.txt

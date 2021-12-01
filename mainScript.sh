#!/bin/bash

input=./urls
echo "Init..."

if [ 1 == 1 ]; then
	echo "Help menu: \\n \\t -all (performing all tests)"
	echo "Provide full url like: https://example.com/ or IP" 
	echo "=============================================="
	echo "\n"			
fi 




ls=(nslookup curl-OPTIONS whatweb testssl dirb nmap nikto)
#ls=( curl-OPTIONS )

#nmap
## TO BE ADDED checks input if its URL or IP and host command
## Resolve host
## Add 2> stderror to commands 

#nslookup curl-OPTIONS
#echo ${ls[0]}
#echo "chekcpoint1"
for i in ${ls[@]}; do  
	#echo "chekcpoint2"
	while IFS= read -r line
	do 
		#split URL on //
		nameUrl=$( echo $line | cut -d/ -f3 )
		echo "File name became: $nameUrl"
		#echo "chekcpoint3"
		#all commands
		if [ "$i" == "whatweb"  ]; then
			echo "Running $i for $line"
			eval "whatweb -v $line" >> "./$i/$nameUrl.txt" &
		elif [ "$i" == "curl-OPTIONS" ]; then
			echo "Running $i for $line"
			eval "curl -I $line -X OPTIONS -L" >> "./$i/$nameUrl.txt" &
			eval "curl -I $line -L" >> "./$i/$nameUrl.txt" &
		elif [ "$i" == "nslookup" ]; then
			echo "Running $i for $line"
			eval "nslookup $nameUrl" >> "./$i/$nameUrl.txt" &
		elif [ "$i" == "nmap" ]; then
			echo "Running $i for $line"
			eval "nmap $nameUrl -sV -n -Pn -v" >> "./$i/$nameUrl.txt" &
		elif [ "$i" == "nikto" ]; then
			echo "Running $i for $line"
			eval "nikto -h $line" >> "./$i/$nameUrl.txt" &
		elif [ "$i" == "dirb" ]; then
			echo "Running $i for $line"
			eval "dirb $line -f" >> "./$i/$nameUrl.txt" &
		else
			echo "Running $i for $line"
			eval "$i $line" >> "./$i/$nameUrl.txt" &
		fi
	done < "$input"
	sleep 2
done


echo "=============================================="
echo "\n"	
echo " Finished "

##while IFS= read -r line
	#do 

#check if its IP
		#if [[ $line =~ ^([0-9]{1,3}\.){3}[0-9]+$ ]]; then 
		#	echo "Yes $line"
		#fi
		#split URL on //
		#nameUrl=$( echo $line | cut -d/ -f3 )
		#echo "File name: $nameUrl"
		
##done < "$input"

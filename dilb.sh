#!/bin/bash
if [ -z $1 ]
then
	#the starting date of the first comic strip if no starting date is otherwise supplied
	starting_year=1989
	starting_month=4
	starting_date=16	
else
	#starting date according to the arguments
	starting_year=$3
	starting_month=$2
	starting_date=$1
fi

#gets the current date
current_year=$(date +%Y)
current_month=$(date +%m)
current_date=$(date +%d)

if [ ! -e $starting_year ]
then
	mkdir $starting_year
fi
if [ ! -e $starting_year/$starting_month ]
then
	mkdir $starting_year/$starting_month
fi

while [ $starting_date -lt $starting_date ] || [ $starting_month -ne $current_month ] || [ $starting_date -ne $current_date ]
do
	if [ $starting_date -gt 31 ]
	then
		starting_date=1
		let starting_month=starting_month+1
		if [ $starting_month -gt 12 ]
		then
			starting_month=1
			let starting_year=starting_year+1
			mkdir $starting_year
		fi
		mkdir $starting_year/$starting_month
	fi
	rm /tmp/tmp
	echo $starting_year-$starting_month-$starting_date
	wget -O /tmp/tmp dilbert.com/strip/$starting_year-$starting_month-$starting_date -q
	down_link=$(grep -o -m 1 data-image=\"http://assets.amuniversal.com/[^\"]* /tmp/tmp | grep -o http[^\"]*)
	echo $down_link
	wget -O $starting_year/$starting_month/$starting_year-$starting_month-$starting_date.gif $down_link -q
	let starting_date=starting_date+1
done

# grep -o -m 1 http://assets.amuniversal.com/[^\"]* 1990-5-7

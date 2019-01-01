
date_day=24;
date_month=10;
date_year=2018;

start_file=3081;
end_file=3246;

a=0;
for i in `seq $start_file $end_file`; do
    
    file="none";
    if [ -e GOPR$i.JPG ]; then file=GOPR$i.JPG; fi
    if [ -e GOPR$i.MP4 ]; then file=GOPR$i.MP4; fi

    if [ ! $file == "none" ]; then
	echo -n "[-] "$file;

	if [ 10 -gt $(($a % 60)) ]; then
	    minutes="0"$(($a % 60));
	else
	    minutes=$(($a % 60));
	fi 

	echo " created and modified "$modified_date;
	
	modified_date=$date_year":"$date_month":"$date_day\ $((10 + ($a + 1)/60)):$minutes:00
	exiftool -DateTimeOriginal="$modified_date" $file;
	exiftool -ModifyDate="$modified_date" $file;
	exiftool -CreateDate="$modified_date" $file;

	modified_date=$date_month\/$date_day\/$date_year\ $((10 + ($a + 1)/60)):$minutes:00
	SetFile -d "$modified_date" $file;
	SetFile -m "$modified_date" $file;
	
	a=$((a+1));
    fi;
done

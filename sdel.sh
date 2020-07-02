#!/bin/bash

if [ ! -d ~/TRASH ];
then
    mkdir ~/TRASH

elif [ ls -la ~/TRASH | head -n1 | cut -d " " -f2 -ge 1 ];
then
    #for val in Documents/*; do echo $val; done
    count_of_lines=`ls -lc ~/Trash | wc -l`
    for i in `seq 2 $count_of_lines`;
    do
        temp_var=`ls -lc ~/Trash | sed "$iq;d"`
        day= `echo $temp_var | cut -d " " -f7`
        time=`echo $temp_var | cut -d " " -f8`
        file_name=`echo $temp_var | cut -d " " -f9`
        month=`echo $temp_var | cut -d " " -f6`

        temp_var=`date`
        day_now=`echo $temp_var | cut -d " " -f3`
        time_now=`echo $temp_var | cut -d " " -f4`
        delete="false"

        hour=`IFS=':' read -ra ADDR <<< $time; echo "${ADDR[0]}"`
        hour_now=`IFS=':' read -ra ADDR <<< $time_now; echo "${ADDR[0]}"`

        if [ $((day_now - day)) -gt 1 ]
        then
            delete="true"
        elif [ month=="Jan" || month=="Mar" || month=="May" || month=="Jul" || month=="Aug" || month=="Oct" || month=="Dec" ];
        then
            if [ day_now -eq 1 && day -eq 30 && $((hour_now-hour)) -ge 0 ];
            then
                delete="true"
            elif [ day_now -eq 2 && day -eq 31 && $((hour_now-hour)) -ge 0 ];
            then
                delete="true"
            fi
        elif [ month=="Feb" ];
        then
            if [ day_now -eq 2 && day -eq 28 && $((hour_now-hour)) -ge 0 ];
            then
                delete="True"
            elif [ day_now -eq 2 && day -eq 29 && $((hour_now-hour)) -ge 0 ];
            then
                delete="True"
            fi
        elif [ day_now -eq 2 && day -eq 30 && $((hour_now-hour)) -ge 0 ];
        then
            delete="true"
        fi

        if [ delete=="true" ];
        then
            rm -rf ~/TRASH/$file_name
        fi
    done 

if [ $# -lt 2 ];
then
    echo "You should give me at least a file name or path to a file to be deleted"
    exit
fi



for var in "$@";
do
    gzip var
    mv "$var.gz" ~/TRASH
done


    
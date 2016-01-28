#!/bin/bash

command=$(acpi -b)
command=${command//, / }

#state=$(echo $res | awk '{ print $2 }')
state=$(echo $command | awk '{ print $3 }')
percentage=$(echo $command | awk '{ print $4 }' | sed 's/%//' )
time_to=$(echo $command | awk '{ print $5 }')
time_to=${time_to:0:5}

full_text="$percentage%"
color="#00FF00"

if [[ $state == "Charging" ]]; then
    full_text="$full_text CHR"
elif [[ $state == "Discharging" ]]; then
    full_text="$full_text DIS"
fi

if [[ ! -z $time_to ]]; then
    full_text="$full_text ($time_to)"
fi

if [[ $state == "Discharging" ]];then

    if [[ $percentage -lt 20 ]]; then
        color="#FF0000"
    elif [[ $percentage -lt 40 ]]; then
        color="#FFAE00"
    elif [[ $percentage -lt 60 ]]; then
        color="#FFF600"
    elif [[ $percentage -lt 85 ]]; then
        color="#A8FF00"
    fi
fi


echo $full_text
echo
echo $color

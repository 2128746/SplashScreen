#!/usr/bin/bash


# Program name: script.bash

isDigital=true
location=

drawDigit() {

    file=$1

    offset=$2



        width=$(tput cols)

    

    input="numbers/${file}"

    i=0

    while IFS= read -r line

    do

        tput cup $((i)) $(((width / 2) + (offset) - 50))

        echo "$line"

        ((i++))

    done < "$input"



}



redraw() {

    
    
    if $isDigital
    then

    clear

    cal

    

    curl wttr.in/$location?0 --silent --max-time 3 > /tmp/weathernow



    readarray weatherArray < /tmp/weathernow

    rm -f /tmp/weathernow

    # Was valid weather report found or an error message?

    if [[ "${weatherArray[0]}" == "Weather report:"* ]] ; then

        echo "${weatherArray[@]}"

    else

        echo "+========================+"

        echo "|Weather can't be reached|"

        echo "|                        |"

        echo "|                        |"

        echo "|                        |" 

        echo "+========================+"

        echo " "

    fi


    now=$(date +"%T")

    digit1=${now:0:1}

    digit2=${now:1:1}

    digit3=${now:3:1}

    digit4=${now:4:1}

    digit5=${now:6:1}

    digit6=${now:7:1}



    drawDigit $digit1 0 

    drawDigit $digit2 15

    drawDigit : 30 

    drawDigit $digit3 41     

    drawDigit $digit4 56 

    drawDigit : 71 

    drawDigit $digit5 82

    drawDigit $digit6 97 



    while true

    do

        trap break WINCH

        tput cup 16 0


        now=$(date +"%T")



        if [[ digit1 -ne ${now:0:1} ]]

        then

            digit1=${now:0:1}

            drawDigit $digit1 0 

        fi





        if [[ digit2 -ne ${now:1:1} ]]

        then

            digit2=${now:1:1}

            drawDigit $digit2 15 

        fi





        if [[ digit3 -ne ${now:3:1} ]]

        then

            digit3=${now:3:1}

            drawDigit $digit3 41

        fi





        if [[ digit4 -ne ${now:4:1} ]]

        then

            digit4=${now:4:1}

            drawDigit $digit4 56 

        fi



        if [[ digit5 -ne ${now:6:1} ]]

        then

            digit5=${now:6:1}

            drawDigit $digit5 82

        fi



        if [[ digit6 -ne ${now:7:1} ]]

        then

            digit6=${now:7:1}

            drawDigit $digit6 97 

            tput cup 16 0

        fi

    read -t 1 -n 1
    if [ $? = 0 ]
    then
        tput cup 16 0
        exit
    fi


 

    done
    sleep 0.5

    else
    ./tclock

    exit
    fi

    redraw    

    

}



redraw

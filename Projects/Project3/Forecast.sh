# Written by Jacob Strebel Updated 12/02/2022

# Weather URLs for corresponding locations:
# Adams County, OH: http//wttr.in/Adams+County+Ohio?format=j1
# Cincinnati, OH: http://wttr.in/Cincinnati?format=j1
# Maysville, KY: http://wttr.in/Maysville?format=j1

url="http://wttr.in/Cincinnati?format=j1" #Change this URL to change the location of the weather data.
json="$(wget -qO- "$url")" #Calls the URL so we only request the weather data once when we run it.

Area=$(echo $json|jq -r ."nearest_area[0]|(.areaName[0].value)") #Area varriable I might use in the future.
CurrTemp=$(echo $json|jq -r ."current_condition[0]|(.temp_F)") #Current tempature variable gets the current tempature.
CurrDesc=$(echo $json|jq -r ."current_condition[0]|(.weatherDesc[0].value)") #Current description variable, gets the description of the weather. (i.e. sunny, rainy, foggy, etc.)
CurrCloud=$(echo $json|jq -r ."current_condition[0]|(.cloudcover)") #Current cloud coverage variable, tells what percent of the sky is currently covered by clouds.
CurrHumid=$(echo $json|jq -r ."current_condition[0]|(.humidity)") #Current hummidity variable, tells the current humidity percent. Humidity is measured by Dewpoint/Tempature.
TngtTemp=$(echo $json|jq -r ."weather[0]|(.hourly[7].tempF)") #Tonight tempature variable, tells what the tempature will be or was at 9:00 P.M. on the day the script was ran.
TngtDesc=$(echo $json|jq -r ."weather[0]|(.hourly[7].weatherDesc[0].value)") #Tonight description variable, gives a description of what the weather will be like at 9:00 P.M. on the day the script is ran.
TngtCloud=$(echo $json|jq -r ."weather[0]|(.hourly[7].cloudcover)") #Tonight cloud coverage variable, tells what percent of the sky will be covered by clouds at 9:00 P.M. on the day the script is ran.
TngtHumid=$(echo $json|jq -r ."weather[0]|(.hourly[7].humidity)") #Tonight humiditiy variable, tells what the humidity will be at 9:00 P.M. on the day the script is ran.
TngtMoonPhase=$(echo $json|jq -r ."weather[0]|(.astronomy[0].moon_phase)") #Tonight moon phase variable, tells what the moon phase will be when it rises.
TngtMoonIllumination=$(echo $json|jq -r ."weather[0]|(.astronomy[0].moon_illumination)") #Tonight moon illumination, tells what percent the moon will be illuminated when it rises.
MoonRise=$(echo $json|jq -r ."weather[0]|(.astronomy[0].moonrise)") #This is the time the moon rises on the day the scripit is ran.
MoonSet=$(echo $json|jq -r ."weather[0]|(.astronomy[0].moonset)") #This is the time the moon sets on the day the scripit is ran.
NextMoonRise=$(echo $json|jq -r ."weather[1]|(.astronomy[0].moonrise)") #If the moon was to not rise on the day the script is ran it will go to technically the next day in the morning.
NextMoonSet=$(echo $json|jq -r ."weather[1]|(.astronomy[0].moonset)") #If the moon was to not set on the day the script is ran it will go to technically the next day in the morning.


#Color and Style Library
default=`echo -en "\e[39m"`
red=`echo -en "\e[31m"`
yellow=`echo -en "\e[33m"`
green=`echo -en "\e[32m"`
blue=`echo -en "\e[34m"`

bold=`echo -en "\e[1m"`
normal=`echo -en "\e[0m"`


#Calculates the overall Viewing quality.
Overall=$((100 - (100 * ($TngtCloud + ($TngtMoonIllumination * 4/10) + ($TngtHumid * 1/10) ) / 100) ))

#Sets the Overall varaible to 0 if the calcualtion returns a negative.
if [[ $Overall < 0 ]]
  then
    Overall="0"
fi

#If statement that assigns a descriptive value of great, average, or poor and color for the veiwing quality.
if [[ $Overall > 70 ]]
  then
    Dignify="${green}great${default}"
  elif [[ $Overall > 35 ]]
  then
    Dignify="${yellow}average${default}"
  else
    Dignify="${red}poor${default}"
fi

#Calculates when the moon rises in seconds.
if [[ $MoonRise == "12"****** && $MoonRise == ******"AM" ]]
    then
        MoonRiseSec=$(echo $MoonRise | awk -F: '{ print ($2 * 60) + $3 }')
    elif [[ "12:59 PM" < $MoonRise && $MoonRise == ******"PM" ]]
    then
        MoonRiseSec=$(echo $MoonRise | awk -F: '{ print (12 * 3600) + ($1 * 3600) + ($2 * 60) + $3 }')
    elif [[  $MoonRise < "12:00 PM" && $MoonRise == ******"PM" ]]
    then
        MoonRiseSec=$(echo $MoonRise | awk -F: '{ print (12 * 3600) + ($1 * 3600) + ($2 * 60) + $3 }')
    else
        MoonRiseSec=$(echo $MoonRise | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
fi

#Calculates when the moon sets in seconds.
if [[ $MoonSet == "12"****** && $MoonSet == ******"AM" ]]
    then
        MoonSetSec=$(echo $MoonSet | awk -F: '{ print ($2 * 60) + $3 }')
    elif [[ "12:59 PM" < $MoonSet && $MoonSet == ******"PM" ]]
    then
        MoonSetSec=$(echo $MoonSet | awk -F: '{ print (12 * 3600) + ($1 * 3600) + ($2 * 60) + $3 }')
    elif [[  $MoonSet < "12:00 PM" && $MoonSet == ******"PM" ]]
    then
        MoonSetSec=$(echo $MoonSet | awk -F: '{ print (12 * 3600) + ($1 * 3600) + ($2 * 60) + $3 }')
    else
        MoonSetSec=$(echo $MoonSet | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
fi

#Determines if the moon rises or sets on the same day.
if [[ $MoonSet == "No moonset" ]]
    then
        MoonOutcome=$"Today the moon rises at $bold$MoonRise$normal and the moon sets tomorrow at $bold$NextMoonSet$normal."
    elif [[ $MoonRise == "No moonrise" ]]
    then
        MoonOutcome=$"Because the moon rose late last night there will be no moon rise today. The moon will set at $bold$MoonSet$normal."
    elif [[ $MoonRiseSec -lt $MoonSetSec ]]
    then 
       MoonOutcome=$"Today the moon rises at $bold$MoonRise$normal and the moon sets at $bold$MoonSet$normal."
    else
       MoonOutcome=$"Today the moon rises at $bold$MoonRise$normal and the moon sets tomorrow at $bold$NextMoonSet$normal."
fi

#These are the output commands.
echo "Weather:"
echo "Currently, the weather is $bold$CurrTemp*F$normal and $bold$CurrDesc$normal. The total cloud coverage of the sky is $bold$CurrCloud%$normal and the humidity is $bold$CurrHumid%$normal."
echo "At 9:00 P.M. the forecast is $bold$TngtTemp*F$normal and $bold$TngtDesc$normal. There will be $bold$TngtCloud%$normal of cloud coverage and the humidity level will be $bold$TngtHumid%$normal."
echo ""
echo "Astronomy:"
echo "$MoonOutcome The moon will be in the $bold$TngtMoonPhase$normal phase and will be $bold$TngtMoonIllumination%$normal illuminated."
echo "Overall the viewing quality for tonight is $bold$Overall%$normal. I would classify this night as $bold$Dignify$normal night to observe."
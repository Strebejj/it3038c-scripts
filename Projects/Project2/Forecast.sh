# Written by Jacob Strebel Updated 10/29/2022

# Weather URLs for corresponding locations:
# Adams County, OH: http//wttr.in/Adams+County+Ohio?format=j1
# Cincinnati, OH: http://wttr.in/Cincinnati?format=j1
# Maysville, KY: http://wttr.in/Maysville?format=j1

url="http://wttr.in/Cincinnati?format=j1" #This is the area you change the URL with the coresponding URL.
json="$(wget -qO- "$url")"

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


Overall=$(( 100 - 100 * ($TngtCloud + $TngtMoonIllumination / 2 + $TngtHumid / 3) / 188)) #Calculates the overall viewing quality.

#If statement that assigns a descriptive value of great, average, or poor for the veiwing quality.
if [[ $Overall > 70 ]]
  then
    Dignify="great"
elif [[ $Overall > 35 ]]
  then
    Dignify="average"
else
    Dignify="poor"
fi

#These are the output commands.
echo "Currently, the weather is $CurrTemp*F and $CurrDesc. The total cloud coverage of the sky is $CurrCloud% and the humidity is $CurrHumid%."
echo "At 9:00 P.M. the forecast is $TngtTemp*F and $TngtDesc. There will be $TngtCloud% of cloud coverage and the humidity level will be $TngtHumid%."
echo "Tonight the moon will be in the $TngtMoonPhase phase and will be $TngtMoonIllumination% illuminated."
echo "Overall the viewing quality $Overall%. I would classify this night as $Dignify night to observe."

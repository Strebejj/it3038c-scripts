# I have taken a recent intrest in astronomy. The only problem with astronomy is that it is weather dependent.To figure out if the weather will be a good for a night of observing I use a multitude of different websites. This script will output all the information necessary for me to determine if tonights night is a good night for some observing.

# GOAL: Write a script that will determin if the night is a good night for stargazing.
# INSTRUCTIONS: Download this file and run. wget and jq need to be installed for script to run. Current weather can only be updated every 4 hours. When script is ran it will take 4 hours before current weather will be able to fetch new weather data. Current weather will display the same data until 4 hours have passed from inital run. The current weather location is set to Cincinnati for accuracy. To change weather location from the 'url' variable delete 'Cincinnati' and it should use you location based off your IP if ran in console.

# Weather URLs for corresponding locations:
# Adams County, OH: http//wttr.in/Adams+County+Ohio?format=j1
# Cincinnati, OH: http://wttr.in/Cincinnati?format=j1
# Maysville, KY: http://wttr.in/Maysville?format=j1

url="http://wttr.in/Cincinnati?format=j1"
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
TngtMoonPhase=$(echo $json|jq -r ."weather[0]|(.astronomy[0].moon_phase)")
TngtMoonIllumination=$(echo $json|jq -r ."weather[0]|(.astronomy[0].moon_illumination)")


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

# Overall, I feel this script automates everything I would need to know to determine if it would be a good night to observe.
# In this phase of this project I added some variables for the moon, such as the phase and illumination as it can effect observing. I also added an if statment that alerts the user if it is a full moon or new moon.
# In the final phase of this project I would like to add a color scale to the variable outputs and bold areas of the output to enhance readability.

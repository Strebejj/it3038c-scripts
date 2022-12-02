INSPIRATION: 
I have taken a recent intrest in astronomy. The only problem with astronomy is that it is weather dependent.
To figure out if the weather will be a good for a night of observing I use a multitude of different websites.
This script will output all the information necessary for me to determine if tonights night is a good night for some observing.

GOAL:
Write a script that will determine if the night is a good night for stargazing.

INSTRUCTIONS:
Download this file and run. wget, awk, and jq need to be installed for script to run.

SIDE NOTE:
Current weather can only be updated every 4 hours. When script is ran it will take 4 hours before current weather will be able 
to fetch new weather data. Current weather will display the same data until 4 hours have passed from inital run. The current 
weather location is set to Cincinnati for accuracy. To change weather location from the 'url' variable delete 'Cincinnati' and 
it should use you location based off your IP if ran in console.

LOCATIONS:
Adams County, OH: http//wttr.in/Adams+County+Ohio?format=j1
Cincinnati, OH: http://wttr.in/Cincinnati?format=j1
Maysville, KY: http://wttr.in/Maysville?format=j1

PAST AND FUTURE UPDATES:
In the first phase I added the basic variables needed to determine if it would be a good night for observing. I added variables for 
the current weather and weather at 9:00 P.M. on the day the script was ruan such as the tempature, conditions, and humidity. I also 
made a formula to determine the viewing quality.

In the second phase I added more variables to help determine if it would be a good night for observing. I added variables for the 
moon phase and moon illumation. I also adjusted the veiwing quality formula to account for my new varriables.

In the thrid phase I made a lot of changes. The first noticeable change I made was make the output more readable. Variables of the 
output are displayed in bold and the text color changes depending on the overall vewing quality. Green for great, yellow for average, 
and red for poor. I also added in when the moon rises and sets. This was a much more difficult task than I originally thought it would 
be. Depending on the day the moon can rise and set in the same day, set from the night before then rise in the same day and set the 
next day, have no moonrise but set from last night, and have no moonset but rise in the same day. On the day the script is ran it will 
output when the moon will rise and when that moon will set. The data I am using gives me the moon rise and set times in a 12 hour clock 
format. I built a if statement that calculates the time in seconds to determine which comes first in the day the moon rise or moon set.
If the moon set came first in the day I built another if statement that would output the moon set for the next day as that was that 
moon's set. I also refined the viewing qulaity calculation. The previous veiwing quality formula did not take cloud coverage into 
account. In essence cloud coverage is the biggest deal becuase if the sky is 100% covered the viewing quality should be 0%. However, if 
the cloud coverage is 50% and the other variables are average it viewing quality should be 40% or resemble something close. In the old 
formula if cloud coverage was 100% and the other variables were 0% the viewing quality would be 54%. With the new formula if the cloud
coverage is 100% the viewing quality is instantly set to 0%. Now the formula is depent on the cloud coverage. The other varriables have
the ability to swing the viewing quality by 50%. For example if the cloud coverage was 0% and the other variables were set to 100% the 
vewing quality would be 50%. This formula is more accurate than the last one simply due to cloud coverage being the biggest factor when
it comes to astronomy.

SUMMARY:
Overall, I feel this script automates everything I would need to know to determine if it would be a good night to observe. I think I have
imporoved all the areas that I thought were weak before and very happy with the outcome of the final project. I can confidently say this
is my polished final project.
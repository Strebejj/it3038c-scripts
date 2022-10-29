INSPIRATION: 
I have taken a recent intrest in astronomy. The only problem with astronomy is that it is weather dependent.
To figure out if the weather will be a good for a night of observing I use a multitude of different websites.
This script will output all the information necessary for me to determine if tonights night is a good night for some observing.

GOAL:
Write a script that will determin if the night is a good night for stargazing.

INSTRUCTIONS:
Download this file and run. wget and jq need to be installed for script to run.

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

In the second phase I added more variables to help determin if it would be a good night for observing. I added variables for
the moon phase and moon illumation. I also addjusted the veiwing quality formula to account for my new varriables.

In the thrid phase I would like to make the output more readable. I would like to adjust some of the variable outputs to be displayed
in bold so readability is increased. I would also like to add variables about when the moon rises and sets for that given day.

SUMMARY:
Overall, I feel this script automates everything I would need to know to determine if it would be a good night to observe. I think
one area I could improve is the viewing quality formula. I'm no math major but I am trying to figure out a way to set a weight
associated with the variables. In essence cloud coverage is the biggest deal becuase if the sky is 100% covered the viewing quality
should be 0%. However, if the cloud coverage is 50% and the other variables are average it viewing quality should be 40% or resemble
something close. The problem I am running into is that the formula is not linear. I hope to come up with a better formula by the end
of the thrid phase of this project.
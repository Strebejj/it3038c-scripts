#1.
import datetime
while True:
    try:
        bday = input("Please enter your birthdate in the following format (mm/dd/yyyy): ")
        birthday = datetime.datetime.strptime (bday, '%m/%d/%Y')
        break
    except:
        print("Please put in the Format 'Month Day Year' without any initaial space.")

tday = datetime.datetime.today()
timedelta = (tday - birthday).total_seconds()
print("You have been alive for", int(timedelta), "seconds.")

#2.
print()
word = input("Please enter a word: ")
vowels = 0
consonants = 0
word.lower()

for i in word:
    if(ord(i) == 65 or ord(i) == 69 or ord(i) == 73
       or ord(i) == 79 or ord(i) == 85
       or ord(i) == 97 or ord(i) == 101 or ord(i) == 105
       or ord(i) == 111 or ord(i) == 117):
        vowels = vowels + 1
    elif((ord(i) >= 97 and ord(i) <= 122) or (ord(i) >= 65 and ord(i) <= 90)):
        consonants = consonants + 1
 
print("Total Number of Vowels in this word = ", vowels)
print("Total Number of Consonants in this word = ", consonants)

#3.
print ()
def count_Primes_nums(n):
    ctr = 0
    
    for num in range(n):
        if num <= 1:
            continue
        for i in range(2, num):
            if (num % i) == 0:
                break
        else:
            ctr += 1
    return ctr

RandomNumber = input("Please enter a positive number: ")
print("There are", count_Primes_nums(int(RandomNumber)), "prime numbers before the number", RandomNumber)

#4.
print()
import random

lower = 1
upper = 10
x = random.randint(lower, upper)
guess = int(input("I am thinking of a number between 1 and 10. Take a guess: "))

while guess != x:
  if x > guess:
    guess = int(input("Your guess was to small. Guess again: "))
  elif x < guess:
    guess = int(input("Your guess was to high. Guess again: "))

print("Congratulations you guessed it!")
import json
import requests

print('Please enter your zip code:')
zip = input()

r = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=%s,us&appid=9730eeb10d1964ee86d19e38cce38b3f' % zip)
data=r.json()
print(data['weather'][0]['description'])
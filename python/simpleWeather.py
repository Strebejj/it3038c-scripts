import json
import requests

r = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=45244,us&appid=9730eeb10d1964ee86d19e38cce38b3f')
data=r.json()
print(data)
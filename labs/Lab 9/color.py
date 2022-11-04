import json
from tokenize import Name
import json
import requests

r = requests.get('http://localhost:3000')
data=r.json()

Name0 = data[0]['name']
Name1 = data[1]['name']
Name2 = data[2]['name']
Name3 = data[3]['name']

print(Name0.capitalize() + " is " + data[0]['color'] + ".")
print(Name1.capitalize() + " is " + data[1]['color'] + ".")
print(Name2.capitalize() + " is " + data[2]['color'] + ".")
print(Name3.capitalize() + " is " + data[3]['color'] + ".")
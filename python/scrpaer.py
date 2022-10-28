import requests
from bs4 import BeautifulSoup

#We need a header to that there will be a response to our reqest.
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36'}

def weather_info(city):
    city = city.replace(" ", "+")
    res = requests.get(
        f'https://www.google.com/search?q={city}&hl=en',
        headers=headers)
    soup = BeautifulSoup(res.text, 'html.parser')

    location = soup.select('#wob_loc')[0].getText()
    time = soup.select('#wob_dts')[0].getText()
    info = soup.select('#wob_dc')[0].getText()
    weather = soup.select('#wob_tm')[0].getText()
    print("The weather in", location, "at", time, "is", info, "and", weather+"°F")

weather_info("Cincinnati Weather")
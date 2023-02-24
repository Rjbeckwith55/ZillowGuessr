# coding: utf-8
# Web scraping Zillow

import pandas as pd
import requests
from bs4 import BeautifulSoup

import json
header = {'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*,q=0.8',
          'accept-encoding': 'gzip, deflate, br',
          'accept-language': 'en-US,en;q=0.8',
          'upgrade-insecure-requests': '1',
          'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36'
          }

city = 'Peoria'
# Enter Zillow URL for the city of your preference
url = f'https://www.zillow.com/homes/for_sale/{city}'
html = requests.get(url=url, headers=header)
json_string = html.content
# print(json_string)
# json_obj = json.loads(json_string)
with open("jsondata.json", 'wb') as f:
    f.write(json_string)
    # json.dumps(f, json_obj, indent=4)

# bsobj - Beautiful Soup Object``
soup = BeautifulSoup(html.content, 'html.parser')

# price list is a list variable that will contain the price information.
df = pd.DataFrame()
df1 = pd.DataFrame()
price_list = []
for i in soup:
    json_payload = soup.select(
        'script[data-zrr-shared-data-key="mobileSearchPageStore"]')
    print(len(json_payload))
    json_only = str(json_payload[0]).split(
        '>')[1].replace("<!--", "").replace('}}--', '}}').replace('\\"','"')
    print(json_only)
    json_only = json.loads(json_only)
    with open("jsondata.json", 'w') as f:
        json.dump(json_only, f, indent=4)
    break
    price = list(soup.find_all(class_='list-card-price'))
    beds = list(soup.find_all('ul', class_='list-card-details'))
    details = soup.find_all('div', class_='list-card-details')
    home_type = soup.find_all('div', class_='list-card-footer')
    last_updated = soup.find_all('div', class_='list-card-top')
    brokerage = list(soup.find_all(
        class_='list-card-brokerage list-card-img-overlay', text=True))
    link = soup.find_all(class_='list-card-link')

    df['prices'] = price
    df['address'] = address
    df['beds'] = beds

    df['prices'] = df['prices'].astype('str')
    df['address'] = df['address'].astype('str')
    df['beds'] = df['beds'].astype('str')

    # df = df[['prices', 'address', 'links','beds', 'baths', 'sq_feet']]

    df1.append(df)

print(df)
df.to_csv('data.csv')

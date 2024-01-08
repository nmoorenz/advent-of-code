"""
Get the input from a particular day
"""

import requests
import sys

# anything with data* is private due to gitignore
with open('data-session-cookie.txt') as f: 
    cook = f.read()

# required arguments
year = sys.argv[1]
day = sys.argv[2]

url = f'https://adventofcode.com/{year}/day/{day}/input'

inp = requests.get(url, cookies={"session": cook})

# print(inp.text)

# overwrite, assume we are only calling once though
with open(f'{year}/data-{year}-{day}.txt', 'w') as f:
    f.write(inp.text[:-1])


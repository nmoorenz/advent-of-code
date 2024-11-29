"""
Get the input from a particular day for advent of code

Run with: 
py get-input.py 2023 1

Requires a cookie from Advent of Code website
Save that in a file called session-cookie.txt
That file is included in .gitignore

https://github.com/wimglenn/advent-of-code-wim/issues/1

"""

import requests
import sys

# used to authenticate with AoC
with open('session-cookie.txt') as f: 
    cook = f.read()

# required arguments
year = sys.argv[1]
day = sys.argv[2]

url = f'https://adventofcode.com/{year}/day/{day}/input'

inp = requests.get(url, cookies={"session": cook})

# print(inp.text)
dd = f'{int(day):02d}'

# overwrite, assume we are only calling once though
with open(f'{year}/data-{year}-{dd}.txt', 'w') as f:
    f.write(inp.text[:-1])


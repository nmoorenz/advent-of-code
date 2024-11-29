"""

This script uses the get-input.py to get all the input from a year
Used for history purposes
Also because this is a new repository with solutions only and not verbatim problem text

Run with: 
py get-all-input.py 2023

"""

# import os
import sys
import time
import subprocess

year = sys.argv[1]

i = 1
while i <= 25:
    time.sleep(2)
    subprocess.run(['python', 'get-input.py', year, str(i)])
    i += 1

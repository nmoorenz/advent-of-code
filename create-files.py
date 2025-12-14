"""

Create the folder and qmd files for solutions for each day of the new year 
Do this once per year, and collect the input files with get-input.py
The template.qmd file is used to generate daily solution files, 
including the input data import. 

Run with: 
py create-files.py 2024

"""
import sys
import os 

year = sys.argv[1]

# create folder for the year 
if not os.path.exists(year):
    os.makedirs(year)
    
# read in the template
with open(f'template.qmd', 'r') as f:
    qmd_file = f.read()

# loop through and create text files
for i in range(1, 26):
    with open(f"{year}/data-{year}-{i:02d}.txt", "w") as f:
        pass
    with open(f"{year}/{year}-{i:02d}.qmd", "w") as f:
        f.write(qmd_file.format(x=i, year=year, python="{python}"))

# create the overall readme file with notes for each day and part
readme = """
### Day {i}

1.  
2.  

-   
-   

"""

# pre-formatted readme to describe each day's attempt
with open(f'{year}/README-{year}.md', 'w') as f:
    f.write(f"## Advent of Code {year}")
    for i in range(1, 26):
        f.write(readme.format(i=i))

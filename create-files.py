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
days = 25

# create folder for the year 
if not os.path.exists(year):
    os.makedirs(year)
    
# read in the template
with open(f'template.txt', 'r') as f:
    qmd_file = f.read()

# loop through and create text files
for i in range(1, days+1):
    this_txt = f"{year}/data-{year}-{i:02d}.txt"
    this_qmd = f"{year}/{year}-{i:02d}.qmd"
    if not os.path.exists(this_txt):
        with open(this_txt, "w") as f:
            pass
    if not os.path.exists(this_qmd):
        with open(this_qmd, "w") as f:
            f.write(qmd_file.format(x=i, year=year, python="{python}"))

# create the overall readme file with notes for each day and part
readme = """
[Day {i}]({year}-{i:02d}.qmd)

1.  
2.  

-   
-   

"""

# pre-formatted readme to describe each day's attempt
with open(f'{year}/index-{year}.qmd', 'w') as f:
    f.write(f"---\ntitle: Advent of Code {year}\n")
    f.write(f"---\n\n## Solutions for {year}\n")
    for i in range(1, days+1):
        f.write(readme.format(i=i, year=year))

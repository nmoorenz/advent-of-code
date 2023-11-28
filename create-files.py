
# do this once per year 
yr = '2023'

# loop through and create text files
for i in range(1, 26):
    with open(f"{yr}/data-{yr}-{i:02d}.txt", "w") as f:
        pass

# read in the template
with open(f'template.qmd', 'r') as f:
    qmd_file = f.read()

# use the template with some variables
for i in range(1, 26):
    with open(f"{yr}/{yr}-{i:02d}.qmd", "w") as f:
        f.write(qmd_file.format(x=i, yr=yr, python="{python}"))

# create the overall readme file with notes for each day and part
readme = """

### Day {i}

1.  
2.  

-   
-  

"""

# pre-formatted readme to describe each day's attempt
with open(f'{yr}/README.md', 'a') as f:
    f.write(f"## Advent of Code {yr}")
    for i in range(1, 26):
        f.write(readme.format(i=i))


# loop through and create text files
for i in range(13, 26):
    with open(f"2015/data-2015-{i:02d}.txt", "w") as f:
        pass


with open('2015/2015-template.qmd', 'r') as f:
    qmd_file = f.read()


for i in range(13, 26):
    with open(f"2015/2015-{i:02d}.qmd", "w") as f:
        f.write(qmd_file.format(x=i, python="{python}"))


readme = """

### Day {i}

1.  
2.  

-   
-  

"""

with open('2015/README.md', 'a') as f:
    for i in range(13, 26):
        f.write(readme.format(i=i))

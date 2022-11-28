
# loop through and create text files
for i in range(1, 26):
    with open(f"2022/data-2022-{i:02d}.txt", "w") as f:
        pass


with open('2022/2022-template.qmd', 'r') as f:
    qmd_file = f.read()


for i in range(1, 26):
    with open(f"2022/2022-{i:02d}.qmd", "w") as f:
        f.write(qmd_file.format(x=i, python="{python}"))


readme = """

### Day {i}

1.  
2.  

-   
-  

"""

with open('2022/README.md', 'a') as f:
    for i in range(1, 26):
        f.write(readme.format(i=i))

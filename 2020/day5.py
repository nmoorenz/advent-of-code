
# read file
with open("2020/day5.txt", "r") as f:
  bp = f.read().splitlines()

# row and col binary via replacement
row = [x[:7].replace("B", "1").replace("F", "0") for x in bp]
col = [x[7:].replace("L", "0").replace("R", "1") for x in bp]

# id as a combo of row and col            
id = [int(r, 2) * 8 + int(c, 2) for r, c in zip(row, col)]

#part a
max(id)
# part b
set(range(min(id), max(id))) - set(id)

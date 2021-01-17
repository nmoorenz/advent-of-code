# find the numbers that sum to 2020 and return their product

# not quite as good as here::here()
myfile = "2020/day1.txt"

# read in file
with open(myfile, "r") as f:
  my_input = f.read().splitlines()

# want integer not strings
my_input = [int(i) for i in my_input]

# probably a good idea
my_input.sort()

# for loops
for x in my_input:
  for y in my_input:
    if x + y == 2020:
      print(x * y)

# itertools
import itertools

for x, y in itertools.product(my_input, my_input):
  if x + y == 2020:
    print(x * y)
    break

# generator
for x, y in ((xx, yy) for xx in my_input for yy in my_input):
  if x + y == 2020:
    print(x * y)
    break

# triple threat
for x, y, z in itertools.product(my_input, my_input, my_input):
  if x + y + z == 2020:
    print(x * y * z)
    break



# stolen from Python from R slack
# Zach Ingbretsen

def find_sum_combs(inputs, total=2020, n=2):
    for comb in itertools.combinations(inputs, n):
        if sum(comb) == total:
            return comb
            

x, y = find_sum_combs(my_input)
print(x*y)

x, y, z = find_sum_combs(my_input, n=3)
print(x*y*z)

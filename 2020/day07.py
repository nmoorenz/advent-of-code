
# read file
with open("2020/day07.txt", "r") as f:
  bags = f.read().splitlines()

# my main bag  
my_bag = "shiny gold"

# function for splitting 
def bags_split(rr):
  first, other = rr.split(' bags contain ')
  other_bags = other.split(',')
  return first, other_bags

# list of the bags information
bags_list = [bags_split(bb) for bb in bags]



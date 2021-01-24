
# read file
with open("2020/day02.txt", "r") as f:
  dd = f.read().splitlines()
  
# split with spaces
# split lo and hi
# integers!
# don't want the colon
def get_things(line):
  nums, lett, pw = line.split()
  lo, hi = nums.split("-")
  lo = int(lo)
  hi = int(hi)
  lett = lett.strip(":")
  return lo, hi, lett, pw
  
# list comprehend that business
my_lines = [get_things(d) for d in dd]

# count how many things and check
def count_letters(lo, hi, lett, pw):
  cnt = pw.count(lett)
  return (lo <= cnt and cnt <= hi)
  
# do the check and sum
count_a = [count_letters(*line) for line in my_lines]
sum(count_a)

# see if the position contains the letter
# but only one of the positions
def letter_pos(lo, hi, lett, pw): 
  mt_lo = pw[lo-1] == lett
  mt_hi = pw[hi-1] == lett
  return (mt_lo ^ mt_hi)

# do the check
count_pos = [letter_pos(*line) for line in my_lines]
sum(count_pos)

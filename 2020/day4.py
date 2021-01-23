
# read file
with open("2020/day4.txt", "r") as f:
  pp = f.read()
  
# split by double end to separate passports
pp_split = pp.split("\n\n")

# separate items in each passport
pp_split = [x.replace("\n", " ") for x in pp_split]

# mandatory items 
mando = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

# count how many are good
# this could be list comprehension, maybe
yes = []
for p in pp_split:
  z = 0
  for m in mando:
    if m in p:
      z += 1
  yes.append(z)
  
# sum those up for part one
cnt = sum([y == 7 for y in yes])


# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
#   If cm, the number must be at least 150 and at most 193.
#   If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

import re

def check_items(p, m):
  # result for function
  result = True
  # get the required thing
  patt = m + ':(#?[0-9a-z]+)'
  itm = re.search(patt, p)
  # print(p)
  # print(m)
  # print(itm)
  # get out straight away if the field is not there
  if itm is None:
    result = False
  else: 
    itm = itm.group(1)
    try: 
      ii = int(re.search('\\d+', itm).group(0))
    except: 
      ii = 0
    
    # check it against rules
    if m == 'byr':
      result = (1920 <= ii and ii <= 2002)
    elif m == 'iyr':
      result = (2010 <= ii and ii <= 2020)
    elif m == 'eyr':
      result = (2020 <= ii and ii <= 2030)
    elif m == 'hgt':
      if "in" in itm:
        result = (59 <= ii and ii <= 76)
      elif "cm" in itm:
        result = (150 <= ii and ii <= 193)
      else: 
        result = False
    elif m == 'hcl':
      hh = "#[0-9a-f]{6}"
      res = re.search(hh, itm)
      if res is None: result = False
    elif m == 'ecl':
      result = (itm in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth',])
    elif m == 'pid':
      result = len(itm) == 9 and itm.isnumeric()
  print(result)
  # return, of course  
  return result
  
  
# loop through the list
# loop through items
yes = []
for p in pp_split:
  p = p.lower()
  z = True
  for m in mando:
    y = check_items(p, m)
    z = z and y
  yes.append(z)
  
# part two answer
cnt = sum([y for y in yes])

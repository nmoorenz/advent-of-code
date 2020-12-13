
# read file
with open("day4.txt", "r") as f:
  pp = f.read()
  
pp_split = pp.split("\n\n")

pp_split = [x.replace("\n", " ") for x in pp_split]

mando = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

yes = []
for p in pp_split:
  z = 0
  for m in mando:
    if m in p:
      z += 1
  yes.append(z)
  
cnt = sum([y == 7 for y in yes])


# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
#   If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

import re

def check_items(p, m):
  # get the required thing
  patt = m + ':(#?.+)'
  itm = re.match(patt, p)
  if itm is None:
    return False
  itm = itm.group(1)
  ii = int(itm)
  ii = ''.join(filter(str.isdigit, itm))

  # check it against rules
  if m == 'byr':
    return 1920 <= ii and ii <= 2002
  elif m == 'iyr':
    return 2010 <= ii and ii <= 2020
  elif m == 'eyr':
    return 2020 <= ii and ii <= 2030
  elif m == 'hgt':
    if "in" in itm:
      return 59 <= ii and ii <= 76
    elif "cm" in itm:
      return 150 <= ii and ii <= 193
    else: 
      return False
  elif m == 'hcl':
    
  elif m == 'ecl':
    return itm in [amb blu brn gry grn hzl oth]
  elif m == 'pid':
    return len(itm)
  
  
  
  
  
  
# loop through the list
# loop through items
yes = []
for p in pp_split:
  z = True
  for m in mando:
    z = z and check_item(p, m)
  yes.append(z)
  



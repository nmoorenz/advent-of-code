
# read file
with open("2020/day6.txt", "r") as f:
  qq = f.read()

# split groups
qq_split = qq.split("\n\n")

# replace \n with nothing, since we're interested in group as a whole
# set provides us with unique items
# len gives us how many answers
part_one = [len(set(x.replace("\n", ""))) for x in qq_split]

# part one answer
sum(part_one)

####### part two
qq_groups = [x.replace("\n", " ") for x in qq_split]

# how many people are there in each group? 
qq_num = [x.count(" ")+1 for x in qq_groups]

# https://stackoverflow.com/questions/1155617/count-the-number-occurrences-of-a-character-in-a-string
from collections import Counter

# do the count
counter = [Counter(x) for x in qq_groups]

# now we need to combine these with the number of groups
# count_num = [value == nn for cc, nn in zip(counter, qq_num) for value in cc.values()]
count_num = [list(cc.values()).count(nn) for cc, nn in zip(counter, qq_num)]

sum(count_num)

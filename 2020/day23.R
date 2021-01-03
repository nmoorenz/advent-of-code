library(tidyverse)

# setup
cups <- '712643589'
cups <- str_split(cups, "")[[1]] %>% as.numeric()

# moves, we'll use this later
moves <- 100

# this is the controlling thing
ind <- 1

# write the code then wrap in a loop
for (i in seq_len(moves)) {
  # current cup
  current_cup <- cups[ind]
  
  # to the right of the current cup
  # needs to wrap around when we get to the end
  # maybe two vectors is the way to go
  three_cups <- append(cups, cups)[(ind+1):(ind+3)]
  
  # this preserves the order as far as I can tell
  cups <- setdiff(cups, three_cups)

  print('extract')
  
  # destination, one less than the current cup
  good = FALSE
  dest_cup <- current_cup
  while (!good) {
    dest_cup <- dest_cup - 1
    if (dest_cup == 0) {
      dest_cup <- 9
    }
    if (!(dest_cup %in% three_cups)) {
      good = TRUE
    }
  }
  
  # location of the destination cup
  dest_loc <- match(dest_cup, cups)
  
  print('locate')
  
  # need to add the three cups back into the vector
  cups <- append(cups, three_cups, after = dest_loc)
  
  ind <- match(current_cup, cups) + 1
  if (ind == 10) {
    ind <- 1
  }

}

# the cups in order after 1
part_one = '29385746'

###################### part two

# number of cups
cup_max <- 1e6
# sequential cups for anything more than the original
extra_cups <- seq(10, cup_max)
# original input
orig_cups <- str_split('712643589', "")[[1]] %>% as.integer()
# join these things
cups <- c(orig_cups, extra_cups)
# next cups
next_cups <- c(cups[-1], cups[1])
# cup directory
cup_pos <- next_cups[order(cups)]

# large number of moves
moves <- cup_max * 10
checker = seq(moves/100, moves/100*99, by = moves/100)

# current cup
current_cup = cups[1]

# write the code then wrap in a loop
for (i in seq_len(moves)) {
  if (i %in% checker) print(i)
  
  # pickup cups
  p1 = cup_pos[current_cup]
  p2 = cup_pos[p1]
  p3 = cup_pos[p2]
  
  # destination, one less than the current cup
  good = FALSE
  dest_cup <- current_cup
  while (!good) {
    dest_cup <- dest_cup - 1
    if (dest_cup == 0) {
      dest_cup <- cup_max
    }
    if (!(dest_cup %in% c(p1, p2, p3))) {
      good = TRUE
    }
  }
  
  cup_pos[current_cup] <- cup_pos[p3]
  # current now points to where third cup was pointing, removing three cups from loop
  
  cup_pos[p3] <- cup_pos[dest_cup]
  # third now points to where destination cup was pointing
  
  cup_pos[dest_cup] <- p1
  # destination cup now points at the first cup in the pickup
  
  current_cup <- cup_pos[current_cup]
  # move pointer to where the current cup is pointing
  
}

# I don't know how this works honestly
x1 <- cup_pos[1]
x2 <- cup_pos[x1]

prod(x1,x2)

# 1,000 cups and 10,000 moves takes about two seconds
# 10,000 cups and 100,000 moves takes about one minute
# 100,000 cups and 1,000,000 moves takes about one minute for 10,000 moves
# probably means 100 minutes for the complete set
# probably means 100*100 minutes = 166 hours
# this is not a good thing

# replacing the setdiff() removed 10 seconds from 10,000 cups time
# replacing the match for destination location removed a further 15 seconds
# don't get the same answer though

# thanks Tan
# https://tanho63.github.io/advent_of_code/2020/day-23

"
The crab picks up the three cups that are immediately clockwise of the current cup. 
They are removed from the circle; cup spacing is adjusted as necessary to maintain the circle.

The crab selects a destination cup: the cup with a label equal to the current cup's label minus one. 
If this would select one of the cups that was just picked up, the crab will keep subtracting one 
until it finds a cup that wasn't just picked up. If at any point in this process the value goes below 
the lowest value on any cup's label, it wraps around to the highest value on any cup's label instead.

The crab places the cups it just picked up so that they are immediately clockwise of the destination cup. 
They keep the same order as when they were picked up.

The crab selects a new current cup: the cup which is immediately clockwise of the current cup.
"
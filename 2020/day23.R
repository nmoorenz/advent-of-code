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

part_one = '29385746'

###################### part two

cup_max <- 1e6
extra_cups <- seq(10, cup_max)
orig_cups <- str_split('712643589', "")[[1]] %>% as.numeric()

cups <- append(orig_cups, extra_cups)

# large number of moves
moves <- cup_max * 10
checker = seq(moves/100, moves/100*99, by = moves/100)

# this is the controlling thing
ind <- 1

# write the code then wrap in a loop
for (i in seq_len(moves)) {
  # current cup
  current_cup <- cups[ind]
  
  # to the right of the current cup
  # needs to wrap around when we get to the end
  # maybe two vectors is the way to go
  three_cups <- append(cups, cups[1:10])[(ind+1):(ind+3)]
  
  if (i %in% checker) print(i)
  
  # this preserves the order as far as I can tell
  cups <- setdiff(cups, three_cups)
  
  # destination, one less than the current cup
  good = FALSE
  dest_cup <- current_cup
  while (!good) {
    dest_cup <- dest_cup - 1
    if (dest_cup == 0) {
      dest_cup <- cup_max
    }
    if (!(dest_cup %in% three_cups)) {
      good = TRUE
    }
  }
  
  # location of the destination cup
  dest_loc <- match(dest_cup, cups)
  
  # need to add the three cups back into the vector
  cups <- append(cups, three_cups, after = dest_loc)
  
  ind <- match(current_cup, cups) + 1
  if (ind == cup_max + 1) {
    ind <- 1
  }
  
}


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
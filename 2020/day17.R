# in this script, mainly just for pipe
library(tidyverse)

# this is the way I do things now
my_file <- here::here("2020", "day17.txt")

# read to find the width of the file
test <- read.delim(my_file, header = FALSE)

# width of the thing
width = length(test$V1)

# create vector with the widths to read
ww <- rep(1, width)

# this should work to create matrix like dataframe
# hash is not good becuase it is the default comment character
conway <- read.fwf(my_file, widths = ww, comment.char = "/") %>% 
  as.matrix()

# I'd like to convert to numeric to make summation easier
for (i in seq_len(width)) {
  for (j in seq_len(width)) {
    conway[i,j] = ifelse(conway[i,j] == "#", 1, 0)
  }
}

# this is an array to start with, with numeric values
start_conway = array(sapply(conway, as.numeric), dim = c(width, width, 1))

# this is the large array to end with
# don't want to build this incrementally, I don't think
# +2 to give us room for easy indexing
big_conway = array(0, dim = c(width + 2*6 + 2, 
                              width + 2*6 + 2, 
                              1 + 2*6 + 2))

# get the starting values into the middle of the big one
big_conway[8:15, 8:15, 8] <- start_conway
# big_conway[8:10, 8:10, 8] <- start_conway

# check that numeric gives us the ability to sum sections
big_conway[ , , 8]
sum(big_conway[8:10, 8:10, 8])
i = 7
sum(big_conway[(i-1):(i+1), (i-1):(i+1), 8], na.rm = TRUE)

# loop through stages to find the expansion
for (s in seq_len(6)) {
  copy_conway <- big_conway
  for (x in seq(2, dim(big_conway)[1] - 1)){
    for (y in seq(2, dim(big_conway)[2] - 1)) {
      for (z in seq(2, dim(big_conway)[3] - 1)) {
        i_sum = sum(copy_conway[(x-1):(x+1), (y-1):(y+1), (z-1):(z+1)], na.rm = TRUE) - copy_conway[x, y, z]
        if (copy_conway[x, y, z] == 1) {
          if ((i_sum == 2 | i_sum == 3)) {
            # do nothing, stays active
          } else {
            big_conway[x, y, z] = 0
          }
        } else if (copy_conway[x, y, z] == 0 & i_sum == 3) {
          big_conway[x, y, z] = 1
        }
      }
    }
  }
}

# part one answer
sum(big_conway)

#################### part two four-dimensions

# this is the large array to end with
# don't want to build this incrementally, I don't think
# +2 to give us room for easy indexing
d4_conway = array(0, dim = c(width + 2*6 + 2, 
                             width + 2*6 + 2, 
                             1 + 2*6 + 2, 
                             1 + 2*6 + 2))

# get the starting values into the middle of the big one
d4_conway[8:15, 8:15, 8, 8] <- start_conway
# d4_conway[8:10, 8:10, 8, 8] <- start_conway

d4_conway[ , , 8, 8]

# loop through stages to find the expansion
# we could limit these sequences to a bounding box
for (s in seq_len(6)) {
  copy_conway <- d4_conway
  for (x in seq(2, dim(d4_conway)[1] - 1)){
    for (y in seq(2, dim(d4_conway)[2] - 1)) {
      for (z in seq(2, dim(d4_conway)[3] - 1)) {
        for (w in seq(2, dim(d4_conway)[4] - 1)) {
          # calculate sum for the surrounding cube
          i_sum = sum(copy_conway[(x-1):(x+1), 
                                  (y-1):(y+1), 
                                  (z-1):(z+1), 
                                  (w-1):(w+1)], na.rm = TRUE) - copy_conway[x, y, z, w]
          # if the cell is active
          if (copy_conway[x, y, z, w] == 1) {
            if ((i_sum == 2 | i_sum == 3)) {
              # do nothing, stays active
            } else {
              # too much or too little, make inactive
              d4_conway[x, y, z, w] = 0
            }
          } else if (copy_conway[x, y, z, w] == 0 & i_sum == 3) {
            # just the right conditions, becomes active
            d4_conway[x, y, z, w] = 1
          }
        }
      }
    }
  }
}

# part one answer
sum(d4_conway)

# 1708 wrong
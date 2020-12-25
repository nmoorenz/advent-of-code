# own the libs
library(tidyverse)

# flexibility in reading
my_file <- here::here("2020", "day14.txt")
bitcode <- read.delim(my_file, header = FALSE)

mem_loc <- tribble(~loc, ~orig_num, ~new_num)

# this might not be the best way but it gets the job done
do_mask <- function(mask, val) {
  mask_vector = str_split(mask, "")[[1]]
  # https://stackoverflow.com/a/12088263
  binary_vector = rev(as.numeric(intToBits(val)))
  binary_vector = append(rep(0,4), binary_vector) %>% as.character()
  
  for (b in seq_along(mask_vector)) {
    if (mask_vector[[b]] == "X") {
      binary_vector[[b]] = binary_vector[[b]]
    } else {
      binary_vector[[b]] = mask_vector[[b]]
    }
  }
  # https://stackoverflow.com/a/43140195
  new_val = Reduce(function(x,y) x*2+y, binary_vector %>% as.integer)
  return(new_val)
}



for (m in seq_len(nrow(bitcode))) {
  if (str_starts(bitcode$V1[[m]], "mask")) {
    # mask
    mask = str_replace(bitcode$V1[[m]], "mask = ", "")
  } else {
    # apply mask and store value
    loc = str_extract(bitcode$V1[[m]], "\\d{4,5}")
    val = str_extract(bitcode$V1[[m]], "\\d+$")
    new_num = do_mask(mask, val)
    mem_loc = rbind(mem_loc, list(loc=loc, orig_num=val, new_num=new_num))
  }
}

# the latest for each location
mem_reduce <- mem_loc %>% 
  mutate(rn = row_number()) %>% 
  group_by(loc) %>% 
  filter(rn == max(rn)) 

part_one <- sum(mem_reduce$new_num)
print(part_one, digits = 15)

# 6386593869035

######################## part two

do_mask_mem <- function(mask, mem, val) {
  mask_vector = str_split(mask, "")[[1]]
  binary_vector = rev(as.numeric(intToBits(mem)))
  # 4 extra zeros because intToBits() returns 32 bits, mask is 36
  binary_vector = append(rep(0,4), binary_vector) %>% as.character()
  
  # tracker
  num_x = 0
  # loop through and make changes
  # mask == 1, location bit = 1
  # mask == 0, location bit unchanged
  # mask == X, floating bit, count how many
  for (b in seq_along(mask_vector)) {
    if (mask_vector[[b]] == 1) {
      binary_vector[[b]] = 1 
    } else if (mask_vector[[b]] == 0) {
      binary_vector[[b]] = binary_vector[[b]]
    } else if (mask_vector[[b]] == "X") {
      num_x = num_x + 1
    }
  }
  print(num_x)
  # tibble the same col as what we're collecting
  new_rows <- tribble(~orig_loc, ~loc, ~num)
  
  # collect the possibilities for floating bits
  for (x in seq_len(num_x)) {
    this_loc = Reduce(function(x,y) x*2+y, binary_vector %>% as.integer)
    new_rows <- rbind(new_rows, list(orig_loc=mem, loc=this_loc, num=val))
  }
  
  return(new_rows)
}

# set back to no locations
mem_loc <- tribble(~orig_loc, ~loc, ~num)

# loop through instructions
for (m in seq_len(nrow(bitcode))) {
  if (str_starts(bitcode$V1[[m]], "mask")) {
    # get the mask
    mask = str_replace(bitcode$V1[[m]], "mask = ", "")
  } else {
    # apply mask and store value
    loc = str_extract(bitcode$V1[[m]], "\\d{4,5}")
    val = str_extract(bitcode$V1[[m]], "\\d+$")
    # instead of the new value, get back a whole dataframe
    # there are multiple rows because of 'floating' positions
    new_rows = do_mask_mem(mask, loc, val)
    # bind the rows, and get the latest for each location later
    # Might get quite large, but more efficient to stack than keep searching? 
    mem_loc = rbind(mem_loc, new_rows)
  }
}

# the latest for each location
mem_reduce <- mem_loc %>% 
  mutate(rn = row_number()) %>% 
  group_by(loc) %>% 
  filter(rn == max(rn)) 

# quite the same as part one
part_two <- sum(as.numeric(mem_reduce$num))
print(part_two, digits = 15)
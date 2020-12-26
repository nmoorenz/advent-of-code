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

######################################### part two

do_mask_mem <- function(bitmask, loc, val) {
  binary_loc = rev(as.numeric(intToBits(loc)))
  # 4 extra zeros because intToBits() returns 32 bits, mask is 36
  binary_loc = append(rep(0,4), binary_loc) %>% as.character()
  
  # tracker
  num_x = 0
  # loop through and make changes
  # mask == 1, location bit = 1
  # mask == 0, location bit unchanged
  # mask == X, floating bit, count how many
  for (b in seq_along(bitmask)) {
    if (bitmask[[b]] == 1) {
      binary_loc[[b]] = 1 
    } else if (bitmask[[b]] == 0) {
      binary_loc[[b]] = binary_loc[[b]]
    } else if (bitmask[[b]] == "X") {
      num_x = num_x + 1
      binary_loc[[b]] = "X" 
    }
  }
  # for record watching
  print(num_x)
  
  # we can collapse in anticipation of str_replace
  loc_string <- paste0(binary_loc, collapse = "")
  
  # want to make this look nice
  this_df <- bin_df %>% 
    filter(num < 2 ^ num_x) %>% 
    select(-num) %>% 
    mutate(bin = map(bin, ~ .[(10-num_x):9]))
  
  # tibble to start with
  start_rows <- tibble(loc_x = rep(loc_string, 2 ^ num_x), 
                       bin = this_df$bin, 
                       val = val)
  
  # replace X with 0 and or 1
  loc_rows <- start_rows %>% 
    mutate(loc = map2_chr(loc_x, bin, replace_x))
  
  # only want these columns
  new_rows <- select(loc_rows, loc, val)
  return(new_rows)
}

# helper function, worried about how slow this might be
replace_x <- function(loc_x, bin) {
  for (z in seq_along(bin)) {
    loc_x = str_replace(loc_x, "X", bin[z])
  }
  return(loc_x)
}

# set back to no locations
mem_loc <- tribble(~loc, ~val)

# doing this to set things up
bin_df <- tibble(num = seq(0,2^9-1))
bin_df <- bin_df %>% mutate(bin = map(num, ~ rev(as.character(as.numeric(intToBits(.)))[1:9])))

# loop through instructions
for (m in seq_len(nrow(bitcode))) {
  if (str_starts(bitcode$V1[[m]], "mask")) {
    # get the mask
    mask = str_replace(bitcode$V1[[m]], "mask = ", "")
    mask_vector = str_split(mask, "") %>% unlist()
  } else {
    # apply mask and store value
    # loc = str_extract(bitcode$V1[[m]], "\\d{2}")
    loc = str_extract(bitcode$V1[[m]], "\\d{4,5}")
    val = str_extract(bitcode$V1[[m]], "\\d+$")
    # instead of the new value, get back a whole dataframe
    # there are multiple rows because of 'floating' positions
    new_rows = do_mask_mem(mask_vector, loc, val)
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
part_two <- sum(as.numeric(mem_reduce$val))
print(part_two, digits = 15)

# 4288985857999









# check the number of rows is good
# the numbers are what I expect: 77232

num_rows <- 0

# loop through instructions
for (m in seq_len(nrow(bitcode))) {
  if (str_starts(bitcode$V1[[m]], "mask")) {
    mask = str_replace(bitcode$V1[[m]], "mask = ", "")
  } else {
    num_x = str_count(mask, "X")
    this_rows = 2 ^ num_x
    num_rows = num_rows + this_rows 
  }
}

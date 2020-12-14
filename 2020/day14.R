library(tidyverse)

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

mem_reduce <- mem_loc %>% 
  mutate(rn = row_number()) %>% 
  group_by(loc) %>% 
  filter(rn == max(rn)) 

part_one <- Reduce(`+`, mem_reduce$new_num)
print(part_one, digits = 15)

# 6386593869035
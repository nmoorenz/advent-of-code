# libs
library(tidyverse)

my_file <- here::here("2020", "day07.txt")

# read file
lugg <- read.delim(my_file, header = FALSE)

bag <- "shiny gold"

# split
lugg2 <- separate(lugg, V1, into = c("first", "other"), sep = " bags contain ") %>% 
  mutate(others = as.vector(str_split(other, ", ")))

lugg2$contains <- str_detect(lugg2$first, bag)
lugg2$level <- if_else(lugg2$contains, 1, 0)
srch_lvl <- 1

recurs_search <- function(df) {
  # things to search for
  srch_list <- df %>% 
    filter(contains == TRUE & level == srch_lvl) %>% 
    select(first) %>% 
    as.vector() 
  # increase level for efficiency (don't look twice)
  srch_lvl <<- srch_lvl + 1
  # print(srch_lvl)
  # print(length(srch_list$first))
  if (length(srch_list$first) == 0) {
    return(df)
  }
  # search for those things
  for (x in seq_along(srch_list$first)) {
    srch = srch_list$first[x]
    for (y in seq_along(df$other)) {
      if (str_detect(df$other[[y]], srch)) {
        df$contains[[y]] = TRUE
        df$level[[y]] = srch_lvl
      }
    }
  }
  # print(sum(df$contains))
  df = recurs_search(df)
}

lugg3 <- recurs_search(lugg2)

################################################### part two

# function to add rows to our collection dataframe
add_bags <- function(df, item, multi) {
  # exit early
  if (item == "no other bags.") return(df)
  # get the number from the string, but also the other number of bags containing this one
  bb = parse_number(item) * multi
  # split the string (trusting the strings are all the same)
  cc = str_split(item, " ")
  # combine 2nd and 3rd parts, again, trust in the system
  clr = paste(cc[[1]][2], cc[[1]][3])
  # the next row for our counter df
  rw = list(bags = bb, colour = clr)
  # otherwise if adding a number, add it to search for later
  df = rbind(df, rw)
  # return, of course
  return(df)
}

# initiate some variables
bag_current <- "1 shiny gold bag"
keep_going <- TRUE
bag_level <- 1

# blank dataframe
count_bags_df <- tribble(~bags, ~colour)
# this is the main part of the pattern
# loop through bags counter
count_bags_df <- add_bags(count_bags_df, bag_current, 1)

# split
lugg_part2 <- separate(lugg, V1, into = c("first", "other"), sep = " bags contain ") %>% 
  mutate(others = as.vector(str_split(other, ", ")))

# loop all of the loops
while (keep_going) {
  
  # how many bags we are getting in the current one
  multi = count_bags_df$bags[[bag_level]]
  # current colour of the bag
  this_bag = count_bags_df$colour[[bag_level]]
  
  # look for bags
  srch_list <- lugg_part2 %>% 
    filter(first == this_bag) %>% 
    select(others) %>% 
    unlist(use.names = FALSE)
  
  # add the found bags into our search 
  for (x in seq_along(srch_list)) {
    count_bags_df = add_bags(count_bags_df, srch_list[[x]], multi)
  }
  
  # iterate
  bag_level = bag_level + 1
  
  # stop if we have no more bags to search for
  if (bag_level > nrow(count_bags_df)) {
    break
  }

}

# minus one because we don't count shiny gold
sum(count_bags_df$bags) - 1

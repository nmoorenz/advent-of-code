# libs
library(tidyverse)

my_file <- here::here("2020", "day7.txt")

# read file
lugg <- read.delim(my_file, header = FALSE)

bag <- "shiny gold"

# split
lugg2 <- separate(lugg, V1, into = c("first", "other"), sep = " bags contain ") %>% 
  mutate(others = as.vector(str_split(other, ",")))

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
  print(srch_lvl)
  print(length(srch_list$first))
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
  print(sum(df$contains))
  df = recurs_search(df)
}

lugg3 <- recurs_search(lugg2)

# part two
srch_lvl <- 1
bag_current <- "1 shiny gold bag"

parse_bags <- function(df, item) {
  num = parse_number(item)
  color = parse_character(item)
  return(num)
}



recurs_counter <- function(bag_srch) {
  # look for "shiny gold"
  srch_list <- df %>% 
    filter(contains == TRUE & level == srch_lvl) %>% 
    select(others) %>% 
    as.vector() 

}


library(tidyverse)

# read file
lugg <- read.delim("day7.txt", header = FALSE)

bag <- "shiny gold"

# split
lugg2 <- separate(lugg, V1, into = c("first", "other"), sep = " bags contain ") %>% 
  mutate(others = str_split(other, ","))

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

recurs_counter <- function(df) {
  # look for "shiny gold"
  srch_list <- df %>% 
    filter(contains == TRUE & level == srch_lvl) %>% 
    select(first) %>% 
    as.vector() 
  # for bags in bag_list
  
  # number of bags, colour of bag append to tibble
  
  # index for current search
  # index for next addition to search list
  
  # column for raw number of bags
  # column for bags counter
  # those seem like they would be the same thing
  
  
  
  
  
  
  
  
  
  
  
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
  # df = recurs_search(df)
}


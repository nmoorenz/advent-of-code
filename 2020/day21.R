library(tidyverse)

my_file <- here::here("2020", "day21.txt")
foods <- read.delim(my_file, header = FALSE)

# a bit of back and forward with this, but I like it
# get the allergens out then expand them downwards
# get the ingredients and nest them
foods_allergen <- foods %>% 
  mutate(allergens = str_extract(V1, "\\(.*\\)"), 
         allergens = str_remove(allergens, "\\(contains "), 
         allergens = str_remove(allergens, "\\)"), 
         allergens = str_split(allergens, ", "), 
         ingred = str_remove(V1, " \\(.*\\)"), 
         ingred = str_split(ingred, " ")) %>% 
  select(-V1) %>% 
  unnest_longer(allergens) %>% 
  arrange(allergens) %>% 
  nest(ingred = c(ingred))

# check that intersect gives what we want
intersect(foods_allergen$ingred[[1]]$ingred[[1]], foods_allergen$ingred[[1]]$ingred[[2]])

# I have come to enjoy using intersect for all these tasks
Reduce(intersect, foods_allergen$ingred[[1]]$ingred)

# function to apply the intersect to the different allergens
reduce_intersect <- function(my_list) {
  Reduce(intersect, my_list$ingred)
}

# map is my fave
foods_possible <- foods_allergen %>% 
  mutate(possible = map(ingred, reduce_intersect))

# this is the list of allergens
allergen_list <- foods_possible$possible %>% unlist() %>% unique()

# go back to the original rows
foods_safe <- foods %>% 
  mutate(ingred = str_remove(V1, " \\(.*\\)"), 
         ingred = str_split(ingred, " ")) %>% 
  select(-V1) %>% 
  unnest_longer(ingred) %>% 
  filter(!(ingred %in% allergen_list))

# answers
part_one <- nrow(foods_safe)

# sesame we know for sure
# could go along and eliminate from other vectors
# and eliminate those from the other vectors
# or just write it by hand
part_two_c = c("gbt", "rpj", "vdxb", "dtb", "bqmhk", "vqzbq", "zqjm", "nhjrzzj")

part_two = paste0(part_two_c, collapse = ",")

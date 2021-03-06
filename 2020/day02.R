# imports
library(tidyverse)

inputfile = here::here("2020", "day02.txt")

# data for a df 
toboggan <- read_csv(inputfile, col_names = FALSE)

# first attempt with str_split and unnest_wider
# no_good <- toboggan %>% 
#   mutate(split1 = str_split(X1, " ")) %>% 
#   unnest_wider(split1) %>% 
#   rename(lim = `...1`, letter = `...2`, password = `...3`) %>% 
#   mutate(split2 = str_split(lim, "-")) %>% 
#   unnest_wider(split2) %>% 
#   rename(lim1 = `...1`, lim2 = `...2`) %>% 
#   mutate(
#     letter = str_remove(letter, ":"), 
#     lim1 = as.numeric(lim1), 
#     lim2 = as.numeric(lim2)
#     ) %>% 
#   select(-X1, -lim)

# separate is way better! 
tob_split <- toboggan %>% 
  separate(X1, sep = " ", c("lims", "lett", "pw")) %>% 
  separate(lims, sep = "-", c("lo", "hi")) %>% 
  mutate(
    lett = str_remove(lett, ":"), 
    lo = as.integer(lo), 
    hi = as.integer(hi)
  )

# find rows which satisfy conditions
check_func <- function(lo, hi, lett, pw) {
  cnt = str_count(pw, lett)
  # print(c(l1, l2, cnt, l1 <= cnt, cnt <= l2))
  (lo <= cnt && cnt <= hi)
}

# pmap() for multiple arguments
check_1 <- tob_split %>% 
  mutate(pass = pmap_lgl(tob_split, check_func))

# part one answer
sum(check_1$pass)

######################################### part two
# check 2 function
check_pos = function(lo, hi, lett, pw) {
  pos = str_locate_all(pw,lett)
  pos_vect = pos[[1]][,1]
  check1 = lo %in% pos_vect
  check2 = hi %in% pos_vect
  xor(check1, check2)
}

# run the second function
check_2 <- tob_split %>% 
  mutate(pos = pmap_lgl(tob_split, check_pos))

# part two answer
sum(check_2$pos)

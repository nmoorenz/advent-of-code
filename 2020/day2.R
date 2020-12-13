# imports
library(tidyverse)

# data
toboggan <- read_csv("day2.txt", col_names = FALSE)

# first attempt with str_split and unnest_wider
no_good <- toboggan %>% 
  mutate(split1 = str_split(X1, " ")) %>% 
  unnest_wider(split1) %>% 
  rename(lim = `...1`, letter = `...2`, password = `...3`) %>% 
  mutate(split2 = str_split(lim, "-")) %>% 
  unnest_wider(split2) %>% 
  rename(lim1 = `...1`, lim2 = `...2`) %>% 
  mutate(
    letter = str_remove(letter, ":"), 
    lim1 = as.numeric(lim1), 
    lim2 = as.numeric(lim2)
    ) %>% 
  select(-X1, -lim)

# separate is way better! 
t2 <- toboggan %>% 
  separate(X1, sep = " ", c("lims", "lett", "pw")) %>% 
  separate(lims, sep = "-", c("lo", "hi")) %>% 
  mutate(
    lett = str_remove(lett, ":"), 
    lo = as.integer(lo), 
    hi = as.integer(hi)
  )


check_func <- function(lo, hi, lett, pw) {
  cnt = str_count(pw, lett)
  # print(c(l1, l2, cnt, l1 <= cnt, cnt <= l2))
  (lo <= cnt && cnt <= hi)
}

checker <- t2
checker$pass = FALSE

for (x in seq_along(checker$lo)) {
  checker$pass[x] = check_func(checker$lo[x], checker$hi[x], checker$lett[x], checker$pw[x])  
}

sum(checker$pass)


# check 2
check_pos = function(lo, hi, lett, pw) {
  pos = str_locate_all(pw,lett)
  pos_vect = pos[[1]][,1]
  check1 = lo %in% pos_vect
  check2 = hi %in% pos_vect
  xor(check1, check2)
}

checker$pos = FALSE

for (x in seq_along(checker$lo)) {
  checker$pos[x] = check_pos(checker$lo[x], checker$hi[x], checker$lett[x], checker$pw[x])  
}

sum(checker$pos)

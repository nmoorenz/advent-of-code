library(tidyverse)

# read all at once
answers <- read_file("day6.txt")
# split into elements with double end line
answer_groups <- str_split(answers, "\r\n\r\n")
# names
names(answer_groups) <- c("ans")
# combo each piece
answer_join <- str_remove_all(answer_groups$ans, "\r\n")

# count letters
counters <- function(lett) {
  sum(str_count(lett, letters) > 0)
}

# apply
count_answers <- map(answer_join, counters)
# reduce
Reduce(`+`, count_answers)

# part two
answer_split <- str_split(answer_groups$ans, "\r\n")
# tibble?
ans_tbl <- tibble(ans = answer_split) %>% 
  mutate(grp = row_number()) %>% 
  unnest_longer(ans) %>% 
  mutate(cnt = map(ans, str_count, letters)) %>% 
  nest(data = c("ans", "cnt"))

ans_tbl$num <- 0

for (n in seq_len(nrow(ans_tbl))) {
  tt = ans_tbl$data[[n]]$cnt
  x = tt[[1]]
  if (length(tt) > 1) {
    for (m in seq(2, length(tt))) {
      y = tt[[m]]
      x = bitwAnd(x, y)
    }  
  }
  ans_tbl$num[[n]] = sum(x)
}

sum(ans_tbl$num)

# part two type 2
split_ans <- function(aa) {
  ans_collect = NULL
  for (i in seq_len(length(aa))) {
    ans_each = str_split(aa[[i]], pattern = "")
    # print(ans_each[[1]])
    if (i == 1) {
      ans_collect = ans_each[[1]]
    } else {
      ans_collect = intersect(ans_collect, ans_each[[1]])
    }
  }
  
  return(glue::glue_collapse(ans_collect))
}

ans_tbl <- tibble(ans = answer_split) %>% 
  mutate(ans_v = map(ans, split_ans), 
         cnt = map(ans_v, counters))


Reduce(`+`, ans_tbl$cnt)

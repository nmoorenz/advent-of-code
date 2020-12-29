library(tidyverse)

my_file <- here::here("2020", "day19.txt")
r_m <- read.delim(my_file, header = FALSE)

# separate into rules and messages
r_m <- r_m %>% 
  mutate(rule = str_detect(V1, ":"))

# get those objects
rules <- filter(r_m, rule == TRUE) %>% 
  select(-rule)

messages <- filter(r_m, rule == FALSE) %>% 
  select(-rule) 

# parse some rules
rule_sep <- rules %>% 
  separate(V1, into = c("rule_num", "others"), sep = ": ") 

# make a copy
rule_sub <- rule_sep %>% 
  mutate(done = FALSE)

# run repeatedly below
# i think we want to replace when there are all letters in the rule
rule_sub <- rule_sub %>% 
  mutate(any_num = str_detect(others, "\\d")) %>% 
  arrange(rule_num)

# get the rules we want to change
rr <- rule_sub %>% 
  filter(any_num == FALSE & done == FALSE)

# apparently we need a function to apply the substitution
# otherwise doesn't pick up boundaries properly
replace_func <- function(my_list, patt, repl) {
  str_replace_all(my_list, patt, repl)
}

# now make the changes
for (z in seq_len(nrow(rr))) {
  patt = paste0("\\b", rr$rule_num[[z]], "\\b")
  repl = paste0("(", rr$others[[z]], ")")
  rule_sub <- rule_sub %>% mutate(others = map(others, replace_func, patt, repl), 
                                  done = done | str_detect(rule_num, paste0("\\b", rr$rule_num[[z]], "\\b")))
  
}


# I'm not sure how to simplify this process to come up with coherent rules
# we want to make this quicker by recording which rules we've already done
# we might want to only work with one df in a loop
# just run the above a few times and that'll do

# part one: just check rule zero

rule_0 <- rule_sub %>% 
  filter(rule_num == "0") %>% 
  select(others) %>% 
  unlist(use.names = FALSE)

# ah goodness it is huge

rule_0_tight <- str_replace_all(rule_0, "\\(([ab])\\) \\(([ab])\\)", "\\1\\2")
# (a) (b)
rule_0_tight <- str_replace_all(rule_0_tight, "\\(([ab]+)\\) \\(([ab]+)\\)", "\\1\\2")
# (a) | (b)
rule_0_tight <- str_replace_all(rule_0_tight, "\\(([ab]+)\\) \\| \\(([ab]+)\\)", "\\1\\|\\2")


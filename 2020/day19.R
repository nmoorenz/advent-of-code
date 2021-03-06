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
  separate(V1, into = c("rule_num", "rule_rule"), sep = ": ") %>% 
  arrange(rule_num)

# make a copy
rule_sub <- rule_sep %>% 
  mutate(done = FALSE)

# apparently we need a function to apply the substitution
# otherwise doesn't pick up boundaries properly
replace_func <- function(my_list, patt, repl) {
  str_replace_all(my_list, patt, repl)
}

# run repeatedly below
while (any(rule_sub$done == FALSE)) {
  # i think we want to replace when there are all letters in the rule
  # if there are numbers then that's not a good replacement
  rule_sub <- rule_sub %>% 
    mutate(any_num = str_detect(rule_rule, "\\d"))
  
  # get the rules we want to change
  rr <- rule_sub %>% 
    filter(any_num == FALSE & done == FALSE)
  
  # now make the changes
  for (z in seq_len(nrow(rr))) {
    # brackets for the rules with OR pipe
    patt = paste0("\\b", rr$rule_num[[z]], "\\b")
    repl = ifelse(str_detect(rr$rule_rule[[z]], "\\|"), 
                   paste0("(", rr$rule_rule[[z]], ")"), 
                   rr$rule_rule[[z]])
    
    # apply the rules with map function and update done
    rule_sub <- rule_sub %>% mutate(rule_rule = map(rule_rule, replace_func, patt, repl), 
                                    done = done | str_detect(rule_num, patt))
    
  }
}

rule_sub <- rule_sub %>% 
  mutate(rule_rule = str_remove_all(rule_rule, " "), 
         rule_rule = paste0("^", rule_rule, "$"))



# part one: just check rule zero

rule_0 <- rule_sub %>% 
  filter(rule_num == "0") %>% 
  select(rule_rule) %>% 
  pull(rule_rule)

# ah goodness it is huge

# let the computer handle the matches
part_one_df <- messages %>% 
  mutate(matcher = str_detect(V1, rule_0))

sum(part_one_df$matcher)

########################################## part two
# oh hey just totally mess with things and make sure it is weird
"
8: 42 | 42 8
11: 42 31 | 42 11 31
"
# looks like everybody's rule 0: 8 11
# thanks tanho63.github.io
# one or more rule 42
rule_8 <- "42 +"
# "42 31 | 42 42 31 31 | 42 42 42 31 31 31 | "
rep_regex <- function(x) {
  p_42 = paste(rep("42", x), collapse = " ")
  p_31 = paste(rep("31", x), collapse = " ")
  paste(p_42, p_31)
}

rule_11 <- paste(map_chr(1:10, rep_regex), collapse = " | ")

rule_sub <- rule_sep %>% 
  mutate(done = FALSE, 
         rule_rule = case_when(
           rule_num == "8" ~ rule_8, 
           rule_num == "11" ~ rule_11, 
           TRUE ~ rule_rule
         ))

# same as part one
# run repeatedly below
while (any(rule_sub$done == FALSE)) {
  # i think we want to replace when there are all letters in the rule
  # if there are numbers then that's not a good replacement
  rule_sub <- rule_sub %>% 
    mutate(any_num = str_detect(rule_rule, "\\d"))
  
  # get the rules we want to change
  rr <- rule_sub %>% 
    filter(any_num == FALSE & done == FALSE)
  
  # now make the changes
  for (z in seq_len(nrow(rr))) {
    # brackets for the rules with OR pipe
    patt = paste0("\\b", rr$rule_num[[z]], "\\b")
    repl = ifelse(str_detect(rr$rule_rule[[z]], "\\|"), 
                  paste0("(", rr$rule_rule[[z]], ")"), 
                  rr$rule_rule[[z]])
    
    # apply the rules with map function and update done
    rule_sub <- rule_sub %>% mutate(rule_rule = map(rule_rule, replace_func, patt, repl), 
                                    done = done | str_detect(rule_num, patt))
    
  }
}

rule_sub <- rule_sub %>% 
  mutate(rule_rule = str_remove_all(rule_rule, " "), 
         rule_rule = paste0("^", rule_rule, "$"))

# get the rule we want to check
rule_0 <- rule_sub %>% 
  filter(rule_num == "0") %>% 
  select(rule_rule) %>% 
  pull(rule_rule)

# let the computer handle the matches
part_two_df <- messages %>% 
  mutate(matcher = str_detect(V1, rule_0))

sum(part_two_df$matcher)

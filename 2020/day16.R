# tidyverse for some dplyr
library(tidyverse)

# use the here package for files
my_file <- here::here("2020", "day16.txt")

# all of the ticket info
tickets <- read.delim(my_file, header = FALSE)

# the first 20 rows are the rules
# this might not be efficient but it works
ticket_rules <- tibble(rr = tickets[1:20, ]) %>% 
  separate(col = rr, into = c("name", "other"), sep = ":") %>% 
  separate(col = other, into = c("lo", "hi"), sep = " or ") %>% 
  separate(col = lo, into = c("lo1", "lo2"), sep = "-") %>% 
  separate(col = hi, into = c("hi1", "hi2"), sep = "-") %>% 
  mutate(across(starts_with(c("lo", "hi")), as.numeric)) %>% 
  mutate(mid1 = lo2 + 1, mid2 = hi1 - 1) %>% 
  select(name, starts_with("lo"), starts_with("mid"), starts_with("hi")) %>% 
  arrange(mid1)

# just one line
my_ticket <- tickets[22,] %>% str_split(",")
names(my_ticket) <- "me"

# nearby tickets are the rest of the rows
nearby_tickets <- tibble(tck = tickets[24:nrow(tickets), ]) %>% 
  mutate(tck_lst = str_split(tck, ","), 
         tck_lst = map(tck_lst, as.numeric))

# might want to create a function to see if tickets are valid
valid_ticket <- function(ticket_num) {
  vv = -1
  for (t in seq_along(ticket_num)) {
    for (i in seq_len(nrow(ticket_rules))) {
      if (ticket_num[[t]] < ticket_rules$lo1[[i]] | ticket_num[[t]] > ticket_rules$hi2[[i]]) {
        vv = append(vv, ticket_num[[t]])
        break
      }
    }
  }
  return(vv)
}

# turns out only one ticket number per ticket is invalid
# the function doesn't need to use append, but there you go
valid_tickets <- nearby_tickets %>% 
  mutate(valid = map(tck_lst, valid_ticket))

# part one answer
valid_tickets %>% 
  select(valid) %>% 
  unnest_longer(valid) %>% 
  filter(valid >= 0) %>% 
  sum(.)

# turns out there is only one invalid middle number per row!
# return the ticket rule to find out if elimination is easy
elim_ticket <- function(ticket_num) {
  vv = -1
  for (t in seq_along(ticket_num)) {
    for (i in seq_len(nrow(ticket_rules))) {
      if (ticket_num[[t]] >= ticket_rules$mid1[[i]] & ticket_num[[t]] <= ticket_rules$mid2[[i]]) {
        vv = i
        return(vv)
      }
    }
  }
  return(vv)
}

# check for elimination of rules
elim_tickets <- nearby_tickets %>% 
  mutate(cant_be = map_dbl(tck_lst, elim_ticket))

# this is great! 19 down to 1
# this takes quite a bit of organisation
elim_tickets %>% 
  count(cant_be)

# want to get the rule and the position for processing
elim_rules <- function(ticket_num) {
  vv = c("rule" = -1, "pos" = -1)
  for (t in seq_along(ticket_num)) {
    for (i in seq_len(nrow(ticket_rules))) {
      if (ticket_num[[t]] >= ticket_rules$mid1[[i]] & ticket_num[[t]] <= ticket_rules$mid2[[i]]) {
        vv = c("rule" = i, "pos" = t)
        return(vv)
      }
    }
  }
  return(vv)
}

# get more info for process
elim_rules_tickets <- nearby_tickets %>% 
  mutate(things = map(tck_lst, elim_rules)) %>% 
  unnest_wider(things)

# now have to find out how to allocate these
# checks out
elim_order <- elim_rules_tickets %>% 
  filter(rule > 0) %>% 
  count(rule)

# this collects the positions of things
rule_pos <- tibble(rule = vector(length = 20))

# possible positions for the rules
# remove a value every time we find something
possible_pos = as.double(seq_len(20))

# loop through possibilities
for (j in seq_len(19)) {
  # the rule that we are eliminating
  this_rule = elim_order %>% 
    filter(n == max(n)) %>% 
    select(rule) %>% 
    as.double(.)
  
  # find the positions where the rule is not
  not_pos = elim_rules_tickets %>% 
    filter(rule == this_rule) %>% 
    select(pos)
  
  # get the position that's left over
  this_pos = setdiff(possible_pos, not_pos$pos)
  
  # store the name of the rule in its position
  rule_pos$rule[[this_pos]] = ticket_rules$name[[this_rule]]
  
  # eliminate the position from possibilities
  possible_pos = possible_pos[possible_pos != this_pos]
  
  # eliminate the rule from possibilities
  elim_order = elim_order %>% 
    filter(rule != this_rule)
  
}

# have to look through and it is rule 10 that we haven't allocated
rule_pos$rule[[possible_pos]] = ticket_rules$name[[10]]

# the positions of the 6 rules that begin with departure
depart_rule <- rule_pos %>% 
  mutate(rn = row_number(), 
         me = as.integer(my_ticket$me)) %>% 
  filter(str_detect(rule, "departure")) 

# part two answer
prod(depart_rule$me) %>% as.character()

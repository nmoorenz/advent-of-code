library(tidyverse)

my_file <- here::here("2020", "day13.txt")

busses <- read_csv(my_file, 
                  skip = 1, 
                  col_names = FALSE, 
                  col_types = cols(.default = col_character())) %>% 
          pivot_longer(cols = everything()) %>% 
          filter(value != "x") %>% 
          select(-name) %>% 
          mutate(bus_time = as.integer(value)) 

departure_read <- read_csv(my_file, 
                           n_max = 1, 
                           col_names = FALSE, 
                           col_types = cols(.default = col_integer())) 

departure_time <- departure_read$X1[[1]]

# we could create a list of possible times
# want to then find the minimum time that is larger than departure time
# but that's just modulo 
# but if we do modulo, we're finding the time before departure time
# so we can adjust and get times for each bus time

bus_sched <- busses %>% 
  mutate(modulo = departure_time %% bus_time, 
         next_time = departure_time - modulo + bus_time) %>% 
  arrange(next_time)

bus_min <- bus_sched %>% 
  filter(next_time == min(next_time))

# part one answer
(bus_min$next_time[[1]] - departure_time) * bus_min$bus_time

# part two
busses_2 <- read_csv(my_file, 
                   skip = 1, 
                   col_names = FALSE, 
                   col_types = cols(.default = col_character())) %>% 
  pivot_longer(cols = everything()) %>% 
  mutate(value = if_else(value == "x", "0", value), 
         value = as.double(value),
         time_diff = row_number()-1) %>% 
  select(-name) %>% 
  filter(value != 0)

# initial info 
first_bus <- busses_2$value[1]
num_bus <- nrow(busses_2)

# info for the loop
time_step <- first_bus
my_answer <- 0

# for each of the busses
for (b in seq(2, num_bus)) {
  # print for help
  print(paste("The bus number is ", b))
  # nicer looking than referring to indices all the time
  b_time = busses_2$value[[b]]
  b_diff = busses_2$time_diff[[b]]
  # stop looking once we have found an answer
  found = FALSE
  x = 0
  # loop the loop
  while (found != TRUE) {
    # t is always multiple of first bus time
    t = my_answer + time_step * x 
    # this is when the next bus will arrive
    checker = t + b_diff 
    if (checker %% b_time == 0) {
      # check progress
      print(t)
      # found so go to next bus
      found = TRUE
      # update answer
      my_answer = t
      # increase search steps
      time_step = time_step * b_time
    } 
    # increment search steps
    x = x + 1
  }
}

# 
# # this is too much searching
# reckon_minimum <- 100000000000000
# 
# max_bus_time <- max(busses_2$value)
# max_bus_diff <- busses_2$time_diff[which(busses_2$value == max_bus_time)]
# 
# while (x < 1e16) {
#   poss_bus = 0
#   check_num = (max_bus_time * x - max_bus_diff)
#   for (y in seq(1,num_bus)) {
#     if ((check_num + busses_2$time_diff[[y]]) %% busses_2$value[[y]] != 0) {
#       # this is not the droid you're looking for
#       break
#     } else {
#       poss_bus = poss_bus + 1
#     }
#   }
#   if (poss_bus == 4) {
#     print(paste(check_num, poss_bus))
#     break
#   }
#   x = x + 1
# }
# 




"
Given the starting numbers 1,3,2, the 2020th number spoken is 1.
Given the starting numbers 2,1,3, the 2020th number spoken is 10.
Given the starting numbers 1,2,3, the 2020th number spoken is 27.
Given the starting numbers 2,3,1, the 2020th number spoken is 78.
Given the starting numbers 3,2,1, the 2020th number spoken is 438.
Given the starting numbers 3,1,2, the 2020th number spoken is 1836.
"

"
They begin by taking turns reading from a list of starting numbers (your puzzle input). 
Then, each turn consists of considering the most recently spoken number:

If that was the first time the number has been spoken, the current player says 0.
Otherwise, the number had been spoken before; the current player announces how many turns 
apart the number is from when it was previously spoken.
So, after the starting numbers, each turn results in that player speaking aloud 
either 0 (if the last number is new) or an age (if the last number is a repeat).
"

input <- c(1L, 2L, 16L, 19L, 18L, 0L)
collection <- vector()
said_so_far <- list()
rounds <- 2020
big_rounds <- 30000000

for (i in seq_along(input)) {
    said_so_far[paste('said', input[i])] = i
    collection[i] = input[i]
}

last_number_new <- TRUE # this is from manual inspection
last_num <- 0

for (j in seq(length(input) + 1, big_rounds)) {

    if (!last_number_new) {
      
      # we have not said the current number before
      last_number_new = TRUE
      
      next_num = j - said_so_far[sn][[1]]
      
      said_so_far[paste('said', last_num)] = j
      

    } else {
      # we have said the current number before
      last_number_new = FALSE
      curr = age
      next_num = j - said_so_far[sn][[1]]
      said_so_far[paste('said', curr)] = j
      
    }
  
  
  if (j %in% c(1e3, 1e4, 1e5, 1e6, 1e7)) {print(j); print(age)}
}

# c(1, 2, 16, 19, 18, 0) 
# we haven't said 0 before
# 7th number is 0
# because 0 is in the input we've always seen 0 before and can calculate age
# age is 7 - 6 = 1

# 8th number is 1
# we have seen this number before
# age is 8 - 1 = 7

# 9th number is 7
# we have not seen this number before
# last_number_new = TRUE

# 10th number is zero



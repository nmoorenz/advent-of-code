
input <- c(1L, 2L, 16L, 19L, 18L, 0L)
said_so_far <- list()
part_one_rounds <- 2020
part_two_rounds <- 30000000
rounds <- part_two_rounds

checker <- seq(from = rounds / 10, 
               to =   rounds - rounds/10, 
               by = rounds / 10)

#################################################
# let us see if pre-allocating a vector is faster
# yeah, way faster
num_list <- rep(0, rounds)

# it doesn't seem to matter if we try to allocate to num_list[0]
for (i in seq_along(input)) {
  num_list[input[i]] = i
}

say_zero <- TRUE 
last_said_zero <- 6

for (j in seq(length(input) + 1, rounds)) {
  
  if (say_zero) {
    
    # the next number to report
    next_num = j - last_said_zero
    
    # quick access for zero
    last_said_zero = j 
    
    # go to other loop
    say_zero = FALSE
    
    
  } else {
    # store this
    curr = next_num

    # what do we do with this number? 
    nexter = num_list[curr]
    if (nexter == 0) {
      # haven't said it before, go back to zero
      say_zero = TRUE
      
      # store this
      num_list[curr] = j
      
    } else {
      # we have said the last number before
      next_num = j - num_list[curr]
      
      # store this
      num_list[curr] = j
      
      # come back this way
      say_zero = FALSE
    }
    
  } 
  
  if (j %in% checker) {print(j); print(next_num)}
}


###########################################
# this is a name list, the initial approach
# for (i in seq_along(input)) {
#     said_so_far[paste('said', input[i])] = i
# }
# 
# # this is from manual inspection
# # special recording because zero will come up a lot
# say_zero <- TRUE 
# last_said_zero <- 6
# 
# for (j in seq(length(input) + 1, rounds)) {
# 
#     if (say_zero) {
#       
#       # the next number to report
#       next_num = j - last_said_zero
#       
#       # quick access for zero
#       last_said_zero = j 
#       
#       # go to other loop
#       say_zero = FALSE
# 
# 
#     } else {
#       # store this
#       curr = next_num
#       ss = paste('said', curr)
#       
#       # what do we do with this number? 
#       nexter = said_so_far[ss][[1]]
#       if (is.null(nexter)) {
#         # haven't said it before, go back to zero
#         say_zero = TRUE
#         
#         # store this
#         said_so_far[ss] = j
#         
#       } else {
#         # we have said the last number before
#         next_num = j - said_so_far[ss][[1]]
#         
#         # store this
#         said_so_far[ss] = j
#         
#         # come back this way
#         say_zero = FALSE
#       }
#       
#     } 
#   
#   if (j %in% checker) {print(j); print(next_num)}
# }

#################################################
# notes


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

library(tidyverse)

my_file <- here::here("2020", "day18.txt")
equations <- read.delim(my_file, header = FALSE)

do_op <- function(so_far, op, x){
  if (op == "") {
    so_far = so_far + as.numeric(x)
  } else if (op == 'add') {
    so_far = so_far + as.numeric(x)
  } else if (op == 'mlt') {
    so_far = so_far * as.numeric(x)
  }
  return(so_far)
}

eval_equation <- function(eq) {
  # inititate total
  so_far = 0
  op = ""
  while (e < nchar(eq)) {
    e <<- e + 1
    x = substr(eq, e, e)
    
    # print(e)
    # print(x)
    
    if (x == " ") {
      # skip
      
    } else if (x == "(") {
      # recursion
      # print('recursion')
      rec = eval_equation(eq)
      so_far = do_op(so_far, op, rec)
      
    } else if (x == ")") {
      # close the recursion
      # return inside total
      # print('return')
      return(so_far)
      
    } else if (x == "+") {
      # add
      # print('add')
      op = 'add'
      
    } else if (x == "*") {
      # multiply
      # print('multiply')
      op = 'mlt'
      
    } else {
      # trusting that this is a number
      # print(x)
      so_far = do_op(so_far, op, x)
    }
    # print(so_far)
    # print('---')
  }
  return(so_far)
}

tester = "8 * (9 + 5 + 5 * 6 + 8 * 3) * 5 * 7 * 4 + 9"
e <<- 0
eval_equation(tester)

# need a wrapper function to reset e <<- 0
calc_line <- function(eq) {
  e <<- 0
  eval_equation(eq)
}

equated <- equations %>% 
  mutate(line_sum = map_dbl(V1, calc_line))

# part one
as.character(sum(equated$line))

################################### part two

beasmd <- function(eq) {
  # inititate total
  so_far = 0
  op = ""
  while (e < nchar(eq)) {
    e <<- e + 1
    x = substr(eq, e, e)
    
    print(e)
    print(x)
    
    if (x == " ") {
      # skip
      
    } else if (x == "(") {
      # recursion
      print('recursion')
      rec = eval_equation(eq)
      so_far = do_op(so_far, op, rec)
      
    } else if (x == ")") {
      # close the recursion
      # return inside total
      print('return')
      return(so_far)
      
    } else if (x == "+") {
      # add
      # print('add')
      op = 'add'
      
    } else if (x == "*") {
      # multiply
      # print('multiply')
      op = 'mlt'
      rec = eval_equation(eq)
      so_far = do_op(so_far, op, rec)
      
    } else {
      # trusting that this is a number
      print(x)
      so_far = do_op(so_far, op, x)
    }
    print(so_far)
    print('---')
  }
  return(so_far)
}

tester = "1 + 2 * 3 + 4 * 5 + 6"
e <<- 0
beasmd(tester)

# need a wrapper function to reset e <<- 0
calc_line_2 <- function(eq) {
  e <<- 0
  beasmd(eq)
}

equate_part_two <- equations %>% 
  mutate(line_2 = map_dbl(V1, calc_line_2))

# part two
as.character(sum(equated$line))

############ example
"
1 + 2 * 3 + 4 * 5 + 6 = 71
1 + (2 * 3) + (4 * (5 + 6)) = 51

Here are a few more examples:

2 * 3 + (4 * 5) becomes 26.
5 + (8 * 3 + 9 + 3 * 4 * 3) becomes 437.
5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4)) becomes 12240.
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2 becomes 13632.
"

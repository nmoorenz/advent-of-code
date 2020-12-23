library(tidyverse)

my_file <- here::here("2020", "day18.txt")
equations <- read.delim(my_file, header = FALSE)

do_op <- function(){
  
}

eval_equation <- function(eq) {
  # inititate total
  so_far = 0
  op = ""
  for (e in seq_len(nchar(eq))) {
    x = substr(eq, e, e)
    
    if (x == " ") {
      # skip
      next
    } else if (x == "(") {
      # recursion
      print('recursion')
      rec = eval_equation(substr(eq, e+1, 1e6))
      so_far = do_op(so_far, op, rec)
    } else if (x == ")") {
      # close the recursion
      # return inside total
      print('return')
    } else if (x == "+") {
      # add
      print('add')
      op = 'add'
    } else if (x == "*") {
      # multiply
      print('multiply')
      op = 'mlt'
    } else {
      print(x)
      if (op == "") {
        so_far = so_far + as.numeric(x)
      } else if (op == 'add') {
        so_far = so_far + as.numeric(x)
      } else if (op == 'mlt') {
        so_far = so_far * as.numeric(x)
      }
    }
    print(so_far)
  }
  return(so_far)
}


tester = "1 + (2 * 3) + (4 * (5 + 6))"

eval_equation(tester)



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
library(tidyverse)

my_file <- here::here("2020", "day18.txt")
equations <- read.delim(my_file, header = FALSE)

eval_equation <- function(eq) {
  # inititate total
  so_far = 0
  
  for (e in seq_len(nchar(eq))) {
    x = substr(eq, e, e)
    
    if (x == " ") {
      # skip
    } else if (x == "(") {
      # recursion
      print('recursion')
    } else if (x == ")") {
      # close the recursion
      # return inside total
      print('return')
    } else if (x == "+") {
      # add
      print('add')
    } else if (x == "*") {
      # multiply
      print('multiply')
    } else {
      print('num')
    }
  }
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
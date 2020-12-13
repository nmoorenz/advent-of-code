library(tidyverse)

trees_slim <- read.delim("day3.txt", header = FALSE)

move_tobog <- function(rght, dwn, course) {
  x_pos = 1
  y_pos = 1
  course_len = length(course[[1]])
  width = str_count(course[[1]][1])
  trees = 0
  while (y_pos <= course_len) {
    # check for tree
    if (str_sub(course[[1]][[y_pos]], x_pos, x_pos) == "#") {
      trees = trees + 1
    }
    # move the toboggan
    x_pos <- (x_pos + rght) %% width
    y_pos <- y_pos + dwn
  }
  return(trees)
}

paths <- tibble::tibble(
  right = c(3, 1, 5, 7, 1), 
  down = c(1, 1, 1, 1, 2)
)

paths_hits <- paths %>% 
  mutate(
    trees_hit = map2_dbl(right, down, move_tobog, trees_slim)
  )

reduce(paths_hits$trees_hit, `*`)


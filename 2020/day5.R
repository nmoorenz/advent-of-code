library(tidyverse)

bp <- read.delim("day5.txt", header = FALSE)

conv_x <- tibble(
  fm = c("F", "B", "L", "R"), 
  to = c("0", "1", "0", "1")
)

convert_bp <- function(bpx) {
  for (x in seq_along(conv_x$fm)) {
    bpx = str_replace_all(bpx, conv_x$fm[x], conv_x$to[x])
  }
  return(bpx)
}

bp_bin <- bp %>% 
  mutate(
    bin = convert_bp(V1), 
    row = strtoi(str_sub(bin, end = 7), base = 2), 
    col = strtoi(str_sub(bin, start = 8), base = 2), 
    id = row * 8 + col
  )

max_id <- max(bp_bin$id)  
min_id <- min(bp_bin$id)

bp_seq = seq(from = min_id, to = max_id)

setdiff(bp_seq, bp_bin$id)

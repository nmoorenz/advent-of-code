library(tidyverse)

bp <- read.delim("2020/day05.txt", header = FALSE)

# conversions for letters to binary
fm = c("F", "B", "L", "R") 
to = c("0", "1", "0", "1")

named_v = c("F" = "0", "B" = "1", "L" = "0", "R" = "1")

# function to convert, since we have to do four replacements
convert_bp <- function(bpx) {
  for (x in seq_along(fm)) {
    bpx = str_replace_all(bpx, fm[x], to[x])
  }
  return(bpx)
}

# mutate seems like the best way to do this
# we can also use many replacements in one function
bp_bin <- bp %>% 
  mutate(
    # bin = convert_bp_2(V1), 
    bin = str_replace_all(V1, named_v),
    row = strtoi(str_sub(bin, end = 7), base = 2), 
    col = strtoi(str_sub(bin, start = 8), base = 2), 
    id = row * 8 + col
  )

# max is part one answer
max_id <- max(bp_bin$id)  
min_id <- min(bp_bin$id)

# possible seats from min to max
bp_seq = seq(from = min_id, to = max_id)

# part two answer
setdiff(bp_seq, bp_bin$id)

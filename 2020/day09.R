# library(tidyverse)

# read the things
code <- read.delim("2020/day09.txt", header = FALSE)

# setup
tgt_num <- 26
len <- nrow(code)

for (x in tgt_num:len) {
  found = FALSE
  tgt_sum = code$V1[[x]]
  for (j in (x-25):(x-2)) {
    for (k in (x-24):(x-1)) {
      if (code$V1[[j]] + code$V1[[k]] == tgt_sum) {
        found = TRUE
      }
      if (found) break
    }
    if (found) break
  }
  if (!found) {
    print(tgt_sum)
    print(x)
    break
  }
}

tgt <- 90433990
tgt_loc <- 560

found <- FALSE
# part two
for (qq in 3:50) { 
  for (x in 1:tgt_loc) {
    chk_sum = sum(code$V1[x:(x+qq)])
    if (chk_sum == tgt) {
      chk_vect = code$V1[x:(x+qq)]
      part_two = sum(min(chk_vect), max(chk_vect))
      print(x)
      print(qq)
      found = TRUE
    }
    if (found) break
  }
  if (found) break
}



library(tidyverse)

game <- read.delim("2020/day08.txt", header = FALSE) %>% 
  separate(V1, into = c("inst", "num"), sep = " ") %>% 
  mutate(has_run = FALSE, 
         num = parse_number(num))

run_game <- function(game) {
  game$has_run = FALSE
  x = 1
  acc = 0
  max_x = length(game$inst)

  while(game$has_run[[x]] == FALSE) {
    if (game$inst[[x]] == "acc") {
      acc = acc + game$num[[x]]
      game$has_run[[x]] = TRUE
      x = x + 1
    } else if (game$inst[[x]] == "nop") {
      game$has_run[[x]] = TRUE
      x = x + 1
    } else {
      game$has_run[[x]] = TRUE
      x = x + game$num[[x]]
    }
    if (x > max_x) {
      game_final <<- game
      return(acc)
    } 
  }
  return(NULL)
}

# maybe it is the last jmp to nop, but we never get that high
# it was great to record where we've been
# what are the possibilities for finishing? 
game <- game %>% 
  mutate(max_pos = num + row_number())
# check out that data
arrange(game, desc(max_pos))
# there's a jmp at 638-170=468
# how do we get there? 
# there are two jumps that equal 467
# so now we've got divergence and we could keep going but nah
# it seems like we could go backwards but that takes much design

val <- run_game(game)

for (z in seq_along(game$inst)) {
  if (game$inst[[z]] == "jmp") {
    game$inst[[z]] = "nop"
    revert = "jmp"
  } else if (game$inst[[z]] == "nop") { 
    game$inst[[z]] = "jmp"
    revert = "nop"
  } else {
    next
  }
  val = run_game(game)
  if (is.null(val)) {
    game$inst[[z]] = revert
  } else {
    print(z)
    break
  }
}




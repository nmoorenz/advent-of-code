library(tidyverse)

my_file <- here::here("2020", "day22.txt")

cards <- readLines(my_file)

cards1 <- as.numeric(cards[2:26])
cards2 <- as.numeric(cards[29:53])
cyc <- 0

while (length(cards1) > 0 & length(cards2) > 0) {
  cyc = cyc + 1
  # if (cyc == 559) break
  # top of the hands
  bet1 = cards1[1]
  bet2 = cards2[1]
  # remove the card from the hands
  # this might prove problematic with only one card
  # it is problematic! Do a check on length
  if (length(cards1) > 1) {
    cards1 = cards1[2:length(cards1)]
  } else {
    cards1 = NULL
  }
  if (length(cards2) > 1) {
    cards2 = cards2[2:length(cards2)]    
  } else {
    cards2 = NULL
  }
  # check where they go
  if (bet1 > bet2) {
    cards1 = append(cards1, c(bet1, bet2))
  } else {
    cards2 = append(cards2, c(bet2, bet1))
  }
}

part_one_df <- tibble(card = cards1) %>% 
  mutate(rr = 51 - row_number(), 
         prd = card * rr)

sum(part_one_df$prd)

# part two
# make a function that we can send two hands of cards to
# need to create a check on current card and length of remaining hand

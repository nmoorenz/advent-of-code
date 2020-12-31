library(tidyverse)

my_file <- here::here("2020", "day22.txt")
cards <- readLines(my_file)

cards1 <- as.numeric(cards[2:26])
cards2 <- as.numeric(cards[29:53])
cyc <- 0

while (length(cards1) > 0 & length(cards2) > 0) {
  cyc = cyc + 1
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

######################################################## part two
# make a function that we can send two hands of cards to
# need to create a check on current card and length of remaining hand

# if cards are the same as any hand previous, game ends, stop infinite games
# need to record each of the hands
# win for player one

store_hands <- function(c1, c2, level) {
  # store in a way that we can compare and retrieve later
  c1 = paste(c1, collapse = "-")
  c2 = paste(c2, collapse = "-")
  # restrict to current round
  this_level = filter(hands_record, lvl == level)
  # tibble_row() is nice to keep as one row for rbind
  rr = tibble_row(c1 = c1, c2 = c2, lvl = level)
  # check for infinity
  if (any(c1 == this_level$c1)) {
    hands_record <<- rbind(hands_record, rr)
    return(TRUE)
    }
  # global variable between subgames
  hands_record <<- rbind(hands_record, rr)
  return(FALSE)
}

# function which we can call recursively
play_the_card_game <- function(cards1, cards2) {
  # how many subgames we have
  current_level <- global_level
  # the states for this particular game
  this_game_record <- c()
  # loop for as long as we need
  while (length(cards1) > 0 & length(cards2) > 0) {
    # top cards from each hand
    bet1 = cards1[1]
    bet2 = cards2[1]
    # remove the card from the hands
    cards1 = tail(cards1, -1)
    cards2 = tail(cards2, -1)
    # do we go into a subgame
    if (bet1 <= length(cards1) & bet2 <= length(cards2)) {
      # subgame
      # print('sub')
      global_level <<- global_level + 1
      # subset by number on the card
      sub1 = cards1[1:bet1]
      sub2 = cards2[1:bet2]
      # recurse
      result = play_the_card_game(sub1, sub2)
      winner = result$winner
      # allocate cards, not necessarily highest
      if (winner == 1) {
        cards1 = c(cards1, bet1, bet2)
      } else {
        cards2 = c(cards2, bet2, bet1)
      }
    } else {
      # check where they go, regular allocation
      if (bet1 > bet2) {
        cards1 = c(cards1, bet1, bet2)
      } else {
        cards2 = c(cards2, bet2, bet1)
      }
    }
    # store and check hands
    score1 = sum(cards1 * rev(seq_along(cards1)))
    score2 = sum(cards2 * rev(seq_along(cards2)))
    this_hand = paste(score1, score2, sep = "-")
    # check for seeing this previously
    if (this_hand %in% this_game_record) {
      break
    } else {
      this_game_record = c(this_game_record, this_hand)
    }
  }  
  # print(current_level)
  game_levels <<- c(game_levels, current_level)
  # print('finished subgame')
  if (length(cards1) == 0) {
    winner = 2
  } else {
    winner = 1
  }
  # if (global_level == 9) stop()
  return(list(winner = winner, 
         cards1 = cards1, 
         cards2 = cards2))
}

# tester cards
# cards1 <- c(9, 2, 6, 3, 1)
# cards2 <- c(5, 8, 4, 7, 10)

# some set up of things
cards1 <- as.numeric(cards[2:26])
cards2 <- as.numeric(cards[29:53])

global_level <- 1
game_levels <- 1
# infinite = FALSE
# hands_record <- tribble(~c1, ~c2, ~lvl)

# call the functions
result <- play_the_card_game(cards1, cards2)

# clean up 
# final_1 <- hands_record$c1[nrow(hands_record)]
# final_2 <- hands_record$c2[nrow(hands_record)]

# could probably write this out but it's nice to be general
# win_cards <- str_split(final_1, "-") %>% unlist()
# win_cards <- append(win_cards[2:length(win_cards)], win_cards[1])
# win_cards <- append(win_cards, final_2)

# this bit is the same as part one
score1 = sum(result$cards1 * rev(seq_along(result$cards1)))

# plot the levels
tibble(lvl = game_levels) %>% 
  mutate(x = row_number()) %>% 
  ggplot(aes(x, lvl)) + 
  geom_point() + 
  ggtitle("Completion of Subgames in Recursive Combat")

ggsave("Recursive-Combat-Good-Progress.png")

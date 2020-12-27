library(tidyverse)

card <- 9033205
door <- 9281649
div <- 20201227

loop_max <- 1e8

tot <- 1
subj <- 7

for (i in seq_len(loop_max)) {
  tot = tot * subj
  tot = tot %% div
  if (tot == card) card_loop = i
  if (tot == door) door_loop = i
}

enc_card <- 1
for (j in seq_len(card_loop)) {
  enc_card = enc_card * door
  enc_card = enc_card %% div
}

enc_door <- 1
for (j in seq_len(door_loop)) {
  enc_door = enc_door * card
  enc_door = enc_door %% div
}


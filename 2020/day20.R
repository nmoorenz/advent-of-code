library(tidyverse)

# data
my_file <- here::here("2020", "day20.txt")
tiles <- read.delim(my_file, header = FALSE)

# names of the tiles
tile_names <- tiles %>% 
  mutate(names = str_detect(V1, "Tile")) %>% 
  filter(names == TRUE) %>% 
  select(-names) %>% 
  mutate(tile_num = parse_number(V1))

# join back the names then create nested item
tile_piece <- tiles %>% 
  left_join(tile_names, by = "V1") %>% 
  fill(tile_num) %>% 
  filter(str_detect(V1, "Tile", negate = TRUE)) %>% 
  group_by(tile_num) %>% 
  nest(data = c(V1))

# a little work to get the edges, and in reverse
get_edges <- function(piece) {
  # first row
  r1a = piece[[1]][1]
  r1b = stringi::stri_reverse(r1a)
  # last row
  r10a = piece[[1]][10]
  r10b = stringi::stri_reverse(r10a)
  # first column and last column
  c1a = ""
  c10a = ""
  for (i in seq_len(10)) {
    c1a = str_c(c1a, str_sub(piece[[1]][i], 1, 1))
    c10a = str_c(c10a, str_sub(piece[[1]][i], 10, 10))
  }
  # and the reversal
  c1b = stringi::stri_reverse(c1a)
  c10b = stringi::stri_reverse(c10a)
  # create a list of these things
  edges = c(r1a, r1b, r10a, r10b, c1a, c1b, c10a, c10b)
  return(edges)
}

# possibilities for the edges of the tiles
tile_edges <- tile_piece %>% 
  mutate(edges = map(data, get_edges))

edge_checker <- tile_edges %>% 
  unnest_longer(edges)

# function to compare edges
# if we can find more than two, it's not a corner
# if there are only two matches, it is a corner
# for now, just looking for corners so count those
match_edges <- function(my_edges, num) {
  mm = vector(mode = "integer")
  for (e in seq_along(my_edges)) {
    maybe = edge_checker %>% 
      filter(edges == my_edges[[e]], tile_num != num)
    # if (nrow(maybe) > 0) {
    #   yesyes = maybe %>% 
    #     select(tile_num) %>% 
    #     unlist(use.names = FALSE)
    #   mm = append(mm, yesyes)
    # }
    mm = append(mm, nrow(maybe))
  }
  return(mm)
}

tile_matches <- tile_edges %>% 
  mutate(matcher = map2(edges, tile_num, match_edges))

tile_corners <- tile_matches %>% 
  mutate(match_num = map_dbl(matcher, sum) / 2) %>% 
  filter(match_num ==2)

as.character(prod(tile_corners$tile_num))

######################################### part two
# find the layout for the tiles

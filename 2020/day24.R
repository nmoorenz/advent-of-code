library(tidyverse)

# get the data
my_file <- here::here("2020", "day24.txt")
compass <- read.delim(my_file, header = FALSE)

# possibilities
# w, sw, se, e, ne, nw

# first of the input for testing
f1 <- "swsenenwneswnewseswwseswnwsweeswnw"

# gotta change the string into separate pieces
# turns out I didn't do this properly first time 
# change: z < nchar() >> z <= nchar()
parse_compass <- function(comp) {
  # we don't know how long this might be
  dir_vect = vector(mode = "character")
  # position in characters
  z = 1
  # variable step size, so, while loop
  while (z <= nchar(comp)) {
    # 1 or 2 characters
    if (substr(comp, z, z) == "s" | substr(comp, z, z) == "n") {
      get_len = 2
    } else {
      get_len = 1
    }
    # get the right amount of characters, append, iterate
    nxt = substr(comp, z, z + get_len - 1)
    dir_vect = append(dir_vect, nxt)
    z = z + get_len
  }
  # return after collection
  return(dir_vect)
}

# tester, looks good
f2 <- parse_compass(f1)

# do the whole dataframe
compass_with_vect <- compass %>% 
  mutate(comp_vect = map(V1, parse_compass))

# need to know which tile we are flipping
flip_a_tile <- function(direct) {
  # start at the beginning
  ref_tile = c(0, 0)
  # run through instructions
  for (d in seq_along(direct)) {
    # I think this is the right way to do things
    # double coordinate system
    ref_tile = case_when(
      direct[d] == "e" ~ ref_tile + c(2, 0),
      direct[d] == "w" ~ ref_tile + c(-2, 0),
      direct[d] == "se" ~ ref_tile + c(1, -1),
      direct[d] == "ne" ~ ref_tile + c(1, 1),
      direct[d] == "sw" ~ ref_tile + c(-1, -1),
      direct[d] == "nw" ~ ref_tile + c(-1, 1)
    )  
  }
  # return of course
  return(ref_tile)
}

# do a test
flip_a_tile(f2)

# do the whole dataframe
compass_tiles <- compass_with_vect %>% 
  mutate(tile = map(comp_vect, flip_a_tile)) %>% 
  arrange(V1)

# counter for changes
compass_count <- compass_tiles %>% 
  count(tile) %>% 
  count(n)

# things aren't looking so good so go back to testing
test_file <- here::here("2020", "day24-test.txt")
tester <- read.delim(tester, header = FALSE)

# testing doesn't look so good either
tester_tiles <- tester %>% 
  mutate(comp_vect = map(V1, parse_compass), 
         tile = map(comp_vect, flip_a_tile)) 

tester_count <- tester_tiles %>% 
  count(tile) %>% 
  count(n)

############################### part two
# game of life

# organise my starting tiles
tile_floor_black <- compass_tiles %>% 
  count(tile) %>% 
  filter(n == 1) %>% 
  mutate(tile = purrr::map(tile, setNames, c("ew","ns"))) %>% 
  unnest_wider(tile) %>% 
  select(-n)

# ew = 100 + 2 * 200, width + 2 * possible expansion
# ns = 100 + 2 * 100
tile_matrix <- matrix(0, nrow = 300, ncol = 500)

# adjust the positions of tiles to be the middle
tm <- tile_floor_black %>% 
  mutate(ew = ew + 250, 
         ns = ns + 150)

# populate our tiles
for (z in seq_len(nrow(tm))) {
  tile_matrix[tm$ns[[z]], tm$ew[[z]] ] = 1
}

# neighbours for tiles
nb <- list("e"  = c(2, 0), "w"  = c(-2, 0), 
           "ne" = c(1, 1), "nw" = c(-1, 1), 
           "se" = c(1,-1), "sw" = c(-1,-1))

# function for counting neighbours
count_neighbour_tiles <- function(tiles, ns, ew) {
  my_sum = 0
  for (d in seq_along(nb)) {
    my_sum = my_sum + tiles[ns + nb[[d]][2], ew + nb[[d]][1]]
  }
  return(my_sum)
}

# function for looping through tiles
tile_assessment <- function(tiles) {
  tiles_copy <- tiles
  for (ew in seq(3, 498)) {
    for (ns in seq(2, 299)) {
      if ((ns + ew) %% 2 != 0) {
        # skip when not a valid coordinate
      } else if (tiles[ns, ew] == 0) {
        # check for white tiles
        nb_sum = count_neighbour_tiles(tiles, ns, ew)
        # only if exactly two then change to 1=black
        if (nb_sum == 2) {
          tiles_copy[ns, ew] = 1
        }
      } else {
        # check for black tiles
        nb_sum = count_neighbour_tiles(tiles, ns, ew)
        if (nb_sum == 1 | nb_sum == 2) {
          # skip, leave as 1=black
        } else {
          # put back to 0=white
          tiles_copy[ns, ew] = 0
        }
      }
    }
  }
  return(tiles_copy)
}

# do the loops
for (a in seq(1, 100)) {
  tile_matrix = tile_assessment(tile_matrix)
}

sum(tile_matrix)

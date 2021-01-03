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

# this seems like a good way to go with a matrix
tile_to_matrix <- function(my_tile) {
  my_thing <- my_tile %>% 
    mutate(tile_list = str_split(V1, "")) %>% 
    unnest_longer(tile_list) %>% 
    pull(tile_list) %>% 
    matrix(nrow = 10, ncol = 10, byrow = TRUE)
  return(my_thing)
}

# join back the names then create nested matrix
tile_piece <- tiles %>% 
  left_join(tile_names, by = "V1") %>% 
  fill(tile_num) %>% 
  filter(str_detect(V1, "Tile", negate = TRUE)) %>% 
  group_by(tile_num) %>% 
  nest(tile = V1) %>% 
  mutate(tile_m = map(tile, tile_to_matrix))

# a little work to get the edges, and in reverse
get_edges <- function(piece) {
  # first row
  r1a = piece[1,]
  r1b = rev(r1a)
  # last row
  r10a = piece[10,]
  r10b = rev(r10a)
  # first column and last column
  c1a = piece[,1]
  c1b = rev(c1a)
  c10a = piece[,10]
  c10b = rev(c10a)
  # create a list of these things
  edges = list(top = r1a, top_r = r1b, bot = r10a, bot_r = r10b, 
               lef = c1a, lef_r = c1b, rig = c10a, rig_r = c10b)
  return(edges)
}

# possibilities for the edges of the tiles
tile_edges <- tile_piece %>% 
  mutate(edges = map(tile_m, get_edges))

edge_checker <- tile_edges %>% 
  unnest_longer(edges) %>% 
  mutate(edge_chr = map_chr(edges, paste, collapse = ""))

# function to compare edges
# if we can find more than two, it's not a corner
# if there are only two matches, it is a corner
# for now, just looking for corners so count those
match_edges <- function(my_edge, num) {
  matcher = edge_checker %>% 
    filter(edge_chr == my_edge, tile_num != num)
  return(list(match_num = matcher$tile_num, 
              match_edges_id = matcher$edges_id))
}

# this should be helpful later when we need to organise the tiles
tile_matches <- edge_checker %>% 
  mutate(matcher = map2(edge_chr, tile_num, match_edges)) %>% 
  unnest_wider(matcher)

# corners do not have matches on 2 sides
# luckily every side only has one match
tile_corners <- tile_matches %>% 
  group_by(tile_num) %>% 
  count(match_num) %>% 
  filter(n == 4)

# part one answer
as.character(prod(tile_corners$tile_num))

######################################### part two
# find the layout for the tiles
# set one of the corners to only have one orientation
# otherwise we've got a large mirrored and rotated pattern
# then find the orientation of all the other tiles
# remove the edges and combine into one matrix/df
# then search for sea monster pattern

corners_info <- tile_corners %>% 
  left_join(tile_matches, by = c("tile_num"))

# 1063 matches with something on the bottom and right, 
# so we can set it as the top left and work from there
# without having to rotate or flip to begin with
# but we'll have to set up that reorientation scheme anyway

match_edges <- function(my_edge, num) {
  matcher = edge_checker %>% 
    filter(edge_chr == my_edge, tile_num != num)
  return(list(match_num = matcher$tile_num, 
              match_edges_id = matcher$edges_id, 
              match_tile = matcher$tile_m[[1]]))
}

reorient_tile_left <- function(my_tile, my_dir) {
  if (my_dir == "lef") {
    # don't do anything
    ret_tile = my_tile
  } else if (my_dir == "lef_r") {
    # flip rows
    ret_tile = my_tile[nrow(my_tile):1,]
  } else if (my_dir == "rig") {
    # flip columns
    ret_tile = my_tile[, rev(seq_len(ncol(my_tile)))]
  } else if (my_dir == "rig_r") {
    # rotate 180
    ret_tile = my_tile[nrow(my_tile):1,ncol(my_tile):1]
  } else if (my_dir == "bot") {
    # rotate clockwise 90
    ret_tile = t(my_tile[nrow(my_tile):1,])
  } else if (my_dir == "bot_r") {
    # transpose and rotate 180
    ret_tile = t(my_tile[nrow(my_tile):1,ncol(my_tile):1])
  } else if (my_dir == "top") {
    # transpose
    ret_tile = t(my_tile)
  } else if (my_dir == "top_r") {
    # rotate anticlockwise 90
    ret_tile = t(my_tile)[ncol(my_tile):1,]
  }
  return(ret_tile)
}

# may as well reuse the function above
# and then transpose into the top row
reorient_tile_top <- function(my_tile, my_dir) {
  get_left = reorient_tile_left(my_tile, my_dir)
  ret_tile = t(get_left)
  return(ret_tile)
}

# setup
# named columns for 12x12 matrix
# transforms into column names for dataframe
my_names <- paste0("c", 1:12)
tile_mat <- matrix(NA, nrow = 12, ncol = 12, dimnames = list(NULL, my_names))
tile_layout <- as.data.frame(tile_mat)


# loop through columns
for (rr in seq_len(12)) {
  # start with the top left square
  if (rr == 1) {
    # choose these beforehand
    first_col_tile = 1063

    # get the proper info
    tile_info = list(match_num = first_col_tile, 
                     match_edges_id = "rig", 
                     match_tile = tile_piece %>% 
                       filter(tile_num == first_col_tile) %>% 
                       pull(tile_m) %>% 
                       .[[1]])
    
    # for some reason need to make cell a list first
    # probably a better way of doing this
    tile_layout[[1]][[rr]] = list(0)
    tile_layout[[1]][[rr]] = tile_info
    
    # get the bottom row of the above tile
    bottom_edge = tile_matches %>% 
      filter(tile_num == first_col_tile & edges_id == "bot") %>% 
      pull(edge_chr)
    
    # the character string (tile edge) that we want to match
    right_edge = tile_matches %>% 
      filter(tile_num == first_col_tile & edges_id == "rig") %>% 
      pull(edge_chr)
    
  } else {
    # second row and so on
    
    # match to the next tile
    tile_info = match_edges(bottom_edge, first_col_tile)
    
    # change the orientation of the tile
    tile_info$match_tile = reorient_tile_top(tile_info$match_tile, tile_info$match_edges_id)
    
    # store the tiles
    tile_layout[[1]][[rr]] = list(0)
    tile_layout[[1]][[rr]] = tile_info
    
    # info for next loop
    first_col_tile = tile_info$match_num
    
    # edges
    edge_vec = tile_info$match_tile[10,]
    bottom_edge = paste(edge_vec, collapse = "")
    
    # the character string (tile edge) that we want to match
    edge_vec = tile_info$match_tile[,10]
    right_edge = paste(edge_vec, collapse = "")
    
  }
  for (cc in seq(2, 12)) {
    # which tile we are getting
    if (cc == 2) {
      # tile number
      this_tile = first_col_tile
      
    } else {
      this_tile = tile_info$match_num
      edge_vec = tile_info$match_tile[,10]
      right_edge = paste(edge_vec, collapse = "")
      
    }
    
    # get the info for this current tile
    tile_info = match_edges(right_edge, this_tile)
    
    # change the orientation of the tile
    tile_info$match_tile = reorient_tile_left(tile_info$match_tile, tile_info$match_edges_id)
    
    # store the tiles
    tile_layout[[cc]][[rr]] = list(0)
    tile_layout[[cc]][[rr]] = tile_info
    
  }
}


##################### 
# previous work that didn't quite go
# would have to rotate pieces and figure out positions
# might as well go full allocation

dir_func <- function(my_dir) {
  next_dir = case_when(
    my_dir == "lef" ~ "rig", 
    my_dir == "rig" ~ "lef", 
    my_dir == "top" ~ "bot", 
    my_dir == "bot" ~ "top", 
    my_dir == "lef_r" ~ "rig_r", 
    my_dir == "rig_r" ~ "lef_r", 
    my_dir == "top_r" ~ "bot_r", 
    my_dir == "bot_r" ~ "top_r"
  )
  return(next_dir)
}

# hopefully this works as a loop 
for (rr in seq_len(12)) {
  # the first column is special
  if (rr == 1) {
    # choose these beforehand
    first_col_tile = 1063
    first_col_dir = "rig"
    down_dir = "bot"
  } else {
    # the tile above
    above_tile = first_col_tile
    above_dir = down_dir
    
    # next tile
    first_col_tile = tile_matches %>% 
      filter(tile_num == above_tile & edges_id == above_dir) %>% 
      pull(match_num)
    
    # what side we have matched with
    going_back_up = tile_matches %>% 
      filter(tile_num == above_tile & edges_id == down_dir) %>% 
      pull(match_edges_id)
    
    # the next tile underneath to match
    down_dir <- dir_func(going_back_up)
    
    # process of elimination for going right
    first_col_dir = tile_matches %>% 
      filter(tile_num == above_tile & edges_id != down_dir & 
               edges_id != going_back_up & !is.na(match_edges_id)) %>% 
      pull(match_edges_id)
    
  }
  for (cc in seq_len(12)) {
    if (cc == 1) {
      this_tile = first_col_tile
      this_dir = first_col_dir
    } else {
      this_tile = next_tile
      this_dir = next_dir
    }
    
    # tile number
    tile_layout[rr, cc] = this_tile
    
    # next tile
    next_tile = tile_matches %>% 
      filter(tile_num == this_tile & edges_id == this_dir) %>% 
      pull(match_num)
      
    # what side we have matched with
    match_dir = tile_matches %>% 
      filter(tile_num == this_tile & edges_id == this_dir) %>% 
      pull(match_edges_id)
    
    # the next side we are going to match with
    next_dir <- dir_func(match_dir)
  }
}

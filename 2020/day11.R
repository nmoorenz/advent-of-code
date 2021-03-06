library(tidyverse)

# read
seats_map <- read.delim("2020/day11.txt", header = FALSE)

# length of character
xx <- nrow(seats_map)
yy <- nchar(seats_map$V1[[1]])

# separators for columns
w = rep(1, yy)

# read into matrix for nice indexing
seat_map <- read.fwf("2020/day11.txt", widths = w, header = FALSE) %>% 
  as.matrix()

fill_seats <- function(seats) { 
  seat_copy = seats
  change = 0
  for (x in seq_len(xx)) {
    for (y in seq_len(yy)) { 
      if (seat_set[x, y] == TRUE) {
        # pass
        # we don't need to check these again
      } else if (seats[x,y] == ".") {
        # pass
        # the floor does not change
      } else if (seats[x,y] == "L") { 
        # st_cnt <- count_adjacent(seat_copy, x, y)
        st_cnt <- count_visible(seat_copy, x, y)
        if (st_cnt == 0) {
          seats[x,y] = "#"
          change = change + 1
        } else {
          seat_set[x, y] <<- TRUE
        }
      } else {
        # pass
        # already # 
      }
    }
  }
  change_count <<- change
  return(seats)
}

empty_seats <- function(seats, lim) {
  seat_copy = seats
  change = 0
  for (x in seq_len(xx)) {
    for (y in seq_len(yy)) { 
      if (seat_set[x, y] == TRUE) {
        # pass
      } else if (seats[x, y] == ".") {
        # pass
      } else if (seats[x, y] == "#") { 
        # st_cnt <- count_adjacent(seat_copy, x, y)
        st_cnt <- count_visible(seat_copy, x, y)
        if (st_cnt >= lim) {
          seats[x, y] = "L"
          change = change + 1
        } else {
          seat_set[x, y] <<- TRUE
        }
      } else {
        # pass
        # already L
      }
    }
  }
  change_count <<- change
  return(seats)  
}

count_adjacent <- function(sub_seat, x, y) {
  cnt = 0
  j1 = max(1,x-1)
  j2 = min(xx,x+1)
  k1 = max(1,y-1)
  k2 = min(yy,y+1)
  for (j in seq(j1,j2)) {
    for (k in seq(k1,k2)) {
      if (j == x & k == y) {
        # pass
      } else if (sub_seat[j,k] == "#") {
        cnt = cnt + 1
      }
    }
  }
  return(cnt)
}

# tracking for easier testing
seat_set <- matrix(FALSE, nrow = xx, ncol = yy)

# manually test the functions
seats1 <- fill_seats(seat_map)
seats2 <- empty_seats(seats1, 4)
seats3 <- fill_seats(seats2)
seats4 <- empty_seats(seats3, 4)

seat_set <- matrix(FALSE, nrow = xx, ncol = yy)
change_count <- 1
loop_seats <- seat_map

while (change_count > 0) {
  print(change_count)
  loop_seats <- fill_seats(loop_seats)
  loop_seats <- empty_seats(loop_seats, 4)
}

seats_fill <- 0

for (x in seq_len(xx)) {
  for (y in seq_len(yy)) { 
    if (loop_seats[x,y] == "#") {
      seats_fill = seats_fill + 1
    }
  }
}

############################ part two

count_visible <- function(st_vis, x, y) {
  cnt = 0
  #       N  NE  E SE  S  SW   W  NW
  jj = c(-1, -1, 0, 1, 1,  1,  0, -1)
  kk = c( 0,  1, 1, 1, 0, -1, -1, -1)
  
  for (dir in seq(1,8)) {
    # reset variables for another search
    j = x
    k = y
    found = FALSE
    # loop while we are still looking
    while (found == FALSE) {
      j = j + jj[dir]
      k = k + kk[dir]
      if ((1 <= j) & (j <= xx) & (1 <= k) & (k <= yy)) {
        if (st_vis[j,k] == "#") {
          cnt = cnt + 1
          break
        } else if (st_vis[j,k] == "L") {
          # found an unoccupied seat 
          break
        }
      } else {
        found = TRUE
        # off the edge of the ferry
      }
    }
  }
  return(cnt)
}

# tracking for easier testing
seat_set <- matrix(FALSE, nrow = xx, ncol = yy)

# manually test the functions
seats1 <- fill_seats(seat_map)
seats2 <- empty_seats(seats1, 5)
seats3 <- fill_seats(seats2)
seats4 <- empty_seats(seats3, 5)

seat_set <- matrix(FALSE, nrow = xx, ncol = yy)
change_count <- 1
loop_seats <- seat_map

while (change_count > 0) {
  print(change_count)
  loop_seats <- fill_seats(loop_seats)
  loop_seats <- empty_seats(loop_seats, 5)
}

seats_fill <- 0

for (x in seq_len(xx)) {
  for (y in seq_len(yy)) { 
    if (loop_seats[x,y] == "#") {
      seats_fill = seats_fill + 1
    }
  }
}

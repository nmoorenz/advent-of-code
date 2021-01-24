library(tidyverse)

# read
direct <- read.delim("2020/day12.txt", header = FALSE) %>% 
  separate(V1, into = c("dir", "num"), sep = 1) %>% 
  mutate(num = as.integer(num))

# tester
direct <- tibble(V1 = c("F10", "N3", "F7", "R90", "F11")) %>% 
  separate(V1, into = c("dir", "num"), sep = 1) %>% 
  mutate(num = as.integer(num))

####################################### part one
# initial position
pos <- c(0, 0)

# compass direction
comp <- 90

# check if L and R are multiples of 90
direct %>% 
  filter(dir %in% c("L","R")) %>% 
  count(num)

# yeah that's good let's use degrees as direction

# loops
for (x in seq_len(nrow(direct))) {
  if (direct$dir[[x]] == "N") {    # directional compass moves
    pos[2] = pos[2] + direct$num[[x]]
  } else if (direct$dir[[x]] == "E") {
    pos[1] = pos[1] + direct$num[[x]]
  } else if (direct$dir[[x]] == "S") {
    pos[2] = pos[2] - direct$num[[x]]
  } else if (direct$dir[[x]] == "W") {
    pos[1] = pos[1] - direct$num[[x]]
  } else if (direct$dir[[x]] == "L") {    # rotational moves
    comp = comp - direct$num[[x]]
    if (comp < 0) comp = comp + 360
  } else if (direct$dir[[x]] == "R") {
    comp = comp + direct$num[[x]]
    if (comp >= 360) comp = comp - 360
  } else if (direct$dir[[x]] == "F") {    # forward moves
    if (comp == 0) {
      pos[2] = pos[2] + direct$num[[x]]
    } else if (comp == 90) {
      pos[1] = pos[1] + direct$num[[x]]
    } else if (comp == 180) {
      pos[2] = pos[2] - direct$num[[x]]
    } else if (comp == 270) {
      pos[1] = pos[1] - direct$num[[x]]
    }
  }
  print(paste(pos[1], pos[2]))
}

abs(pos[1]) + abs(pos[2])

################## part two

rotater <- function(my_way, dd, nn) {
  if (dd == "L") {
    if (nn == "90") {
      qq = "L"
    } else if (nn == "180") {
      qq = "S"
    } else if (nn == "270") {
      qq = "R"
    } else {
      print("oops")
    }
  } else if (dd == "R") {
    if (nn == "90") {
      qq = "R"
    } else if (nn == "180") {
      qq = "S"
    } else if (nn == "270") {
      qq = "L"
    } else {
      print("oops")
    }
  }
  new_way <- my_way
  if (qq == "L") {
    my_way$y = new_way$x
    my_way$x = new_way$y * -1
  } else if (qq == "R") {
    my_way$y = new_way$x * -1
    my_way$x = new_way$y  
  } else if (qq == "S") {
    temp = my_way$y
    my_way$x = new_way$x * -1 
    my_way$y = new_way$y  * -1
  } else {
    print("oops")
  }
  return(my_way)  
}

ship <- list(x = 0, y = 0)
way <- list(x = 10, y = 1)

for (i in seq_len(nrow(direct))) {
  if (direct$dir[[i]] == "N") {    # directional compass moves
    way$y = way$y + direct$num[[i]]
  } else if (direct$dir[[i]] == "E") {
    way$x = way$x + direct$num[[i]]
  } else if (direct$dir[[i]] == "S") {
    way$y = way$y - direct$num[[i]]
  } else if (direct$dir[[i]] == "W") {
    way$x = way$x - direct$num[[i]]
    
  } else if (direct$dir[[i]] == "L") {    # rotational moves
    way = rotater(way, direct$dir[[i]], direct$num[[i]])
  } else if (direct$dir[[i]] == "R") {
    way = rotater(way, direct$dir[[i]], direct$num[[i]])
    
  } else if (direct$dir[[i]] == "F") {    # forward moves
    ship$x = ship$x + direct$num[[i]] * way$x
    ship$y = ship$y + direct$num[[i]] * way$y
  }
  print(paste(ship$x, ship$y))
}

abs(ship$x) + abs(ship$y)

# 62434


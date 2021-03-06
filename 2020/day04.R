library(tidyverse)

# mandatory and optional country id
mando_things <- c('byr','iyr','eyr','hgt','hcl','ecl','pid')
optional_things <- c('cid')

# read all at once
passport_file <- read_file("2020/day04.txt")
# split into elements with double end line
passport_list <- str_split(passport_file, "\r\n\r\n")
# names for the vector
names(passport_list) <- "pp"
# tibble so that we can use mutate and map
passport_items <- as_tibble(passport_list)

# checker function
check_mando <- function(item) {
  sum(str_detect(item, mando_things))
}  

# remove \r\n for niceness, and use map with checker function
pp_check <- passport_items %>% 
  mutate(
    pp = str_replace_all(pp, "\r\n", " "), 
    pass = map(pp, check_mando)
  )

# part one answer
sum(pp_check$pass >= 7)
 
# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
#   If cm, the number must be at least 150 and at most 193.
#   If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

# extract the bit for examination
get_item <- function(item, zz) { 
  zz_ = paste0(zz, ":")
  tt = str_extract(item, paste0(zz_, "[:punct:]?[:alnum:]+"))
  # print(tt)
  ss = str_remove(tt, zz_)
}

# get each of their items into their own column
pp_regex <- pp_check %>% 
  mutate(
    byr = get_item(pp, "byr"), 
    iyr = get_item(pp, "iyr"), 
    eyr = get_item(pp, "eyr"), 
    hgt = get_item(pp, "hgt"),
    hcl = get_item(pp, "hcl"),
    ecl = get_item(pp, "ecl"), 
    pid = get_item(pp, "pid")
  )

# checking functions for each of the passport fields
check_pid <- function(item) {
  str_detect(item, "^\\d{9}$")
}

check_ecl <- function(item) {
  item %in% c("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
}

check_hcl <- function(item) {
  str_detect(item, "#[0-9a-f]{6}")
}

check_hgt <- function(item) {
  x = parse_number(item)
  ifelse(
    str_detect(item, "in"), between(x, 59, 76), 
  ifelse(
    str_detect(item, "cm"), between(x, 150, 193),
  FALSE))
}

check_eyr <- function(item) { 
  xx = parse_integer(item)
  between(xx, 2020, 2030)
}

check_iyr <- function(item) {
  xx = parse_integer(item)
  between(xx, 2010, 2020)
}

check_byr <- function(item) { 
  xx = parse_integer(item)
  between(xx, 1920, 2002)
}

# check if the passport things are the right kind of things
pp_more_checks <- pp_regex %>% 
  mutate(
    byr_p = check_byr(byr), 
    iyr_p = check_iyr(iyr), 
    eyr_p = check_eyr(eyr), 
    hgt_p = check_hgt(hgt),
    hcl_p = check_hcl(hcl),
    ecl_p = check_ecl(ecl), 
    pid_p = check_pid(pid), 
    part_b = rowSums(across(ends_with("_p")), na.rm = TRUE) == 7
  )

# part two answer
reduce(pp_more_checks$part_b, `+`)

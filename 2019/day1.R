# using a list and a function calls for map
library(purrr)

# supplied
my_input <- c(148454L, 118001L, 98851L, 51106L, 113158L, 139801L, 126884L, 63241L, 71513L, 60490L, 131129L, 76176L, 74841L, 73589L, 130062L, 77999L, 140758L, 98182L, 101049L, 80951L, 75759L, 92666L, 142078L, 89196L, 124613L, 134713L, 75618L, 62680L, 141366L, 108899L, 88419L, 133385L, 90018L, 123521L, 51919L, 58191L, 109523L, 106012L, 94564L, 61103L, 72803L, 66309L, 143380L, 113708L, 146037L, 135176L, 131177L, 77109L, 108287L, 72170L, 87055L, 121407L, 126216L, 139520L, 120675L, 103833L, 130708L, 74029L, 149840L, 117122L, 105745L, 81186L, 51331L, 72686L, 52095L, 72612L, 76915L, 104859L, 114009L, 69714L, 130716L, 133106L, 73911L, 79766L, 56647L, 98035L, 103504L, 93728L, 111546L, 57637L, 68064L, 62803L, 72759L, 144845L, 80084L, 139247L, 139905L, 112807L, 87844L, 149388L, 76795L, 135703L, 120523L, 137422L, 108335L, 60206L, 133851L, 138574L, 141740L, 74398L)

# tester
test_input <- c(12, 14, 1969, 100756)

# functions are weird in R
fuel_amount <- function(mass) {
  f1 = floor(mass / 3) - 2
  f1
}

# run along the list
test_fuel <- map(test_input, fuel_amount)

# the real one
my_fuel <- map(my_input, fuel_amount)

# this is a great function! can't call sum on a list
Reduce("+", my_fuel)

# recursive functions are great
# it was the max that really made a difference
fuel_recursive <- function(mass) {
  f1 = floor(mass / 3) - 2
  if (f1 > 0) {
    f1 = f1 + fuel_recursive(f1)
  }
  max(f1,0)
}

# again with the testing
test_fuel <- map(test_input, fuel_recursive)

# the real one
my_fuel <- map(my_input, fuel_recursive)

# hashtag nice
Reduce("+", my_fuel)

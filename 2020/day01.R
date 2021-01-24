# but of course
library(tidyverse)

# find two numbers that sum to 2020 and give the product of those two numbers

input_file <- here::here("2020", "day01.txt")
my_input <- readLines(input_file) %>% as.numeric()

# for plotting
df = as.data.frame(my_input)

# have a look
ggplot(df) + 
  geom_histogram(aes(my_input))

# there is probably some value in sorting the list
# lower values are likely to be included rather than two around 1000
sorted_list = sort(my_input)

# double loop
for (x in seq_along(sorted_list)) {
  for (y in seq_along(sorted_list)) {
    if (sorted_list[[x]] + sorted_list[[y]] == 2020) {
      print(sorted_list[[x]] * sorted_list[[y]])
    }
  }
}

# triple loop
for (x in seq_along(sorted_list)) {
  for (y in seq_along(sorted_list)) {
    for (z in seq_along(sorted_list)) {
      if (sorted_list[[x]] + sorted_list[[y]] + sorted_list[[z]] == 2020) {
        print(sorted_list[[x]] * sorted_list[[y]] * sorted_list[[z]])
      }
    }
  }
}

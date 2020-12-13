# but of course
library(tidyverse)

# find two numbers that sum to 2020 and give the product of those two numbers

# datapasta
my_input <- c(1786L, 571L, 1689L, 1853L, 1817L, 1549L, 1079L, 1755L, 1973L, 1453L, 1139L, 1576L, 1928L, 1634L, 1961L, 1995L, 1272L, 1839L, 1976L, 1664L, 1956L, 1933L, 1981L, 1665L, 1057L, 1798L, 1485L, 2004L, 1990L, 2002L, 82L, 1922L, 1544L, 201L, 1730L, 1607L, 1597L, 1098L, 1490L, 1955L, 1194L, 1733L, 1245L, 1761L, 1709L, 1143L, 1828L, 1450L, 1569L, 1997L, 1943L, 1555L, 1958L, 1176L, 1858L, 1937L, 1560L, 1979L, 1962L, 1658L, 1959L, 2007L, 1636L, 1460L, 348L, 1084L, 1952L, 1162L, 1772L, 701L, 1462L, 1680L, 1639L, 1625L, 1060L, 1600L, 1631L, 1638L, 1350L, 1675L, 1366L, 1244L, 1413L, 994L, 1533L, 1199L, 1653L, 1902L, 1340L, 1819L, 1676L, 1081L, 1953L, 1993L, 1652L, 1214L, 1815L, 1977L, 1939L, 2000L, 1879L, 1948L, 1982L, 1983L, 1247L, 1969L, 1149L, 1682L, 1456L, 2001L, 1674L, 1531L, 1464L, 1243L, 1511L, 1867L, 1479L, 1873L, 1136L, 1087L, 1651L, 1855L, 1122L, 1505L, 1974L, 1692L, 1992L, 1361L, 1666L, 1100L, 1193L, 1978L, 1529L, 1903L, 1510L, 1152L, 1514L, 1591L, 1753L, 1744L, 1985L, 1459L, 1954L, 1579L, 1307L, 1975L, 1934L, 1589L, 971L, 1603L, 1980L, 1942L, 1160L, 1986L, 1963L, 1921L, 1481L, 1736L, 1616L, 1968L, 1201L, 1489L, 1781L, 1021L, 1452L, 1570L, 1326L, 1831L, 2006L, 1541L, 1690L, 1877L, 1447L, 1988L, 1411L, 1535L, 1799L, 1587L, 1255L, 1611L, 1419L, 1947L, 1626L, 132L, 1946L, 1950L, 1487L, 1496L, 1949L, 1155L, 1628L, 1738L, 2010L, 1446L, 1466L, 1630L, 1784L, 1989L, 1458L, 1741L)

# might need this
my_len <- length(my_input)

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

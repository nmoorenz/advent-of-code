library(openssl)

i = 0
inp = 'iwrupvqb'
chck = ''

while (substr(chck, 1, 6) != '000000') {
    i = i + 1
    chck = md5(paste0(inp, as.character(i)))
}

print(i)
print(chck)

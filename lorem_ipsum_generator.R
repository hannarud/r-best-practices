library(stringi)
nchar(stri_rand_lipsum(nparagraphs = 1, start_lipsum = FALSE))

lala1 <- stri_rand_lipsum(nparagraphs = 214, start_lipsum = FALSE)
sum(nchar(lala1))

write(x = paste(lala1, collapse = "\n"), file = "lala2.txt")

# Limit to 100000
sss <- paste(lala1, collapse = "\n")
nchar(sss)
sss <- substr(sss, 1, 100000)
sss1 <- paste0(sss, "a")
nchar(sss1)
sss2 <- substr(sss, 1, 99999)
nchar(sss2)

write(x = paste(sss, collapse = "\n"), file = "lala_100000.txt")
write(x = paste(sss1, collapse = "\n"), file = "lala_100001.txt")
write(x = paste(sss2, collapse = "\n"), file = "lala_99999.txt")

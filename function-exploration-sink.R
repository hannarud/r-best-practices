


zz <- file("all.Rout", open = "wt")
sink(zz)
sink(zz, type = "message")
log("a")
## revert output back to the console -- only then access the file!
sink(type = "message")
sink()
file.show("all.Rout")


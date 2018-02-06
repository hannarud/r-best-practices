# load package
library(googlesheets)

# which google sheets do you have access to?
# may ask you to authenticate in a browser!
my_sheets <- gs_ls()

# get the Britain Elects google sheet
be <- gs_title("Youth and Juniors database")

# list worksheets
gs_ws_ls(be)

# get Westminster voting
west <- gs_read(ss=be, ws = "2017")

# convert to data.frame
wdf <- as.data.frame(west)

# reverse so that data are forward-sorted by time
wdf <- wdf[2769:1,]

# treat all dates as a single point on x-axis
dates <- 1:2769

# smooth parameter
fs <- 0.04

# plot conservative
plot(lowess(dates, wdf$Con, f=fs), type="l", col="blue", lwd=5, ylim=c(0,65), xaxt="n", xlab="", ylab="%", main="Polls: Westminster voting intention")

# add labels
axis(side=1, at=dates[seq(1, 2769, by=40)], labels=paste(wdf$"Fieldwork end date", wdf$Y)[seq(1, 2769, by=40)], las=2, cex.axis=0.8)

# plot labour and libdem
lines(lowess(dates, wdf$Lab, f=fs), col="red", lwd=5)
lines(lowess(dates, wdf$LDem, f=fs), col="orange", lwd=5)

# add UKIP, and we treat absent values as -50 for plotting purposes
ukip <- wdf$UKIP
ukip[is.na(ukip)] <- -50
lines(lowess(dates, ukip, f=fs), col="purple", lwd=5)

# add legend
legend(1, 65, legend=c("Con","Lab","LibDem","UKIP"), fill=c("blue","red","orange","purple"))
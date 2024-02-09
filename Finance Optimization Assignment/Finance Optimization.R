library(quantmod)

AAPL1 <- getSymbols("AAPL")
getSymbols("AMZN")
getSymbols("MSFT")
getSymbols("GOOG")
getSymbols("HD")
getSymbols("BA")
getSymbols("T")
getSymbols("TSLA")
getSymbols("PG")
getSymbols("PTON")
getSymbols("NSRGY")
getSymbols("JNJ")
getSymbols("SBUX")
getSymbols("NKE")
getSymbols("GE")
getSymbols("DIS")
getSymbols("LMT")
getSymbols("WBD")
getSymbols("COST")

ALLData <- cbind(COST$COST.Close,
                 WBD$WBD.Close,
                 LMT$LMT.Close,
                 DIS$DIS.Close,
                 GE$GE.Close,
                 NKE$NKE.Close,
                 SBUX$SBUX.Close,
                 PTON$PTON.Close,
                 JNJ$JNJ.Close)

#Make some pictures
plot(ALLData$COST.Close, ylim=c(0,600))
lines(ALLData$WBD.Close,col="red")

ALL_day_ret <- cbind(dailyReturn(COST$COST.Close),
                     dailyReturn(WBD$WBD.Close),
                     dailyReturn(LMT$LMT.Close),
                     dailyReturn(DIS$DIS.Close),
                     dailyReturn(GE$GE.Close),
                     dailyReturn(NKE$NKE.Close),
                     dailyReturn(SBUX$SBUX.Close),
                     dailyReturn(JNJ$JNJ.Close),
                     dailyReturn(NSRGY$NSRGY.Close),
                     dailyReturn(PTON$PTON.Close),
                     dailyReturn(PG$PG.Close),
                     dailyReturn(TSLA$TSLA.Close),
                     dailyReturn(T$T.Close),
                     dailyReturn(BA$BA.Close),
                     dailyReturn(HD$HD.Close),
                     dailyReturn(GOOG$GOOG.Close),
                     dailyReturn(MSFT$MSFT.Close),
                     dailyReturn(AMZN$AMZN.Close),
                     dailyReturn(AAPL$AAPL.Close))

names( ALL_day_ret) <- c("COST","WBD","LMT","DIS","GE",
                         "NKE","SBUX","JNJ","NSRGY","PTON",
                         "PG","TSLA","T","BA","HD","GOOG",
                         "MSFT","AMZN","AAPL")
#Make a plot of one of these
plot(ALL_day_ret$COST)


#Get the average returns
Avg_Returns <- apply(ALL_day_ret, # Dataset
                     2,           # 1 rows, 2 cols
                     mean,         # function
                     na.rm = TRUE)    # Ignore NA    

Avg_Returns[1]

#Pert (Compounding Continuously)
time1 <- 1:3983


#Variance Covariance
Cov_Returns <- cov(ALL_day_ret,use = "pairwise.complete.obs")
dim(Cov_Returns)
Cor_Returns <- cor(ALL_day_ret,use = "pairwise.complete.obs")


##########################
D1 <- Cov_Returns

d1 <- rep(0,19)

b1  <- c(1,           # Equality constraint sum p_i=1
         0.0021,      # Target return value
         rep(0,19))   # p_i >= 0

A1 <- rep(1,19)
A1 <- matrix(  c(t(A1),                         # sum p_i
               Avg_Returns,                     # Average returns
               diag(19)),ncol=19,byrow=TRUE)    # p_i >= 0
A1 <-t(A1)

library(quadprog)
solve.QP(D1,
         d1,
         A1,
         b1,
         meq=2,
         factorized=FALSE)

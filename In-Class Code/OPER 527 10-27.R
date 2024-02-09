library ( quantmod )

getSymbols("AAPL")
getSymbols("AMZN")
getSymbols("MSFT")
getSymbols("GOOG")
getSymbols("HD")
getSymbols("BA")
getSymbols("T")
getSymbols("TSLA")
getSymbols("PG")
getSymbols("NSRGY")
getSymbols("JNJ")
getSymbols("PTON")
getSymbols("SBUX")
getSymbols("NKE")
getSymbols("GE")
getSymbols("DIS")
getSymbols("LMT")
getSymbols("WBD")
getSymbols("COST")

AllData <- cbind( COST$COST.Close, 
                  WBD$WBD.Close,
                  LMT$LMT.Close,
                  DIS$DIS.Close,
                  GE$GE.Close,
                  NKE$NKE.Close,
                  SBUX$SBUX.Close,
                  PTON$PTON.Close,
                  JNJ$JNJ.Close,
                  NSRGY$NSRGY.Close,
                  TSLA$TSLA.Close
                  )

# make some pictures
plot( AllData$COST.Close, ylim =c(0,600) )
lines( AllData$WBD.Close, col = "red")

allDayReturns <- cbind(dailyReturn( COST$COST.Close),
                      dailyReturn( WBD$WBD.Close),
                      dailyReturn( LMT$LMT.Close),
                      dailyReturn( DIS$DIS.Close),
                      dailyReturn( GE$GE.Close),
                      dailyReturn( NKE$NKE.Close),
                      dailyReturn( SBUX$SBUX.Close),
                      dailyReturn( PTON$PTON.Close),
                      dailyReturn( JNJ$JNJ.Close),
                      dailyReturn( NSRGY$NSRGY.Close),
                      dailyReturn( TSLA$TSLA.Close),
                      dailyReturn( T$T.Close),
                      dailyReturn( BA$BA.Close),
                      dailyReturn( HD$HD.Close),
                      dailyReturn( MSFT$MSFT.Close),
                      dailyReturn( AMZN$AMZN.Close),
                      dailyReturn( AAPL$AAPL.Close) )

names ( allDayReturns ) <- c( "COST", "WBD", "LMT", "DIS", "GE", "NKE", "SBUX", 
                              "PTON", "JNJ", "NSRGY", "TSLA", "T", "BA", "HD", 
                              "MSFT", "AMZN", "AAPL" )

# make a plot of one of these
plot (allDayReturns$COST)

# get the average returns
avgReturns <- apply( allDayReturns, # data set
                     2,             # 1 for rows, 2 for columns
                     mean,          # function
                     na.rm = TRUE ) # ignore NA values
time1 <- 1:3983
covReturns <- cov( allDayReturns, use = "pairwise.complete.obs" )
dim( covReturns)
corReturns <- cor( allDayReturns, use = "pairwise.complete.obs")

D1 <- covReturns
d1 <- rep(0,19)
b1 <- c( 1,               # equality constraint sum(p_i) = 1
         0.00001,           # target return value
         rep(0,19)        # p_i >= 0 
         )
A1 <- rep(1,19)
A1 <- matrix( c(t(A1),       # sum p_i
                avgReturns,  # average returns
                diag(19)), 
              ncol = 19, 
              byrow = TRUE     # p_i >= 0
             )

library( quadprog )
opt1 <- solve.QP( Dmat = as.matrix(D1),
                  dvec = d1, 
                  Amat = A1, 
                  bvec = b1, 
                  meq=1)

library(quantmod)

# 5 tech             - can spend up to 20%
# 5 retail           - can spend up to 20%
# 5 financial        - can spend up to 20%
# 10 choose your own 

# Tech Stocks
getSymbols("QCOM") # - Qualcomm
getSymbols("ZM")   # - Zoom
getSymbols("NVDA") # - Nvidia
getSymbols("INTC") # - Intel
getSymbols("IBM")  # - IBM

# Retail
getSymbols("AMZN") # - Amazon
getSymbols("COST") # - Costco
getSymbols("KR")   # - Kroger
getSymbols("DKS")  # - Dick's Sporting Goods
getSymbols("CVS")  # - CVS

# Financial
getSymbols("C")    # - Citigroup
getSymbols("PYPL") # - PayPal
getSymbols("GS")   # - Goldman Sachs
getSymbols("V")    # - Visa
getSymbols("JPM")  # - JP Morgan

# Free Choice
getSymbols("PFE")  # - Pfizer
getSymbols("HSY")  # - Hershey Chocolate
getSymbols("DE")   # - John Deere
getSymbols("TR")   # - Tootsie Roll Industries
getSymbols("K")    # - Kellogg's
getSymbols("NYT")  # - New York Times
getSymbols("PEP")  # - PepsiCo
getSymbols("PG")   # - Procter and Gamble
getSymbols("SWK")  # - Stanley Black and Decker
getSymbols("TSN")  # - Tyson Foods

allData <- cbind(QCOM$QCOM.Close,
                 ZM$ZM.Close,
                 NVDA$NVDA.Close,
                 INTC$INTC.Close,
                 IBM$IBM.Close,
                 AMZN$AMZN.Close,
                 COST$COST.Close,
                 KR$KR.Close,
                 DKS$DKS.Close,
                 CVS$CVS.Close,
                 C$C.Close,
                 PYPL$PYPL.Close,
                 GS$GS.Close,
                 V$V.Close,
                 JPM$JPM.Close,
                 PFE$PFE.Close,
                 HSY$HSY.Close,
                 DE$DE.Close,
                 TR$TR.Close,
                 K$K.Close,
                 NYT$NYT.Close,
                 PEP$PEP.Close,
                 PG$PG.Close,
                 SWK$SWK.Close,
                 TSN$TSN.Close)

allDayReturns <- cbind(dailyReturn(QCOM$QCOM.Close),
                       dailyReturn(ZM$ZM.Close),
                       dailyReturn(NVDA$NVDA.Close),
                       dailyReturn(INTC$INTC.Close),
                       dailyReturn(IBM$IBM.Close),
                       dailyReturn(AMZN$AMZN.Close),
                       dailyReturn(COST$COST.Close),
                       dailyReturn(KR$KR.Close),
                       dailyReturn(DKS$DKS.Close),
                       dailyReturn(CVS$CVS.Close),
                       dailyReturn(C$C.Close),
                       dailyReturn(PYPL$PYPL.Close),
                       dailyReturn(GS$GS.Close),
                       dailyReturn(V$V.Close),
                       dailyReturn(JPM$JPM.Close),
                       dailyReturn(PFE$PFE.Close),
                       dailyReturn(HSY$HSY.Close),
                       dailyReturn(DE$DE.Close),
                       dailyReturn(TR$TR.Close),
                       dailyReturn(K$K.Close),
                       dailyReturn(NYT$NYT.Close),
                       dailyReturn(PEP$PEP.Close),
                       dailyReturn(PG$PG.Close),
                       dailyReturn(SWK$SWK.Close),
                       dailyReturn(TSN$TSN.Close))

names(allDayReturns) <- c("QCOM", "ZM", "NVDA", "INTC", "IBM",
                         "AMZN", "COST", "KR", "DKS", "CVS",
                         "C", "PYPL", "GS", "V", "JPM",
                         "PFE", "HSY", "DE", "TR", "K",
                         "NYT", "PEP", "PG", "SWK", "TSN")

# get the average returns
avgReturns <- apply(allDayReturns,   
                     2,            
                     mean,         
                     na.rm = TRUE)

#Variance Covariance
covReturns <- cov(allDayReturns, use = "pairwise.complete.obs")
corReturns <- cor(allDayReturns, use = "pairwise.complete.obs")


##########################
D1 <- covReturns
d1 <- t(rep(0,25))

b1  <- c(1,           # equality constraint sum p_i=1
         0.00099,      # target return value
         rep(0,25),   # p_i >= 0
         -0.2,        # sum(tech) <= 0.2
         -0.2,        # sum(retail) <= 0.2
         -0.2)        # sum(financial) <= 0.2

# res1, res2, and res3 represent that we can 
# only spend 20% of our portfolio on each of: tech, finance, and retail
res1 <- rep(0,25)
res1[1] <- -1
res1[2] <- -1
res1[3] <- -1
res1[4] <- -1
res1[5] <- -1
res2 <- rep(0,25)
res2[6] <- -1
res2[7] <- -1
res2[8] <- -1
res2[9] <- -1
res2[10] <- -1
res3 <- rep(0,25)
res3[11] <- -1
res3[12] <- -1
res3[13] <- -1
res3[14] <- -1
res3[15] <- -1

A1 <- rep(1,25)
A1 <- matrix(c(t(A1),             # sum p_i
               avgReturns,        # Average returns
               diag(25),          # p_i >= 0
               res1,
               res2,
               res3),
             ncol=25,byrow=TRUE)
A1 <-t(A1)

library(quadprog)
opt <- solve.QP(D1,
         d1,
         A1,
         b1,
         meq=2,
         factorized=FALSE)
opt

#"value" is the risk
risk <- opt[[2]]
risk

# find the negative value of greatest magnitude
sol <- opt[[1]]
minVal <- min(sol)
minVal
# add the minVal to each element of xi 
# and use the norm to rescale the solutions to still sum to 1
sol <- (sol-minVal)/norm(as.matrix(sol))
# confirm that the result still sums to 1
sol
sum(sol)

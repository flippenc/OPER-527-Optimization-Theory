plus1 <- function(x1){
  res1 <- ifelse(x1 > 0, x1, 0)
  return(res1)
}

f1 <- function(x1){
  res1 <- 12 + x1/4
  res1 <- res1 + cos(8*pi*x1)
  for(k1 in 1:8){
    res1 <- res1 + k1*sin(plus1(x1/k1 - 1)*pi + k1/8)
  }
  return(res1)
}

x1 <- seq(0,20, by=0.01)
y1 <- f1(x1)

# Simulated annealing
steps <- 10000

results1 <- matrix(0, ncol=2, nrow=steps)

# starting value
x0 <- 15
plot(x1,y1, type="l")
# segments(x0,0,x0,f1(x0),col="red")
points(x0,f1(x0),col="red")
for(i in 1:steps){
  # test value
  x0t <- x0 + runif(1, -0.5, 0.5)
  # in general, might want x0t <- x0 + rnorm(1,0,1)
  
  # initial temperature
  T1 <- 100-(100/steps)+0.001
  
  # energy function
  # r1 <- exp(f1(x0t)/f1(x0)*T1)
  r1 <- exp((f1(x0t)-f1(x0))/T)
  
  # decide whether to keep it
  u1 <- runif(1,0,1)
  if(u1 < r1){
    if(x0t > 0 & x0t < 20){
      x0 <- x0t
    }
  }
  # save the results
  results1[i,1] <- x0
  results1[i,2] <- f1(x0)
  # plot the line segment for the accepted points
  segments(x0,0,x0,f1(x0),col="red")
}
points(x0,f1(x0),col="blue")

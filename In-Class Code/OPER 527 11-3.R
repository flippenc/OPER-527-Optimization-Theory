###############################################################################
# Penalty Method
#
###############################################################################
#
# max 0.3exp(-(x-16)^2) + 0.2exp( (-(x+3)/7)^2 ) + 0.5exp( (-y-6)^2)
# subject to 
# x >= 0
# y >= 0
# x+y <= 7
# x^2 + y^2 <= 5

f1 <- function(x1,y1){
  res1 <- 0.3*exp(-(x1-16)^2)
  res1 <- res1 + 0.2*exp(-((x1+3)/7)^2)
  res1 <- res1 + 0.5*exp(-(y1-6)^2)
  return(res1)
}

#negative portion
neg1 <- function (x1){
  res1 <- 0
  if (x1 <= 0){
    res1 <- x1
  }
  return(res1)
}

#Penalty 1
pen1 <- function(x1, y1){
  res1 <- neg1(7-x1 - y1)^2
  return(res1)
}

#Penalty 2, if x1^2+y^2-5 is negative

pen2 <- function(x1, y1){
  res1 <- (neg1(-x1^2 - y1^2 +5))^2
  return(res1)
}

#Penalty 3, if x1 is less than 0 (working correctly)
pen3 <- function(x1){
  res1 <- (neg1(x1))^2
  return(res1)
}

#Penalty 4, if y1 is less than 0 (working correctly)
pen4 <- function(y1){
  res1 <- (neg1(y1))^2
  return(res1)
}

# maximize the following, penalties detract from maximizing the function

obj1 <- function(x1, y1){
  f1(x1, y1) - pen1(x1, y1) - pen2 (x1, y1) - pen3(x1) - pen4(y1)
}

# numerical parameters
epsilon = 0.000001
stepSize = 0.1

# gradient calculation
gradObj1 <- function(x1,y1){
  res1 <- c(0,0)
  res1[1] <- (obj1(x1 + epsilon, y1) - obj1(x1 - epsilon, y1))/(2*epsilon)
  res1[2] <- (obj1(x1, y1 + epsilon) - obj1(x1, y1 - epsilon))/(2*epsilon)
  return(res1)
}

step1 <- c(stepSize, stepSize)
x0hold <- x0
x0 <- c( 2, 2)
error1 <- 1

while ( error1 > 0.0001 ){
    x0 <- x0 + gradObj1( x0[1], x0[2])*step1
    error1 <- t(gradObj1( x0[1], x0[2]))%*%gradObj1( x0[1], x0[2])
    x0hold <- rbind(x0hold, x0)
}

plot(x0hold, type = "b")
# for x^6, we had answer [1] -0.2736651  1.0000000
# for x^2, we had answer [1] -0.005968936  1.000000003
# start at x0 <- c(2,2) gave [1] -0.013027972 -0.002951479
# approximately the origin
# x0 <- c(1,1) gives approximately (0,1)
# we do not have a unique maximum
# x0 <- c(0,sqrt(5)) gives (0,sqrt(5))

x0
obj1(x0[1],x0[2])
f1(x0[1],x0[2])


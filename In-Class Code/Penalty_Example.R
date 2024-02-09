###########################
# Penalty method
###########################

# max 0.3exp(-(x-16)^2) + 0.2exp(-((x+3)/7)^2) + 0.5exp(-(y-6)^2)
# Subject to
# x >= 0
# y>= 10
# x+y <=7 linear constraint
# x^2 + y^2 <=5 nonlinear constraint

f1 <- function(x1,y1){
  res1 <- 0.3*exp(-(x1-16)^2)
  res1 <- res1 + 0.2*exp(-((x1+3)/7)^2)
  res1 <- res1 + 0.5*exp(-(y1-6)^2)
  return(res1)
}

barrier1 <- function( x1, k1 = 10){
  if(x1>0){
    res1 <- Inf
  }else{
    res1 <- 1/(1- exp(k1*(x1^2)))
  }
  return(res1)
}

constraint1 <- function(x1,y1){
  res1 <- x1^2 + y1^2 - 5
  return(res1)
}

constraint2 <- function(x1, y1){
  res1 <- x1 - y1 - 3
  return(res1)
}

obj1 <- function(x1, y1, k1 = 10){
  res1 <- f1(x1, y1)
  res1 <- res1 - barrier1(constraint1(x1,y1), k1)
  res1 <- res1 - barrier1(constraint2(x1,y1), k1)
  res1 <- res1 - barrier1(-x1, k1)
  res1 <- res1 - barrier1(-y1, k1)
  return(res1)
}

obj1deriv <- function(x1, y1, k1 = 10){
  res1 <- c(0,0)
  f1derivX <- 0.3*exp(-(x1-16)^2)*(-2*(x1-16))
  f1derivX <- f1derivX + 0.2*exp(-((x1+3)/7)^2)*(-2/7^2*(x1+3))
  f1derivY <- 0.5*exp(-(y1-6)^2)*(-2*(y1-6))
  # barrier functions below
  f1derivX <- f1derivX - (-1)*(exp(-k1*(x1+y1-3))-1)^(-2)*exp(-k1*(x1+y1-3))*(-1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*(x1+y1-3))-1)^(-2)*exp(-k1*(x1+y1-3))*(-1)*k1
  f1derivX <- f1derivX - (-1)*(exp(-k1*(x1^2+y1^2-5))-1)^(-2)*exp(-k1*(x1^2+y1^2-5))*(-2*x1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*(x1^2+y1^2-5))-1)^(-2)*exp(-k1*(x1^2+y1^2-5))*(-2*y1)*k1
  f1derivX <- f1derivX - (-1)*(exp(-k1*x1)-1)^(-2)*exp(-k1*x1)*(-1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*y1)-1)^(-2)*exp(-k1*y1)*(-1)*k1
  res1 <- c(f1derivX, f1derivY)
  return(res1)
}

# x1 <- seq(0,sqrt(5), by = 0.01)
# x2 <- rep(0, length(x1))
# y1 <- barrier1(constraint1(x1,x2))
# plot(x1,y1, type="l")

#negative portion
neg1 <- function(x1){
  res1 <- 0
  if (x1 <= 0){
    res1 <- x1
  }
  return(res1)
}

#Penalty 1
pen1 <- function(x1, y1){
  res1 <- neg1(7-x1 - y1)^6
  return(res1)
}

#Penalty 2, if x1^2+y^2-5 is negative
pen2 <- function(x1, y1){
  res1 <- (neg1(-x1^2 - y1^2 +5))^6
  return(res1)
}

#Penalty 3, if x1 is less than 0 (working correctly)
pen3 <- function(x1){
  res1 <- (neg1(x1))^6
  return(res1)
}

#Penalty 4, if y1 is less than 0 (working correctly)
pen4 <- function(y1){
  res1 <- (neg1(y1))^6
  return(res1)
}

# maximize the following, penalties detract from maximizing the function

obj1 <- function(x1, y1){
  f1(x1, y1) - pen1(x1, y1) - pen2 (x1, y1) - pen3(x1) - pen4(y1)
}

#numerical gradient
grad_obj1 <- function(x1, y1){
  res1 <- c(0, 0)
  res1[1] <- (obj1(x1 + 0.000001, y1) - obj1(x1 - 0.000001, y1))/(2*0.000001)
  res1[2] <- (obj1(x1, y1+0.000001) - obj1(x1, y1-0.000001))/(2*0.000001)
  return(res1)
}

####### search algorithm

x1 <- c(1,1)
step0 <- 0.01
x1hold <- c(0,0)
errorTolerance <- 0.0001
loopTolerance <- 500

# direction
count1 <- 0
error1 <- 1
while( error1 > (errorTolerance)^2){
  x1tmp <- x1 + step0*obj1deriv(x1[1],x1[2], k1 = 10)
  tmp2 <- obj1(x1tmp[1], x1tmp[2], k1 = 10)
  dtmp1 <- obj1deriv(x1[1],x1[2], k1 = 10)
  dtmp2 <- obj1deriv(x1tmp[1], x1tmp[2], k1 = 10)
  sign1tmp <- ifelse(sign(dtmp2) == sign(dtmp1), 1, 0)
  if( tmp2 == Inf | tmp2 == -Inf | prod(sign1tmp) == 0){
    step0 <- step0/2
  }else{
    x1hold <- x1tmp
    error1 <- t(x1hold -x1)%*%(x1hold - x1)
    x1 <- x1hold
  }
  count1 <- count1 + 1
  if( count1 > loopTolerance){
    break
  }
}
print( c(x1,error1, count1, step0) )
x1

#step1 <- c(0.001, 0.001)
#x0 <- c(1,1) #inside the feasible region, don't need to be in the feasible region though, penalties will point in the right direction anyways
#x0 <- x0 + grad_obj1( x0[1], x0[2])*step1
#x0
#Inside feasible region, there should no penalty input
#obj1(x0[1], x0[2]) #with penalties
#f1(x0[1], x0[2]) #without penalties



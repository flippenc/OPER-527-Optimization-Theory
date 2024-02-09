# max ln(sin(x/4)sin(y)e^g(x,y))
# where g(x,y) = -1/8(10.25x^2 - 19.48xy - 9.18x + 10.25y^2 - 9.18y + 82.62)
# subject to:
# x >= 0
# y >= 0
# y + 3x <= 30
# 30y + 11x <= 300
# 10x + 10y - xy <= 92

# the exponent of the objective function
g1 <- function(x1, y1){
  res1 <- 10.25*x1^2 
  res1 <- res1 - 19.48*x1*y1 
  res1 <- res1 - 9.18*x1 
  res1 <- res1 + 10.25*y1^2 
  res1 <- res1 - 9.18*y1 
  res1 <- res1 + 82.62
  res1 <- -0.125*res1
  return(res1)
}

cotangent1 <- function(x1){
  res1 <- 1/tan(x1)
  return(res1)
}

f2 <- function(x1, y1){
  res1 <- sin(x1/4)*sin(y1)*exp(g1(x1,y1))
  return(res1)
}

f1 <- function(x1, y1){
  res1 <- sin(x1/4)*sin(y1)*exp(g1(x1,y1))
  res1 <- log(res1)
  return(res1)
}

# min(x1,0)
neg1 <- function(x1){
  res1 <- 0
  if (x1 <= 0){
    res1 <- x1
  }
  return(res1)
}

# constraint for y+3x-30
constraint1 <- function(x1,y1){
  res1 <- y1 + 3*x1 - 30
  return(res1)
}

# constraint for 30y+11x-300
constraint2 <- function(x1,y1){
  res1 <- 30*y1 + 11*x1 - 300
  return(res1)
}

# constraint for 10x+10y-xy-92
constraint3 <- function(x1,y1){
  res1 <- 10*x1 + 10*y1 - x1*y1 - 92
  return(res1)
}

# penalty1 is for y+3x-30
penalty1 <- function(x1, y1){
  res1 <- (neg1(constraint1(x1,y1)))^2
  return(res1)
}

# penalty2 is for 30y+11x-300
penalty2 <- function(x1,y1){
  res1 <- (neg1(constraint2(x1,y1)))^2
  return(res1)
}

# penalty3 is for 10x+10y-xy-92
penalty3 <- function(x1,y1){
  res1 <- (neg1(constraint3(x1,y1)))^2
  return(res1)
}

# barrier1 is for x <= 0 and y <= 0
barrier1 <- function( x1, k1 = 6 ){
  if (x1 > 0){
    res1 <- Inf
  }
  else{
    res1 <- 1/(1 - exp(k1*x1))
  }
  return(res1)
}

# maximize the following
obj1 <- function(x1,y1,k1=6){
  res1 <- f1(x1,y1) 
  res1 <- res1 - penalty1( x1, y1)
  res1 <- res1 - penalty2( x1, y1)
  res1 <- res1 - penalty3( x1, y1)
  res1 <- res1 - barrier1(-x1, k1)
  res1 <- res1 - barrier1(-y1, k1)
  return(res1)
}

obj1deriv <- function(x1, y1, k1 = 6){
  # fx = 1/4cot(x/4) - 2.5625x + 2.435y  + 1.1475
  # fy =    cot(y)   + 2.435x  - 2.5625y + 1.1475
  f1derivX <- 0.25*cotangent1(0.25*x1) - 2.5625*x1 + 2.435*y1  + 1.1475
  f1derivY <-      cotangent1(y1)      + 2.435*x1  - 2.5625*y1 + 1.1475
  
  # penalty derivatives below
  # p1x = neg1(6(3x+y-30))
  # p1y = neg1(2(y+3x-30))
  f1derivX <- f1derivX - neg1(6*(3*x1 +   y1 - 30))
  f1derivY <- f1derivY - neg1(2*(  y1 + 3*x1 - 30))
  
  # p2x = neg1(242x+660y-6600)
  # p2y = neg1(1800y+660x-1800)
  f1derivX <- f1derivX - neg1( 242*x1 + 660*y1 - 6600)
  f1derivY <- f1derivY - neg1(1800*y1 + 660*x1 - 1800)
  
  # p3x = neg1(2(y-10)((y-10)x-10y+92))
  # p3y = neg1(2(x-10)((x-10)y-10x+92))
  f1derivX <- f1derivX - neg1(2*(y1-10)*((y1-10)*x1-10*y1+92))
  f1derivY <- f1derivY - neg1(2*(x1-10)*((x1-10)*y1-10*x1+92))
  
  # barrier derivatives below
  # b1x = same as in class example
  f1derivX <- f1derivX - (-1)*(exp(-k1*x1)-1)^(-2)*exp(-k1*x1)*(-1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*y1)-1)^(-2)*exp(-k1*y1)*(-1)*k1
  
  res1 <- c(f1derivX, f1derivY)
  return(res1)
}

####### search algorithm code from class

x1 <- c(1,1)
step0 <- 0.01
x1hold <- c(0,0)
errorTolerance <- 0.00001
loopTolerance <- 5000

count1 <- 0
error1 <- 1
while( error1 > (errorTolerance)^2){
  x1tmp <- x1 + step0*obj1deriv(x1[1],x1[2], k1 = 6)
  tmp2 <- obj1(x1tmp[1], x1tmp[2], k1 = 6)
  dtmp1 <- obj1deriv(x1[1],x1[2], k1 = 6)
  dtmp2 <- obj1deriv(x1tmp[1], x1tmp[2], k1 = 6)
  sign1tmp <- ifelse(sign(dtmp2) == sign(dtmp1), 1, 0)
  if( tmp2 == Inf | tmp2 == -Inf | prod(sign1tmp) == 0 | is.nan(tmp2)){
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
xResult <- x1[1]
yResult <- x1[2]
xResult
yResult
f2(xResult, yResult)
# best found so far:
# x = 7.041951
# y = 1.913295
f2(7.041951,1.913295)












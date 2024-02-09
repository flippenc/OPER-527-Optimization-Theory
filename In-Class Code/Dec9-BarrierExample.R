###############################################
# Barrier method
#
###############################################
#
# max 0.3exp(- (x-16)^2 ) + 0.2exp( -( (x+3)/7)^2 ) +0.5exp( -(y-6)^2 )
# Subject to
# x >= 0
# y >= 0
# x+y <= 7
# x^2 + y^2 <= 5

#0bjective function
f1 <- function(x1,y1){
  res1 <- 0.3*exp(- (x1-16)^2 )
  res1 <- res1 + 0.2*exp( -( ( x1 + 3 )/7)^2 )
  res1 <- res1 +0.5*exp( -( y1 - 6 )^2 )
  return( res1 )
}

barrier1 <- function( x1, k1 = 10 ){
  if( x1 > 0 ){
    res1 <- Inf
  }else{
    res1 <- 1/( 1 - exp( k1*( x1 ) )  )
  }
  return( res1 )
}

constraint1 <- function(x1,y1){
  res1 <- x1^2 + y1^2 - 5
  return( res1 )
}

constraint2 <- function( x1, y1 ){
  res1 <- x1 - y1 - 3
  return( res1 )
}

# maximize the following
obj1 <- function( x1, y1, k1 = 10 ){
  res1 <- f1(x1, y1)
  res1 <- res1 - barrier1(constraint1(x1,y1), k1)
  res1 <- res1 - barrier1(constraint2(x1,y1), k1)
  res1 <- res1 - barrier1( -x1, k1  )
  res1 <- res1 - barrier1( -y1, k1  )
  return( res1 )
}

obj1deriv <- function( x1, y1, k1 = 10 ){
  f1derivX <- 0.3*exp(-(x1-16)^2)*(-2*( x1-16 ))
  f1derivX <- f1derivX + 0.2*exp(-( (x1+3)/7 )^2)*(-2/7^2*( x1+3 ))
  f1derivY <- 0.5*exp(-(y1-6)^2)*(-2*( y1-6 ))
  # Barrier derivatives below
  f1derivX <- f1derivX - (-1)*(exp(-k1*(x1-y1-3) )-1)^(-2)*exp(-k1*(x1-y1-3))*(-1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*(x1-y1-3) )-1)^(-2)*exp(-k1*(x1-y1-3))*(-1)*k1
  
  f1derivX <- f1derivX - (-1)*(exp(-k1*(x1^2 + y1^2 - 5 ) ) -1)^(-2)*exp(-k1*(x1^2 + y1^2 - 5 ))*(-2*x1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*(x1^2 + y1^2 - 5 ) ) -1)^(-2)*exp(-k1*(x1^2 + y1^2 - 5 ))*(-2*y1)*k1
  
  f1derivX <- f1derivX - (-1)*(exp(-k1*x1)-1)^(-2)*exp(-k1*x1)*(-1)*k1
  f1derivY <- f1derivY - (-1)*(exp(-k1*y1)-1)^(-2)*exp(-k1*y1)*(-1)*k1
  res1 <- c( f1derivX, f1derivY )
  return(res1)
}

####### search algorithm

x1 <- c(0.5,0.5)
step0 <- 0.01
x1hold <- c(0,0)

# Direction
count1 <- 0
error1 <- 1
while( error1 > (0.00001)^2) {
  x1tmp <- x1 + step0*obj1deriv( x1[1], x1[2], k1 = 100 )
  tmp2 <- obj1(x1tmp[1],x1tmp[2], k1 = 100)
  dtmp1 <- obj1deriv( x1[1], x1[2], k1 = 100 )
  dtmp2 <- obj1deriv( x1tmp[1], x1tmp[2], k1 = 100 )
  sign1tmp <- ifelse( sign( dtmp2 ) == sign( dtmp1 ), 1, 0 )
  if( tmp2 == Inf | tmp2 == -Inf | prod(sign1tmp) == 0 ){
    step0 <- step0/2
  }else{
    x1hold <- x1tmp
    error1 <- t(x1hold - x1)%*%(x1hold - x1)
    x1 <- x1hold
  }
  count1 <- count1 + 1
  if( count1 > 5000 ){
    break
  }
}

x1    #  [1] 0.1005504 0.8531070
error1
count1
step0
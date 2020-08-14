n <- 20
B <- matrix(1:20,nrow=1,ncol=20)
A <- B
F <- function(n){
  if(n==1|n==2){
    return(1)
  }else{
    return(F(n-1)+F(n-2))
  }
}
for(i in 1:n){
  A[,i] <- F(i)
  print(c(i,F(i)))
}
plot(B,A)
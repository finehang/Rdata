#计算偏度峰度
myfun <- function(x,na.omit=FALSE){
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  skew <- (sum((x-m)^3)/n)/((sum((x-m)^2)/n)^(3/2))
  kurt <- (sum((x-m)^4)/n)/((sum((x-m)^2)/n)^2)-3
  return(c(n=n,mean=m,skew=skew,kurtosis=kurt))
}
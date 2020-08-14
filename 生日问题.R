a <- 366:1
f <- c(0)
g <- c(0)
for(i in 1:366){
  f[i] <- a[i]/366
  g[i] <- prod(f[c(1:i)])
}
plot(1-g)

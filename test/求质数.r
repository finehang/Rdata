n=1
for(i in 2:500){
  x <- 1
  for(j in 2:(i^0.5)){
    if(i%%j==0){
      x <- 0
      break
    }
  }
  if(i==2){
    print(c(n,2))
  }else{
    if(x==1){
      print(c(n+1,i))
      n <- n+1
    }
  }
}

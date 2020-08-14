n=1
a=0#设置初始条件
b <- matrix(c(0,0),ncol=2,byrow = T)#初始矩阵
while(a<0.5){#设定要达到的条件
  a <- 1-((1-0.02)^n)#调整中奖概率
  c <- matrix(c(n,a),ncol=2,byrow = T)#将新产生的次数与概率值构成新的矩阵
  b <- rbind(b,c)#将新矩阵与初始矩阵组合
  print(c(n,a))#输出每次的次数与概率值
  n <- n+1#递进
}
plot(b)#制图
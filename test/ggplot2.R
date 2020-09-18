library(ggplot2)

plot(mtcars$wt, mtcars$mpg, type="l")
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure/2, type="l",col="red")
points(pressure$temperature, pressure$pressure/2, col="red")

x <- pretty(-3:3, 200)
y <- dnorm(x)
plot(x,y, type="l")
barplot(table(mtcars$cyl), horiz=F)

hist(mtcars$mpg, breaks = 10)
boxplot(mtcars$mpg)

myfun <- function(x){
  1/(1+exp(-x+10))
}

curve(myfun(x), from=0, to=20)

dia <- diamonds[sample(nrow(diamonds), 100),]
names(dia)
qplot(carat, price,data = dia, colour=color, shape=cut, geom=c("point", "smooth"))
qplot(log(carat), log(price),data = dia)
qplot(carat, x*y*z, data=dia)
dim(dia)



library(splines)
qplot(carat, price,data = dia, geom=c("point", "smooth"), method="lm")

qplot(carat, price,data = dia, geom="boxplot", fill="bule")

qplot(color, price,data = dia, geom="boxplot", fill=color)

qplot(color, price,data = dia) + 
  geom_boxplot(outlier.colour = "green",
               outlier.size=10,
               fill = "red",
               color = "blue",
               size=2)

qplot(carat, data=dia, geom="histogram", fill = color)
qplot(carat, data=diamonds, geom="density", color = color)

qplot(color, data=dia, geom="bar", fill = color)

qplot(date, unemploy / pop, data = economics, geom="line")
qplot(date, uempmed, data = economics, geom=c("point", "path"))


attach(mpg)
head(mpg)
qplot(displ, hwy, data = mpg, geom=c("point", "smooth"), 
      color = factor(cyl), method="lm", formula = y~x)

qplot(displ, hwy, data = mpg, geom=c("point", "smooth"), facets = .~year) + geom_smooth()

# 取年份
year <- function(date){
  as.POSIXlt(date)$year + 1900
}
qplot(date, uempmed, data = economics, geom=c("point", "path"), color = year(date))


# 预定义图层
bestfit <- geom_smooth(method="lm", color = "steelblue", alpha=0.5, size=2)

qplot(sleep_rem, sleep_total, data = msleep) + bestfit

qplot(displ, hwy, data = mpg) + bestfit


p <- ggplot(mtcars, aes(x=mpg, y=wt))
p+geom_point(aes(color=factor(cyl)))
p+geom_smooth(aes(method = "lm"))

p <- ggplot(mtcars, aes(mpg, wt, group=cyl))
p+geom_smooth(aes(color = cyl),method = "lm")

library(gcookbook)
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight, fill = Cultivar)) +
  xlab("inter")+
  ylab("weight")+
  geom_bar(stat = "identity", width = .5, position = position_dodge(.7)) + 
  geom_text(aes(label = Weight), vjust = 1.5, position = position_dodge(0.7),color = "white", size = 5)

# 查看因子的所有组合
# vjust 调上下, position = position_dodge(0.7) 调左右


hp <- ggplot(diamonds,aes(carat, price))
hp+geom_point()
hp+geom_point(alpha=.1)
hp+stat_bin2d()
hp+stat_bin2d(bins=50)
library(hexbin)
hp+stat_bin_hex()+
  scale_fill_gradient(low="lightblue", high="red", limits=c(0,8000))

hp+stat_bin_hex()+
  scale_fill_gradient(low="lightblue", high="red", 
                      breaks=c(0, 250, 500, 1000, 3000, 5000),
                      limits=c(0,8000))

sp <- ggplot(ChickWeight, aes(Time, weight))
sp+geom_point()
sp+geom_point(position = "jitter")
sp+geom_point(position = position_jitter(width=.5, height=0))




model <- lm(heightIn~ageYear*I(ageYear^3), data=heightweight)
xmin <- min(heightweight$ageYear)
xmax <- max(heightweight$ageYear)
predicted <- data.frame(ageYear=seq(xmin, xmax, length.out = 100))
predicted$heightIn = predict(model, predicted)

sp <- ggplot(heightweight, aes(ageYear,heightIn))+geom_point()
sp+geom_line(data=predicted, size=1)


# 注解
p <- ggplot(faithful, aes(eruptions, waiting))+geom_point()
p+annotate("text", x = 3, y = 48, label="Group 1", family="serif", colour="darkred", size=7)+
  annotate("text", x=4.5, y=66, label="Group 2", family="serif", colour="darkred", size=9, alpha=.5)+
  annotate("text", x=2, y=80, parse=T, label="frac(1, sqrt(2*pi))*e^(-x^2/2)", size = 8)+
  geom_vline(xintercept = 2)+
  geom_hline(yintercept = 80)+
  geom_abline(intercept = 50, slope = 15)+
  annotate("segment", x=3, xend=4, y=70, yend=80)+
  ggtitle("Title")+
  annotate("rect", xmin=4, xmax=6, ymin=-Inf, ymax=Inf, alpha=.4, fill="blue")+
  theme(axis.title.x = element_text(color="red", size = 14))+
  theme(axis.title.y = element_text(color="red", size = 14))
  plot.title = element_text(color="red", size = 14)


  
  

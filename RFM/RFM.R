setwd("C:/Users/fanhang/Desktop/Rdata/RFM")
# data <- read.csv("data.csv")
names(data)
summary(data)

nnna <- function(x){
  mean(is.na(x))
}

mapply(nnna, data)

colSums(is.na(data)) / dim(data)[1]

# dataComplete
dc <- data[(complete.cases(data)),]
dc
colSums(is.na(dc))

# dataNotComplete
dnc <- data[(!complete.cases(data)),]
dnc

dnc$CustomerID <- "U"
dnc

# newData
nd <- rbind(dc, dnc)
colSums(is.na(nd))
sum(nd$CustomerID=="U")

head(nd)
# nd[[3]] <- NULL
nd$Amount <- nd$Quantity * nd$UnitPrice
nd

nnn <- function(x){
  strsplit(x, split = " ")[1]
}

sapply(strsplit(data$InvoiceDate, split = " "), "[", 1)

nd$Date <- sapply(strsplit(data$InvoiceDate, split = " "), "[", 1)
nd$Time <- sapply(strsplit(data$InvoiceDate, split = " "), "[", 2)

library(stringr)
nd$Date <- str_split_fixed(data$InvoiceDate, " ", 2)[,1]
nd$Time <- str_split_fixed(data$InvoiceDate, " ", 2)[,2]


# str_split 与 str_split_fixed
# str_split_fixed 默认返回矩阵, str_split 添加simplify = T 参数后与之相等

str_split(data$InvoiceDate, " ", 2, simplify = T)
# strsplit(data$InvoiceDate, " ", 2, simplify = T)
str_split_fixed(data$InvoiceDate, " ", 2)

# str_replace与str_replace_all, 前面函数只替换首次满足条件的子字符串，后面的函数可以替换所有满足条件的子字符串。


nd$Year <- str_split_fixed(nd$Date, "/", 3)[,3]
nd$Month <- str_split_fixed(nd$Date, "/", 3)[,1]
nd$Day <- str_split_fixed(nd$Date, "/", 3)[,2]

summary(nd)

df1 <- nd[which(nd$Quantity<0),]

df2 <- nd[which(nd$UnitPrice<0),]

ndSimple
nds <- nd
nds[c("StockCode", "Country", "Time", "Day", "InvoiceDate")] <- NULL

names(nds)

ndsmelt <- melt(nds, id=c("CustomerID", "InvoiceNo", "Year", "Month"))
str(ndsmelt)
newnds <- dcast(ndsmelt , Month ~ variable, mean)
head(newnds)

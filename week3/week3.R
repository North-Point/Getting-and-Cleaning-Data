library(dplyr)
library(jpeg)
library(apply)
sasetwd("/Users/North_Point/Dropbox/MOOC/Data_Science/Getting_and_Cleaning_Data/Quiz/week3")
if(!file.exists("./data")){
        dir.create("./data")
}
file.url.1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file.url.1, "./data/data1.csv", method = "curl")
data.1 = data.frame(read.csv("./data/data1.csv"))
data.1 = mutate(data.1, agricultureLogical = (ACR == 3 & AGS == 6))
sub.data.1 = data.1[which(data.1$agricultureLogical),]
head(sub.data.1,3)

file.url.2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(file.url.2, "./data/data2.jpg", method = "curl")
data.2 = readJPEG("./data/data2.jpg", native = TRUE)
quantile(data.2, c(0.3, 0.8))

file.url.3 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file.url.3, "./data/data3.csv", method = "curl")
data.3 = data.frame(read.csv("./data/data3.csv", skip = 4, na.strings = "NA"))
data.3 = select(data.3, c(1,2,4,5))
data.3 = rename(data.3, ID = X, Ranking = X.1, Economy = X.3, GDP = X.4)
data.3 = data.3[which(data.3$Ranking !="" ),]
data.3 = filter(data.3, Ranking %in% seq(1,190,1))
file.url.4 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file.url.4, "./data/data4.csv", method = "curl")
data.4 = data.frame(read.csv("./data/data4.csv"))
data.4 = select(data.4, CountryCode,Income.Group)
mer.data.1 = merge(data.4, data.3, by.y = "ID", by.x = "CountryCode")
mer.data.1 = mutate(mer.data.1, rk = as.numeric(as.character(Ranking)), gdp = as.numeric(as.character(GDP)))
dim(mer.data.1)
sort.data.1 = arrange(mer.data.1, desc(rk))
head(sort.data.1,15)
spl.data.1 = split(mer.data.1$rk, mer.data.1$Income.Group)
spl.data.1 = sapply(spl.data.1, mean)
str(mer.data.1)

quan.data.1 = quantile(mer.data.1$rk, probs = c(0,0.2, 0.4, 0.6, 0.8,1))
mer.data.1$cut = cut(mer.data.1$rk, quantile(mer.data.1$rk, probs = c(0,0.2, 0.4, 0.6, 0.8,1)))


head(mer.data.1)
table(mer.data.1$Income.Group, mer.data.1$cut)

#Q1
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile = "communities.csv")
data<- read.csv("communities.csv")
head(data)
split_data<-strsplit(names(data),"wgtp")
split_data[123]
split_data

#Q2
Q2_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(Q2_url, destfile="GDP.csv")
q2_data<-read.csv("GDP.csv",header=TRUE,nrows=190,skip=4)



head(q2_data)


gdp_no_comma<-str_remove_all(q2_data$X.4,",")

gdp_no_comma
gdp_data<-data.frame(as.integer(gdp_no_comma))




head(gdp_data)
mean(gdp_data$as.integer.gdp_no_comma.)


#Q4
gdp_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(gdp_url, destfile="gdp.csv")
q4_gdp_data<-read.csv("gdp.csv",header=TRUE,col.names=c("CountryCode","Rank", "NA","Economy","Total","NA","NA","NA","NA","NA"),nrows=190,skip=4)[,1:4]
head(q4_gdp_data)

edu<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(edu, destfile="edu.csv")
q4_data<-read.csv("edu.csv",header=TRUE)
head(q4_data)

q4_merged<-merge(q4_data,q4_gdp_data,  by.x='CountryCode',by.y='CountryCode')

grep("[Jj]une 30", q4_merged$Special.Notes)
gdp_jun<-filter(q4_merged,Special.Notes == grep("[Jj]une 30", q4_merged$Special.Notes,value=TRUE))

#Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
time<-data.frame(sampleTimes)

select(time)%>% filter(year(sampleTimes)==2012)%>% filter(wday(sampleTimes)=1)

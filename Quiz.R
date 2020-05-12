#Q1:
getwd()
list.files(getwd())
Q1<-read.csv(file = "getdata_data_ss06hid.csv")
x<-(Q1$VAL==24)
summary(x)

#Q2

#Q3
#wrong ans
list.files(getwd())
library(xlsx)
?read.xlsx
dat<-read.xlsx(file="getdata_data_DATA.gov_NGAP (1).xlsx", sheetIndex = 1,rowIndex = 18:23, colIndex = 7:15)

sum(dat$Zip*dat$Ext,na.rm=T)
#correct ans
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = paste0(getwd(), '/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'), method = "curl")

dat2 <- xlsx::read.xlsx(file = "getdata%2Fdata%2FDATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat2$Zip*dat2$Ext,na.rm=T)




#Q4
library(xml2)
library(XML)
files<-list.files(getwd())
xml_file<-files[4]
results<-xmlParse(file=xml_file)
rootNode<-xmlRoot(xml_file)
res <-XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)

rootnode<-xmlRoot(results)
xmldata_frame <- xmlToDataFrame(xml_file)




rootNode<-xmlRoot(xml_file)
 
xmlName(rootNode)


library("XML")
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- XML::xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- XML::xmlRoot(doc)

zipcodes <- XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)
library(data.table)
xmlZipcodeDT <- data.table::data.table(zipcode = zipcodes)
xmlZipcodeDT[zipcode == "21231", .N]


#Q5
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = getwd())
DT <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
system.time(DT[,mean(pwgtp15),by=SEX])

#Week 2
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("Getting_Cleaning_Data_W2",
                   key = "052d0cde8d8e2684b305",
                   secret = "fdb09528d42f477e1a6a2a9fa8b5e3c201817d77"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
#req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
#stop_for_status(req)
#content(req)


library(jsonlite)

json1=content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:20]
#specify row and column
json2[json2$full_name == "jtleek/datasharing", "created_at"]

#Q2,3
getwd()


Q2_files<-list.files(getwd())
read.csv("getdata_data_ss06pid.csv")

#Q4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode= readLines(con)
close(con)
htmlCode
library(XML)
url<-"http://biostat.jhsph.edu/~jleek/contact.html"
html<-htmlTreeParse(url,useInternalNodes=T)
xpathSApply(html,"//title",xmlValue)

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#Q5
Q5<-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines<-readLines(Q5,n=10)
lines
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(Q5, w, header = FALSE, skip = 4, col.names = colNames)

d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])

53
127
dt[,mean(pwgtp15),by=sex]



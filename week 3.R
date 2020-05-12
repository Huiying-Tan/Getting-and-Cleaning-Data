#week 3 
#Q1
q1_data<-read.csv("getdata_data_ss06hid.csv")
head(q1_data)
q1_data$ARC==3
agricultureLogical<-q1_data$ACR==3 & q1_data$AGS==6
which(agricultureLogical)

#Q2
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              , 'jeff.jpg'
              , mode='wb' )
# Read the image
picture <- jpeg::readJPEG('jeff.jpg'
                          , native=TRUE)

# Get Sample Quantiles corressponding to given prob
quantile(picture, probs =0.3 )
quantile(picture,probs=0.8)

#Q3
library(data.table)


# Download data and read FGDP data into data.table
FGDP <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip=4
                          , nrows = 190
                          , select = c(1, 2, 4, 5)
                          , col.names=c("CountryCode", "Rank", "Economy", "Total")
)

# Download data and read FGDP data into data.table
FEDSTATS_Country <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
)
merged_data<-merge(FEDSTATS_Country, FGDP,by="CountryCode")
nrow(merged_data)
merged_data

sort_merged_data<-arrange(merged_data,desc(Rank))
sort_merged_data[12,2]


merged_data[`Income Group`=="High income: OECD",
                          lapply(.SD, mean),
                          .SDcols = c("Rank"),
                          by = "Income Group"] 

merged_data[`Income Group` == "High income: nonOECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]


#Q5
breaks <- quantile(merged_data[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
breaks

merged_data$quantileGDP <- cut(merged_data[, Rank], breaks = breaks)
merged_data$quantileGDP
merged_data[`Income Group` == "Lower middle income", .N, by = c("Income Group", "quantileGDP")]


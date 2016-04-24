library(httr)
library(RJSONIO)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("Coursera_get_data",
                   key = "66de3201a8e6ad717444",
                   secret = "62060c508aa1145a0079f39eb54661501e935232")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,"created_at"]

acs = download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "./data/file1", method = "curl")
install.packages("sqldf")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50")
acs = read.csv2("./data/file1", header = TRUE, sep = ",")
head(acs)
sqldf("select distinct AGEP from acs")
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])
close(con)
x <- read.fwf(
        file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
        skip=4,
        widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
head(x)
sum(x[,"V4"])

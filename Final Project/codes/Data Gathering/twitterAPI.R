library(twitteR)
library(ROAuth)
library(jsonlite)
library(openssl)
library(httpuv)
library(base64enc)

consumerKey=as.character('ki41AXqMKOvxJxe1NVZT5whyh')
consumerSecret=as.character('BuGzC4jttU9j37OeGVOOAUJiKp6AQ6b4WGTKVFvtjBxA4rYNA9')
access_Token=as.character('1239699248624664577-R7hM1De1MnP0Flv4nUaAo3Gwztoc8k')
access_Secret=as.character('tJb88Y5FgadWifbJBW4YJQg3PFaAJ1YTmHGUUub8YjHhg')

requestURL='https://api.twitter.com/oauth/request_token'
accessURL='https://api.twitter.com/oauth/access_token'
authURL='https://api.twitter.com/oauth/authorize'

setup_twitter_oauth(consumerKey,consumerSecret,access_Token,access_Secret)

Search1 <- twitteR::searchTwitter("#FIFAWorldCup", n=10000, since="2020-01-01")
TweetsDF <- twListToDF(Search1)

TweetsDF$text <- gsub("[^[:alnum:][:blank:]?&/\\-]", "",TweetsDF$text)
TweetsDF$text <- gsub("https\\S*", "",TweetsDF$text)

write.csv(TweetsDF,"/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/Tweets.csv", row.names = FALSE)

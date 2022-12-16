# load in libraries
library(tidyr)
library(dplyr)

# load in required dataframes
quali2002 <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/2002Qualification.csv') 
quali2006 <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/2006Qualification.csv') 
quali2010 <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/2010Qualification.csv') 
quali2014 <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/2014Qualification.csv') 
quali2018 <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/2018Qualification.csv') 

# get subsets from dfs with columns we'll need for a join
sub2002 <- quali2002 %>%
  select(c('Team','FIFA.rankingat.start.of.event.1.','Consecutivefinalsappearances','Year'))
sub2006 <- quali2006 %>%
  select(c('Team','FIFARankingat.startofevent.2.','Consecutivefinalsappearances','Year'))
sub2010 <- quali2010 %>%
  select(c('Team','FIFARanking1','ConsecutiveStreak','Year'))
sub2014 <- quali2014 %>%
  select(c('Team','FIFARanking.nb.1.','Consecutiveappearances','Year'))
sub2018 <- quali2018 %>%
  select(c('Team','RankFIFA','Currentconsecutiveappearances','Year'))

# renaming columns to easily merge dfs
sub2002 <- sub2002 %>%
  rename('Team'=1,'RankFIFA'=2,'QualiStreak'=3,'Year'=4)
sub2006 <- sub2006 %>%
  rename('Team'=1,'RankFIFA'=2,'QualiStreak'=3,'Year'=4)
sub2010 <- sub2010 %>%
  rename('Team'=1,'RankFIFA'=2,'QualiStreak'=3,'Year'=4)
sub2014 <- sub2014 %>%
  rename('Team'=1,'RankFIFA'=2,'QualiStreak'=3,'Year'=4)
sub2018 <- sub2018 %>%
  rename('Team'=1,'RankFIFA'=2,'QualiStreak'=3,'Year'=4)

# merge dfs
all <- rbind(sub2002, sub2006, sub2010, sub2014, sub2018)
all

# remove text from QualiStreak column and insert NAs to empty cells
all$QualiStreak <- as.numeric(substr(all$QualiStreak, 1, 2))

# change year to categorical
all$Year <- as.factor(all$Year)

# export table to clean data folder
write.csv(all,'/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/cleanData/qualiClean.csv')


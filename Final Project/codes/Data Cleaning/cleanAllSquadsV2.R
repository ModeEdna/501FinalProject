# loading in df
squads <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/allSquadsV2.csv')

# checking for missing values
sum(is.na(squads))

# create vector of elite teams
elite <- c('Manchester United','Liverpool','Tottenham','Chelsea','Manchester City','Arsenal','Real Madrid','Barcelona','Atletico Madrid','Villareal',
           'Bayern Munich','Ajax','Inter Milan','Milan','Juventus','Lyon','Paris Saint-Germain','PSV Eindhoven','Porto','Benfica','Borussia Dortmund')

# clean club column, some cells have brackets and numbers
squads$Club <- gsub("\\[|\\]", "", squads$Club)
library(tm)
squads$Club <- removeNumbers(squads$Club)

# create column for players in elite team, TRUE (1) or FALSE (0)
squads <- squads %>%
  mutate(eliteClub = if_else(Club %in% elite, 1, 0))

# check column types
str(squads)

# change column types
squads$Pos. <- as.factor(squads$Pos.)
squads$Date.of.birth..age. <- as.Date(squads$Date.of.birth..age., format="%d-%b-%y")
squads$Caps <- as.integer(squads$Caps)
squads$Year <- as.factor(squads$Year)
squads$eliteClub <- as.factor(squads$eliteClub)

# check structure one last time
str(squads)

# export to clean data
write.csv(squads, '/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/cleanData/cleanAllSquadsV2.csv')

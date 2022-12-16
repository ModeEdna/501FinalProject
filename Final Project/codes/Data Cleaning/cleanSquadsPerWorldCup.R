# load in the df
countries <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/projectData/SquadsPerWorldCup.csv')

# check for missing values. we get 480, which represent the 3 empty columns I added with data pending
# i'll need to merge other tables to populate these columns, so they'll be NA for now
sum(is.na(countries))

# add empty column for amount of players in elite teams
countries$eliteTeamPlayers <- NA

# ensure categorical values don't have a value higher than 1 or lower than 0
max(countries$Host)
min(countries$Host)
max(countries$DifficultGroup)
min(countries$DifficultGroup)
max(countries$PastGroup)
min(countries$PastGroup)

# check data type to see if i need to change any of them
str(countries)

# change data types to desired data types
countries$Group <- as.factor(countries$Group)
countries$Year <- as.factor(countries$Year)
countries$Host <- as.factor(countries$Host)
countries$PastGroup <- as.factor(countries$PastGroup)
countries$DifficultGroup <- as.factor(countries$DifficultGroup)

# confirm data types changed to the desired ones
str(countries)

# remove x column
countries <- select(countries, -c(X))

# export df to clean data folder
write.csv(countries,'/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/cleanData/cleanSquadsPerWorldCup.csv')

# import libraries
library(naivebayes)
library(dplyr)
library(ggplot2)
library(tidyr)
library(caret)

# import data
data <- read.csv('/Users/modeedna/github-classroom/anly501/anly-501-project-ModeEdna/data/cleanData/allTables.csv')

# select columns we'll use # removed 'Host', 'DifficultGroup', 'QualiStreak', 'Age'
df <- select(data, c('eliteClub', 'RankFIFA', 'Caps', 'DifficultGroup'))
label <- select(data, 'PastGroup')

# normalize data
df_norm <- as.data.frame(scale(df))
df_norm$PastGroup <- as.factor(label$PastGroup)

# separate data
set.seed(123)
sample <- sample(c(TRUE, FALSE), nrow(df_norm), replace=TRUE, prob=c(0.7,0.3))
train <- df_norm[sample,]
test <- df_norm[!sample,]

# train model
nb <- naive_bayes(PastGroup ~ ., data=train, usekernel = T)

# predict on data
p <- predict(nb, train, type='prob')
head(cbind(p, train))

p1 <- predict(nb, train)
(tab1 <- table(p1, train$PastGroup))
p1
             
#######
library(gridExtra)
library(grid)
library(ggplot2)
library(dplyr)

table <- data.frame(confusionMatrix(p1, train$PastGroup)$table)

plotTable <- table %>%
  mutate(goodbad = ifelse(table$Prediction == table$Reference, "good", "bad")) %>%
  group_by(Reference) %>%
  mutate(prop = Freq/sum(Freq))

# fill alpha relative to sensitivity/specificity by proportional outcomes within reference groups (see dplyr code above as well as original confusion matrix for comparison)
cmp <- ggplot(data = plotTable, mapping = aes(x = Reference, y = Prediction, fill = goodbad)) +
  geom_tile() +
  geom_text(aes(label = Freq), vjust = .5, fontface  = "bold", alpha = 1) +
  scale_fill_manual(values = c(good = "lightgreen", bad = "lightcoral")) +
  xlim(rev(levels(table$Reference))) +
  ggtitle('Naive Bayes Prediction Train') +
  xlab('Predicted label') +
  ylab('True label') +
  theme(plot.title = element_text(hjust = 0.5, size=16), legend.position="none", axis.title=element_text(size=13))

cm <- confusionMatrix(p1,train$PastGroup)
cm_st <-data.frame(cm$overall)
cm_st$cm.overall <- round(cm_st$cm.overall,2)
cm_st_p <-  tableGrob(cm_st)
grid.arrange(cmp, cm_st_p, nrow = 1, ncol = 2, 
             top=textGrob("Confusion Matrix and Statistics",gp=gpar(fontsize=25,font=1)))

#######

# correct predictions
sum(diag(tab1)) / sum(tab1)

# test data
p2 <- predict(nb, test, type='prob')
head(cbind(p2, test))

p3 <- predict(nb, test)
(tab2 <- table(p3, test$PastGroup))
p3
sum(diag(tab2)) / sum(tab2)

#######

table <- data.frame(confusionMatrix(p3, test$PastGroup)$table)

plotTable <- table %>%
  mutate(goodbad = ifelse(table$Prediction == table$Reference, "good", "bad")) %>%
  group_by(Reference) %>%
  mutate(prop = Freq/sum(Freq))

# fill alpha relative to sensitivity/specificity by proportional outcomes within reference groups (see dplyr code above as well as original confusion matrix for comparison)
cmp2 <- ggplot(data = plotTable, mapping = aes(x = Reference, y = Prediction, fill = goodbad)) +
  geom_tile() +
  geom_text(aes(label = Freq), vjust = .5, fontface  = "bold", alpha = 1) +
  scale_fill_manual(values = c(good = "lightgreen", bad = "lightcoral")) +
  xlim(rev(levels(table$Reference))) +
  ggtitle('Naive Bayes Prediction Test') +
  xlab('Predicted label') +
  ylab('True label') +
  theme(plot.title = element_text(hjust = 0.5, size=16), legend.position="none", axis.title=element_text(size=13))

cm <- confusionMatrix(p3,test$PastGroup)
cm_st <-data.frame(cm$overall)
cm_st$cm.overall <- round(cm_st$cm.overall,2)
cm_st_p <-  tableGrob(cm_st)
grid.arrange(cmp2, cm_st_p, nrow = 1, ncol = 2, 
             top=textGrob("Confusion Matrix and Statistics",gp=gpar(fontsize=25,font=1)))

#######

confusionMatrix(p3, test$PastGroup)

# histograms to check normality
#hist(df_norm$Host)
hist(data$DifficultGroup)
hist(data$RankFIFA)
hist(data$QualiStreak)
hist(data$Caps)
hist(data$eliteClub)
#hist(df_norm$Age)


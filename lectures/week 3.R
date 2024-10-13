install.packages('tidyverse')
library(tidyverse)

surveys <- read.csv("data/portal_data_joined.csv")
surveys
class(surveys)
nrow(surveys)
ncol(surveys)
head(surveys)
tail(surveys)
View(surveys)
colnames(surveys)
rownames(surveys)
str(surveys)
summary(surveys)
length(unique(surveys$species))
length(unique(surveys$sex))


head_surveys <- surveys[1:6, ] 

surveys[1:6, ]
surveys[6:1, ]


surveys["species_id"]       # Result is a data.frame
surveys[, "species_id"]     # Result is a vector
surveys[["species_id"]]     # Result is a vector
surveys$species_id          # Result is a vector



surveys_200 <- surveys[200, ]
surveys_200

nrow(surveys)
surveys_last <- surveys[34786, ]
surveys_last
tail(surveys)

summary(surveys)

surveys_middle <- surveys[17762, ]



#TIDY VERSE
t_surveys <- read_csv("data/portal_data_joined.csv")
t_surveys
class(t_surveys)















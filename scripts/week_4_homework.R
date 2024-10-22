library(tidyverse)

#Create a tibble named surveys from the portal_data_joined.csv file.
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

#Subset surveys using Tidyverse methods to keep rows with weight between 30 and 60, 
#and print out the first 6 rows.

weight_30_60 <- filter(surveys, weight %in% 30:60)
head(weight_30_60)
weight_30_60

#answer ... slightly different than what I did, tibble has fewer rows
#i think %in% includes 30 and 60, whereas > and < dont 
surveys %>% 
  filter(weight > 30 & weight < 60)

#Create a new tibble showing the maximum weight for each species + sex combination and name it biggest_critters. 
#Sort the tibble to take a look at the biggest and smallest species + sex combinations. 
#HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(max_w = max(weight))

biggest_critters

biggest_critters %>% arrange(max_w)
biggest_critters %>% arrange(-max_w)

biggest: NL

#Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? 
#There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

arrange(surveys, -weight)
surveys %>% 
  tally(is.na(weight))

sum(is.na(surveys$weight))

#4 answer
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>% 
  arrange(-n)

#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. 
#Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.
surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(ave_weight = mean(weight)) %>% 
  select(species_id, sex, weight, ave_weight)

#other option to do same thing (but summarized, not including )
surveys_avg_weight2 <- surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(ave_weight = mean(weight))

surveys_avg_weight 

#Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination 
#(recall the new column we made for this tibble).
surveys_avg_weight %>% 
  mutate(above_average = weight > ave_weight)




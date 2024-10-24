# week 4 homework review ----

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

#part 2
#weight between 30 and 60
# %in% is equivalent to >= & <=

#part 3
#new tibble showing max weight for each species + sex combination
#filter out NAs

#part 3b - arrange biggest critters 

#part 4 - where are the NAs
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>%  arrange(-n)

#part 5 - remove rows when weight NA (filter)
#new column = avg weight of species + sex combo (group by then mutate)
#keep only certain columns (select)

#add additional summary columns. Just put a comma...helpful for midterm
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(ave_weight = mean(weight), max_weight = max(weight))

#Week 5 Lecture ----
# Conditional statements ----
## ifelse: run a test, if true do this, if false do this other thing
## case_when: basically multiple ifelse statements
# can be helpful to write "psuedo-code" first which basically is writing out what steps you want to take & then do the actual coding
# great way to classify and reclassify data

## Load library and data ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

## ifelse() ----
# from base R
# ifelse(test, what to do if yes/true, what to do if no/false)
## if yes or no are too short, their elements are recycled
## missing values in test give missing values in the result
## ifelse() strips attributes: this is important when working with Dates and factors

surveys_hindfoot_cat <- ifelse(surveys$hindfoot_length < mean                               (surveys$hindfoot_length, na.rm = TRUE), yes = "small",                               no = "big")
#na.rm = TRUE means that it will not include NAs in its calculation of mean

head(surveys_hindfoot_cat)
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)
unique(surveys$hindfoot_length)

## case_when() ----
# GREAT helpfile with examples!
# from tidyverse so have to use within mutate()
# useful if you have multiple tests (like you want to say big and small)
## each case evaluated sequentially & first match determines corresponding value in the output vector
## if no cases match then values go into the "else" category

# case_when() equivalent of what we wrote in the ifelse function
surveys %>%
  mutate(hindfoot_cat = case_when( 
    hindfoot_length > 29.29 ~ "big", #hindfood length over the mean (29.29) i want to reclassify as "big"
    TRUE ~ "small")) %>% #"else" part of statement...everything that does not match initial statement will be classified as small
  select(hindfoot_length, hindfoot_cat) %>%
  head()

# but there is one BIG difference - what is it?? (hint: NAs)
# if no "else" category specified, then the output will be NA

#multiple cases ----
#always a comma at the end of each case, except the last one
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length)~ NA_character_, #saying to label things that are NA as NA
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head(10)

# lots of other ways to specify cases in case_when and ifelse
# can classify things using different columns
surveys %>%
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1", 
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>%
  group_by(favorites)%>%
  tally()

#join and pivots ----
library(tidyverse)

tail <- read_csv('data/tail_length.csv')
surveys <- read_csv('data/portal_data_joined.csv')
dim(tail)
dim(surveys)
head(tail)

# join_function(data frame a, data frame b, how to join)


# inner_join only matches up things that match (e.g,, record id the same) does not include record id's that dont match
# inner_join(data frame a, data frame b, common id)
# inner_join only keeps records that are in both data frames

surveys_inner <- inner_join(x = surveys, y = tail)
dim(surveys_inner)


# left_join = no matter what keep everything on left side and will fill in NA when there isnt a match
#right join does the same but keeps everything on right side...recommend never using right join and just switching x and y
# left_join takes dataframe x and dataframe y and it keeps everything in x and only matches in y
#left_join(x, y) == right_join(y, x)
# right_join takes dataframe x and dataframe y and it keeps everything in y and only matches in x
#right_join(x, y) == left_join(y, x)

surveys_left <- left_join(x = surveys, y = tail)
dim(surveys_left)

surveys_right <- right_join(y = surveys, x = tail)
dim(surveys_right)


# full_join(x,y)
# full_join keeps EVERYTHING
surveys_full_join <- full_join( x = surveys, y = tail) #could also say (surveys, tail) because R assumes the first thing is x and second thing is y
dim(surveys_full_join)

#error because no common variable
left_join(surveys, tail %>% rename(record_id2 = record_id))
#work around to say they are the same
left_join(surveys, tail %>% rename(record_id2 = record_id), by = c('record_id'='record_id2'))

#Pivots ----
#pivots change shapes, like to make something more clear in a table
# pivot_wider makes data with more columns
pivot_wider()

# pivot_longer makes data with more rows
pivot_longer

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight)) 

surveys_mz
#long data frame...want it to look more like a traditional matrix

surveys_mz %>%
  pivot_wider(id_cols = 'genus', 
              names_from = 'plot_id',
              values_from = 'mean_weight')
#NAs are things that were not observed...so not best way to store data because you have to store the "nothing"

# ended lecture here

surveys_long <- wide_survey %>% pivot_longer(-genus, names_to = 'plot_id', values_to = 'mean_weight')

head(surveys_long)

wide_survey %>% pivot_longer(-genus, names_to = 'plot_id')


wide_survey %>% pivot_longer(-genus, names_to = 'plot_id',values_to = 'mean_weight')



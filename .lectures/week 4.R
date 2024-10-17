# Homework 3 Review -----
#Load your survey data frame with the read.csv() function. 
#Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. 
#Have this data frame only be the first 5,000 rows. 

#Convert both species_id and plot_type to factors. Remove all rows where there is an NA in the weight column. 
surveys_base$species_id <- factor(surveys_base$species_id)
#^naming vector with $ embeds the vector into the data frame?

#Explore these variables and try to explain why a factor is different from a character. Why might we want to use factors? Can you think of any examples?

#CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.


#LECTURE ----
#learning dplyr and tidyr: select, filter, and pipes

  #benefits of tidyverse
  #1. Predictable results (base R functionality can vary by data type) 
  #2. Good for new learners, because syntax is consistent. 
  #3. Avoids hidden arguments and default settings of base R functions
  
  #To load the package type:
  library(tidyverse)
    #now let's work with a survey dataset
    surveys <- read_csv("data/portal_data_joined.csv")
      
str(surveys)
        
#select columns
month_day_year <- select(surveys, month, day, year)
month_day_year
          
#filtering by equals
year_1981 <- filter(surveys, year == 1981)
str(year_1981)
sum(year_1981$year != 1981, na.rm = T)


#filtering by range
the80s <- surveys[surveys$year %in% 1981:1983,]
the80stidy <-filter(surveys,year %in% 1981:1983)
#5033 results
                   
                   
#review: why should you NEVER do:
the80srecycle <- filter(surveys, year == c(1981:1983))
#1685 results
#This recycles the vector 
#(index-matching, not bucket-matching)
#If you ever really need to do that for some reason,
#comment it ~very~ clearly and explain why you're 
#recycling!
                          
#filtering by multiple conditions
bigfoot_with_weight <- filter(surveys, hindfoot_length > 40 & !is.na(weight))
                                                        
#multi-step process
small_animals <- filter(surveys, weight < 5)
#this is slightly dangerous because you have to remember 
#to select from small_animals, not surveys in the next step
small_animal_ids <- select(small_animals, record_id, plot_id, species_id)
                                                                                                           
#same process, using nested functions
small_animal_ids <- select(filter(surveys, weight < 5), 
                           record_id, plot_id, species_id)
                                                                                                             
#same process, using a pipe
#Cmd Shift M = %>% 
#or |>
#note our select function no longer explicitly calls the tibble
#as its first element
small_animal_ids <- surveys %>% filter(., weight < 5) %>% 
  select(., record_id, plot_id, species_id)
#using a . to represent what is being fed through the pipe


#how to do line breaks with pipes
#need to make sure R knows the command is not complete
#e.g., after an open parenthesis
surveys %>% filter(
  month == 1)

#good: the indent tells you its connected to the line above
surveys %>%
  filter(month==1)
                                                                                                                     
#not good: because surveys by itself is a complete line of code
surveys 
%>% filter(month==1)
#what happened here?
                                                                                                                     
#line break rules: after open parenthesis, pipe,
#commas, 
#or anything that shows the line is not complete yet

                                                                                                                     
#one final review of an important concept we learned last week
#applied to the tidyverse
                                                                                                                     
mini <- surveys[190:209,]
table(mini$species_id)
#8 species with DM species ID
#12 species with NL
#how many rows have a species ID that's either DM or NL?...20
nrow(mini)

test <- mini %>% filter(species_id %in% c("DM," "NL"))

# Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column called weight_kg using the weigth column/1000
surveys <- surveys %>%
  mutate(., weight_kg = weight/1000)
str(surveys)

# Add other columns
surveys <- surveys %>%
  mutate(., 
         weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)

# Filter out the NA's (using complete cases here would filter out all NAs, 
#not just those in a certain column)
ave_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(mean_weight = mean(weight))


# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups, 
# apply some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 


# multiple groups
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))


# remove na's


# sort/arrange order a certain way
surveys %>%
  group_by(sex, species_id) %>%
  filter(sex != "") %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(mean_weight) #ascending
#(-mean_weight) would be descending

# Challenge
#What was the weight of the heaviest animal measured in each year? 
#Return a table with three columns: year, weight of the heaviest animal in grams, 
#and weight in kilograms, arranged (arrange()) in descending order, from heaviest 
#to lightest. (This table should have 26 rows, one for each year)
surveys %>% 
  select(year, record_id, weight) %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  group_by(year) %>% 
  summarize(max_weight_g = max(weight),
            max_weight_kg = max(weight) %>% 
              arrange()
#??? this ^ didnt work
  



#Try out a new function, count(). Group the data by sex and pipe the grouped data 
#into the count() function. How could you get the same result using group_by() and 
#summarize()? Hint: see ?n.
                
                        
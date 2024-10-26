library(tidyverse)

# 1. Create a tibble named surveys from the portal_data_joined.csv file. Then manipulate surveys to create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. So every row has a genus and then a mean hindfoot length value for every plot type. The dataframe should be sorted by values in the Control plot type column. This question will involve quite a few of the functions you’ve used so far, and it may be useful to sketch out the steps to get to the final result.

surveys <- read_csv("data/portal_data_joined.csv")

surveys <- surveys %>% 
  filter((!is.na(hindfoot_length))) %>% 
  group_by(genus, plot_type) %>% 
  summarize(mean_hindfoot = mean(hindfoot_length))
  
surveys_wide <- surveys %>%
    pivot_wider(id_cols = 'genus',
              names_from = 'plot_type',
              values_from = 'mean_hindfoot') %>% 
  arrange(Control)
surveys_wide

#2, Using the original surveys dataframe, use the two different functions we laid out for conditional statements, ifelse() and case_when(), to calculate a new weight category variable called weight_cat. For this variable, define the rodent weight into three categories, where “small” is less than or equal to the 1st quartile of weight distribution, “medium” is between (but not inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile. (Hint: the summary() function on a column summarizes the distribution). For ifelse() and case_when(), compare what happens to the weight values of NA, depending on how you specify your arguments.

surveys <- read_csv("data/portal_data_joined.csv")
summary(surveys$weight)

weight_cat <- ifelse(surveys$weight <= 20,
                     yes = "small")


surveys %>% 
  mutate(weight_cat = case_when(
    weight > 48 ~ "large",
    weight < 20 ~ "small",
    TRUE = ~ "medium")) %>% 
  group_by(weight_cat)

    
surveys




#BONUS: How might you soft code the values (i.e. not type them in manually) of the 1st and 3rd quartile into your conditional statements in question 2?
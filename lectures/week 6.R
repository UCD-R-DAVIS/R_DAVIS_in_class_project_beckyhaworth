library(tidyverse)
install.packages("ggplot2")

# ggplot2 ----
## Grammar of Graphics plotting package (included in tidyverse package - you can see this when you call library(tidyverse)!)
## easy to use functions to produce pretty plots
## ?ggplot2 will take you to the package helpfile where there is a link to the website: https://ggplot2.tidyverse.org - this is where you'll find the cheatsheet with visuals of what the package can do!

## ggplot basics
## every plot can be made from these three components: data, the coordinate system (ie what gets mapped), and the geoms (how to graphical represent the data)
## Syntax: ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPING>))

## tips and tricks
## think about the type of data and how many data  variables you are working with -- is it continuous, categorical, a combo of both? is it just one variable or three? this will help you settle on what type of geom you want to plot
## order matters! ggplot works by layering each geom on top of the other
## also aesthetics like color & size of text matters! make your plots accessible 


## example ----
library(tidyverse)
## load in data
surveys <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.)) # remove all NA's

## Let's look at two continuous variables: weight & hindfoot length
## Specific geom settings
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(aes(color = genus)) +
  geom_smooth(aes(color = genus))

## Universal geom settings. Putting the color in the initial ggplot command will apply it to all geom commands
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_point() +
  geom_smooth()

#color is for lines, fill is for like filling in a polygon


## Visualize weight categories and the range of hindfoot lengths in each group
## Bonus from hw: 
sum_weight <- summary(surveys$weight)
surveys_wt_cat <- surveys %>% 
  mutate(weight_cat = case_when(
    weight <= sum_weight[[2]] ~ "small", 
    weight > sum_weight[[2]] & weight < sum_weight[[5]] ~ "medium",
    weight >= sum_weight[[5]] ~ "large"
  )) 

table(surveys_wt_cat$weight_cat)


## We have one categorical variable and one continuous variable - what type of plot is best? 
ggplot(data = surveys_wt_cat, aes(x = weight_cat, y = hindfoot_length)) +
  geom_point(aes(color = weight_cat))
#BOX PLOT is better. Alpha is transparency...if you want to map things by the data, need to put within the aes function. Alpha is outside of that and not tied to the data, just going to make everything transparent.
ggplot(data = surveys_wt_cat, aes(x = weight_cat, y = hindfoot_length)) +
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) +
  geom_point(alpha = 0.1)

## What if I want to switch order of weight_cat? factor!
surveys_wt_cat$weight_cat <- factor(surveys_wt_cat$weight_cat, c("small", "medium", "large"))

ggplot(data = surveys_wt_cat, aes(x = weight_cat, y = hindfoot_length)) +
  geom_boxplot(aes(color = weight_cat), alpha = 0.5) +
  geom_jitter(alpha = 0.1)
#^geom jitter wont put points right on top of each other

#you can reorder geoms to layer them differently
ggplot(data = surveys_wt_cat, aes(x = weight_cat, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1) +
  geom_boxplot(aes(color = weight_cat), alpha = 0.5)

#pt 2 ----
library(tidyverse)

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))
head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)

head(yearly_counts)

ggplot(data = yearly_counts,mapping = aes(x = year, y = n)) +
  geom_point()

ggplot(data = yearly_counts,mapping = aes(x = year, y= n)) +
  geom_line()
#^ this looks really bad...to fix this, call a group function

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line() + 
  geom_point()
#^ issue here is that you cant differentiate by species id

ggplot(data = yearly_counts,mapping = aes(x = year, y= n, colour = species_id)) +
  geom_line()
#^this maybe looks worse, very messy. All the colors are the same...this is where faceting comes in. makes a separate plot for each

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line() +
  facet_wrap(~species_id)
#^faceting keeps the scale the same. A few different options for setting scale. 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free_y') 

#can also set number of rows or columns 
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free_y', nrow = 4) 

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line() +
  facet_wrap(~species_id) +
  scale_y_continuous(name = "obs")
#^names y axis

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line() +
  facet_wrap(~species_id) +
  theme_bw()
#^changes the backgrounds...other themes

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line() +
  facet_wrap(~species_id) +
  theme_minimal()

ggplot(data = yearly_counts,mapping = aes(x = year, y= n,group = species_id)) +
  geom_line() +
  facet_wrap(~species_id) +
  theme() #how to manipulate size, appearance, legend, etc.

#Mapping
#load tigris package

install.packages("ggthemes")
install.packages("tigris")

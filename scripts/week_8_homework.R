library(tidyverse)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

tz(mloa$year)

#With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. Generate a column called “datetime” using the year, month, day, hour24, and min columns. 

mloa <- mloa %>% 
  filter(rel_humid != -99) %>% #since the missing observations are negative, you could also just do != <0  or = >0 for all of these instead of the -99 values.
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>% 
  mutate(datetime = ymd_hm(paste(year, "-", month, "-", day, " ", hour24, ":", min))) #probably should use paste0 to make it so there are no extra spaces, or at the end say 'sep = "-"' to tell it do put dashes between...but will need to do a separate paste function for hour and min to put : between

#example - mutate(datetime = ymd_hm(paste(year, month, day, sep ="), paste(hour24, min, sep = ":")))

mloa$datetime

table(mloa$hour24)
  

#Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). 

mloa$datetimeLocal <- with_tz(mloa$datetime, tzone = "Pacific/Honolulu")

#Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). 

library(dplyr)

MeanTemp <- mloa %>% 
  select(temp_C_2m, datetimeLocal) %>% #i think selecting was unnecessary here?
  group_by(month(mloa$datetimeLocal, label = TRUE, abbr=TRUE), hour(mloa$datetimeLocal)) %>% 
  summarize(avehourlyTemp = mean(temp_C_2m))

MeanTemp %>% 
  rename(Month = `month(mloa$datetimeLocal, label = TRUE, abbr = TRUE)`) %>% 
  rename(Hour = `hour(mloa$datetimeLocal)`)


#Finally, make a ggplot scatterplot of the mean monthly temperatu`month(mloa$datetimeLocal, label = TRUE, abbr = TRUE)`#Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

ggplot(data = MeanTemp, mapping = aes(x = `month(mloa$datetimeLocal, label = TRUE, abbr = TRUE)`, y = avehourlyTemp)) + 
  geom_point(aes(color = `hour(mloa$datetimeLocal)`),show.legend = FALSE)+
  scale_color_viridis_c(option = "D", direction = -1) +
  theme_light()+
  xlab("Month") +
  ylab("Average Temperature (degrees C)") + 
  ggtitle("Mean Hourly Monthly Temperature")

#would be a good time to use a circular color palette because time 0 and 23 are next to each other in time but opposite ends of most color palettes. when they should be closely related. Khroma package (cyclic color maps)

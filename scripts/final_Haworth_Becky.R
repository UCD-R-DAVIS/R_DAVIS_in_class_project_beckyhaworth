#1. Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.

Tyler_data <- read.csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")
library(tidyverse)

#2. Filter out any non-running activities.

run_data <- Tyler_data %>% filter(sport == "running")

#3. We are interested in normal running. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.

run_data <- run_data %>% filter(minutes_per_mile > 5 & minutes_per_mile < 10) %>% filter(total_elapsed_time_s > 60)

#4. Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.

time_period_runs <-run_data %>% 
  mutate(time_period = case_when(
    year <= 2023 ~ "pre-2024",
    year == 2024 & month %in% 1:6 ~ "early 2024",
    T ~ "late 2024"))


#5. Make a scatter plot that graphs SPM over speed by lap.
#6. Make 5 aesthetic changes to the plot to improve the visual.
#7. Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())

library("RColorBrewer")

ggplot(data = time_period_runs, mapping = aes(x = minutes_per_mile, y = steps_per_minute))+
  geom_point(shape = 18)+
  scale_color_brewer(palette = "Dark2")+
  geom_smooth(mapping = aes(color = time_period), se = FALSE)+
  theme_light()+
  scale_color_discrete(breaks = c("pre-2024", "early 2024", "late 2024"))+
  theme(legend.title = element_blank())+
  xlab("Minutes per Mile")+
  ylab("Steps per Minute (seconds)")


#8. Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).

late_2024_runs <- time_period_runs %>% 
  filter(time_period == "late 2024") %>% 
  group_by(year, month, day) %>% 
  mutate(lap_number = rank(timestamp)) %>% 
  filter(lap_number %in% 1:3)

ggplot(data = late_2024_runs, mapping = aes(x = minutes_per_mile, y = steps_per_minute))+
  geom_jitter(aes(color = as.factor(lap_number)))+
  guides(color = guide_legend(title = "Lap")) +
  xlab("Minutes per Mile")+
  ylab("Steps per Minute (seconds)")
  


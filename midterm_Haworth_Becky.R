library(tidyverse)
#1
run_data <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")

#2 & 3
run_data <- run_data %>% 
  filter(sport =="running") %>% 
  filter(minutes_per_mile > 5 & minutes_per_mile < 10) %>% 
  filter(total_elapsed_time_s < 60)
#4
run_data <- run_data %>% 
  mutate(lap_pace = case_when(
    minutes_per_mile < 6 ~ "fast",
    minutes_per_mile > 6 & minutes_per_mile < 8 ~ "medium",
    TRUE ~ "slow"
  ))

run_data %>% select(minutes_per_mile, lap_pace)

run_data <- run_data %>% 
  mutate(form = case_when(
    year == 2024 ~ "new",
    TRUE ~ "old"
  ))

run_data %>% select(year, form)

#5
avg_steps <- run_data %>% 
  group_by(form, lap_pace) %>% 
  summarize(avg_step_pm = mean(steps_per_minute))

avg_steps %>% 
  pivot_wider(id_cols = "form",
              names_from = "lap_pace",
              values_from = "avg_step_pm") %>% 
  select("slow", "medium", "fast")

#6
#Jan-June 2024
run_data %>% 
  filter(month <= 6) %>% 
  filter(year == 2024) %>% 
  select(steps_per_minute) %>% 
  summary()

#July - Oct 2024
run_data %>% 
  filter(month > 6 & month <= 10) %>% 
  filter(year == 2024) %>% 
  select(steps_per_minute) %>% 
  summary()



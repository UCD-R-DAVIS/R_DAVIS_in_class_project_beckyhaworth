library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")

#Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

colnames(surveys)

for (i in unique(surveys$taxa)) {
  taxon <- surveys[surveys$taxa == i, ]
  longest_name <- taxon[nchar(taxon$species) == max(nchar(taxon$species)),]  #im confused about this step...why the == and why the select
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longest_name$species))
}

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

#2. Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.

colnames(mloa)

select_columns <- mloa %>% 
  select("windDir", "windSpeed_m_s", "baro_hPa", "temp_C_2m", "temp_C_10m", "temp_C_towertop", "rel_humid", "precip_intens_mm_hr")

map_df(select_columns, max, na.rm = T)

#3. Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!

C_to_F <- function(tempC){
 (tempC * 1.8)  + 273.15
}
C_to_F(100)

mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)

mloa %>% 
  select(c("temp_C_2m", "temp_C_10m", "temp_C_towertop")) %>% 
  map_df(C_to_F) %>% 
  rename(temp_F_2m = temp_C_2m, temp_F_10m = temp_C_10m, temp_F_towertop = temp_C_towertop)


  
  
  
  
  

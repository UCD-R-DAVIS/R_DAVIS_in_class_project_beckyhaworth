library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

head(gapminder)

select_gapminder <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year == 2002 | year == 2007) %>% 
  filter(!continent == "Oceania") %>% 
  pivot_wider(names_from = "year", values_from = "pop") %>% 
  mutate(popchange = (`2007` - `2002`)) %>%   
  arrange(continent)

library("RColorBrewer")
display.brewer.all(colorblindFriendly = TRUE)

ggplot(data = select_gapminder, mapping = aes(x = reorder(country, popchange), y = popchange)) +
  geom_col(aes(fill= continent), show.legend = FALSE) +
  scale_fill_brewer(palette = "Set2")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  facet_wrap(~ continent, scale = 'free') +
  ylab("Change in Population Between 2002 and 2007")+
  xlab("County") # + coord_flip (flips data on x and y axis)
  
  


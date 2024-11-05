library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#1. First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

colnames(gapminder)

gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(data = gapminder, mapping = aes(x = year, y = lifeExp, color = continent)) +  geom_smooth()


#2. Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#scale_x_log10 is telling the x axis to scale and be labeled in log 10. without this, most of the data is concentrated to the first quarter of the x axis
#geom_smooth line is fitting a dashed line to the data

  
#Challenge! Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

head(gapminder)

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#3. Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

gapminder$country

gapminder %>% 
  filter(country %in% c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  ggplot(mapping = aes(x= country, y = lifeExp)) + 
  geom_boxplot() +
  geom_jitter(alpha = 0.35, color = "purple") +
  xlab("County") +
  ylab("Life Expectancy") +
  ggtitle("Life Expectancy of Five Countries")


  






surveys <- read.csv("data/portal_data_joined.csv")
colnames(surveys)

#Create a new data frame called surveys_base with only the species_id, the weight, 
#and the plot_type columns. Have this data frame only be the first 5,000 rows.
surveys_base <- surveys[1:5000, c(6, 9, 13)]

#Remove all rows where there is an NA in the weight column.
surveys_base <- surveys_base[complete.cases(surveys_base), ]
surveys_base

#Convert both species_id and plot_type to factors. 
surveys_base_species_id <- factor(surveys_base$species_id)
class(surveys_base_species_id)
typeof(surveys_base_species_id)
nlevels(surveys_base_species_id)
levels(surveys_base_species_id)

surveys_base_plot_type <- factor(surveys_base$plot_type)
nlevels(surveys_base_plot_type)
levels(surveys_base_plot_type)

#A factor is different from a character because it has a numeric value associated with it

#CHALLENGE Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.
challenge_base <- surveys_base[surveys_base$weight > (150), ]
challenge_base



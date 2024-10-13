surveys <- read.csv("data/portal_data_joined.csv")
colnames(surveys)
surveys_base <- surveys[1:5000, c(6, 9, 13)]


surveys_base <- surveys_base[complete.cases(surveys_base), ]
surveys_base

surveys_base_species_id <- factor(surveys_base$species_id)
class(surveys_base_species_id)
typeof(surveys_base_species_id)
nlevels(surveys_base_species_id)
levels(surveys_base_species_id)

surveys_base_plot_type <- factor(surveys_base$plot_type)
nlevels(surveys_base_plot_type)
levels(surveys_base_plot_type)

#A factor is different from a character because it has a numeric value associated with it

#CHALLENGE
challenge_base <- surveys_base[surveys_base$weight > (150), ]
challenge_base



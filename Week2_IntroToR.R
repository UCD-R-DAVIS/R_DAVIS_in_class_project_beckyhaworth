3 + 5

3 * 7  

4 + (8 * 3) ^ 2 #use parenthesis to force order of operations

#scientific notation
2/10000 #2e-04
4e3 #4000

#mathematical functions
exp(1)

log(4)

sqrt(50)

#r help files
?log
log(2,4)
log(4,2)
log(x = 2, base = 4) #label arguments, defined within function, not our environment

#create variable called x, adds to values in environment. Avoid naming variables same name as variables defined within function
x <- 1
rm(x)

#nested functions
sqrt(exp(4))

#six comparison functions
mynumber <- 6 #recommended to use arrows to assign variables
mynumber == 5 #asking if my number equals 5..answer is false
mynumber #tab completion...start typing variable name and hit tab to complete

mynumber != 5 #is my number different than 5
mynumber < 4 #less than
mynumber > 3 #greater than
mynumber >= 6 #greater than or equal to
mynumber <= 8 #less than or equal to

othernumber <- -3

mynumber * othernumber #answer is -18

#object name conventions
numSamples <- 50
num_samples <- 40
#be consistent with naming convention...this created 2 values
rm(num_samples)

#errors and warnings
log("word") #error: non-numeric argument to mathematical function
log_of_word <- log("a_word")
#if error is that object is not found, can ctrl "f" search for it (may have a typo)

log(-2) #log of a negative...warning, Nan (not a number) produced
log_of_negative <- log(-2)
log_of_negative #equals NaN

#challenge
elephant1_kg <- 3492 #include unit in variable name
elephant2_kg <- 7757
rm(elephant2_kg)
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg*2.2 #convert to lbs

elephant2_lb > elephant1_lb #true

myelephants <- c(elephant1_lb, elephant2_lb)

which(myelephants == max(myelephants)) #which of my elephants is bigger...answer 2 (meaning the second one)


#PART 2 - Project Management
#working directory - a way to tell R where to pull information from
#whereever .Rproj file is located
getwd()
"C:/Users/becky/Documents/UC Davis/R-Projects/R_DAVIS_in_class_project_beckyhaworth"
#can change working directoring by doing setwd()

d <- read.csv("./data/tail_length.csv")

#create folder
dir.create("./lectures") #using a . tells it to create a folder one level down from the folder ur in
#after you create a folder or something, can add a # before it to make it text so it wont run again


#how R thinks about data
#differnet data types, vectors are most basic
#can set a series of values
weight_g <- c(50,60,65,82)
#c say its multiple values
animals <- c("mouse", "rat", "dog")

### Inspection ---- #number of hashtags is what header and dashes tell it to format (like a word doc)
length(weight_g) #answer is 4, meaning there are 4 values of weight_g
str(weight_g)

#change vectors
weight_g <- c(weight_g, 90)

#challenge
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
#coerces values to be all the same, e.g., TRUE means something, 1 (false means 0)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

#vectors have to be the same class of values...numbers or characters, when using "c" (concatination?)

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

##subsetting
animals <- c("mouse", "rat", "dog", "cat")
animals[2] #equals rat because its the second value
animals[c(2,3)] #rat, dog

weight_g <- c(21, 34, 39, 54, 55)
weight_g > 50 #False false false true true

weight_g[weight_g > 50] #gives you the number in the c group that meets this criteria (i.e., 54 55)


##Symbols
#%in% #whether something exists within list
#not good to use == here because that tries to pair things up

animals %in% c("rat", "cat", "dog", "duck", "goat")
#response is false true true true ...seeing if these options are in your original list
#mouse was in original list but not here, so false










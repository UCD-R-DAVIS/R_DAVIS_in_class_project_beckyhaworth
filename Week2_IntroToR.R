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

which(myelephants == max(myelephants)) #

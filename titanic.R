## Data Wrangling Exercise 2: Dealing with Missing Values
## Author: T. Sironen
## Data: titanic_original.csv
## ------------------------------------------------------
## 0: Load the data in RStudio
## Save the data set as a CSV file called titanic_original.csv 
## and load it in RStudio into a data frame.
## Set working directory to Springboard 
getwd( )
setwd("~/Desktop/Springboard")
## Download the dataset and take care of the missing values
titanic = read.csv("titanic_original.csv", header = TRUE, na.strings = c("NA", ""), blank.lines.skip = TRUE)
titanic = titanic[1:1309, ] ## removing empty line nro 1310 in the end

## Exploring data: 
View(titanic)
class(titanic) ## [1] "data.frame"
head(titanic)
str(titanic)
names(titanic)
## [1] "pclass"    "survived"  "name"      "sex"       "age"       "sibsp"    
## [7] "parch"     "ticket"    "fare"      "cabin"     "embarked"  "boat"     
## [13] "body"      "home.dest"


## 1: Port of embarkation (NA in embarked = passengers who actually embarked at Southampton)
summary(titanic$embarked) ## 2 NA's found , C= 270, Q = 123, S = 914
titanic$embarked[is.na(titanic$embarked)] <- "S" 
summary(titanic$embarked) ## C = 270, Q = 123, S = 916 (S increased by 2)


## 2: Age
## 1 -Calculate the mean of the Age column and use that value to populate the missing values
mean(titanic$age, na.rm = TRUE) ## [1] 29.88113
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE) ## populates the NAs with the mean age


## 3: Lifeboat (Distribution of people in the lifeboats)
## Already filled NA values for the missing boats in step 0. 

## 4: Cabin: (Create a new column has_cabin_number which has 1 if there is a cabin #,
## and 0 otherwise.)
library(dplyr)
titanic <- mutate(titanic, has_cabin_number = ifelse(cabin == "NA", 0, 1))
titanic$has_cabin_number[is.na(titanic$has_cabin_number)] <- "0" 


## 5: Submit the project on Github
write.csv(titanic, "titanic_clean.csv")
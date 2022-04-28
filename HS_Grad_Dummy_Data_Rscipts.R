library(tidyverse)

ID <- c(1:2.5E4)
ID <- str_pad(ID, 7, pad = "0")

Gender <- sample(c(1:2), 2.5e4, replace=TRUE, prob=c(.4948, .5052))                     
Race <- sample(c(1:4), 2.5e4, replace=TRUE, prob=c(.7, .134, .15, .2))                      
ACT_Score <- rnorm(2.5e4, mean=20.8, sd = 3)
HS_GPA <- sample(c(1.5:4),2.5e4, replace=TRUE)
HS_Type <- sample(c(1:3), 2.5e4, replace=TRUE, prob=c(.8,.15,.05))
College_Type <- sample(c(0:3), 2.5e4, replace=TRUE, prob=c(.1,.55,.05,.3))
PostHS_Plan <- sample(c(1:4), 2.5e4, replace=TRUE, prob=c(.65,.2,.1,.05))
FirstGen <- sample(c(1:2), 2.5e4, replace=TRUE, prob=c(.28,.72)) 
PellElig <- sample(c(1:2), 2.5e4, replace=TRUE, prob=c(.35,.65)) 

VA_FIPS <- read.csv("https://raw.githubusercontent.com/drcdavidson/mock_HSgrads/main/VA_FIPS.csv")

County_FIPS <- sample(VA_FIPS$County_FIPS, 2.5e4, replace=TRUE)
County_FIPS <- str_pad(County_FIPS, 3, pad = "0")

HSgrads <- data.frame(ID,Gender,Race,ACT_Score,HS_GPA,County_FIPS,
                      HS_Type,College_Type, PostHS_Plan,FirstGen,
                      PellElig)

VA_FIPS <- VA_FIPS %>% mutate(County_FIPS = str_pad(
                                as.character(County_FIPS),3,pad="0"))

HSgrads <- merge(HSgrads, VA_FIPS, by = "County_FIPS")

write.csv(HSgrads, "C:/Users/cdavi/OneDrive/Desktop/Documents/R_Projects/mock_HSgrads/HSgrads.csv",row.names = FALSE)

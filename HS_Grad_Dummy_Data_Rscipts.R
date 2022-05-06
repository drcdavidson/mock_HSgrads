library(tidyverse)

#Create Variables 
ID <- c(1:2.5E4)
ID <- str_pad(ID, 7, pad = "0")

Gender <- sample(c(1:2), 2.5e4, replace=TRUE, prob=c(.4948, .5052))                     
Race <- sample(c(1:4), 2.5e4, replace=TRUE, prob=c(.7, .134, .15, .2))                      
ACT_Score <- round(rnorm(2.5e4, mean=20.8, sd = 3),digits=0)
HS_Type <- sample(c(1:3), 2.5e4, replace=TRUE, prob=c(.8,.15,.05))
College_Type <- sample(c(0:3), 2.5e4, replace=TRUE, prob=c(.1,.55,.05,.3))
PostHS_Plan <- sample(c(1:4), 2.5e4, replace=TRUE, prob=c(.65,.2,.1,.05))
FirstGen <- sample(c(1:2), 2.5e4, replace=TRUE, prob=c(.28,.72)) 
PellElig <- sample(c(1:2), 2.5e4, replace=TRUE, prob=c(.35,.65)) 

GPA <- seq(from=1.75, to=4, by=.01)
HS_GPA <- sample(GPA, 2.5e4, replace=TRUE)  
rm(GPA)

#Import ACS Undergraduate Percentages 
ACS <- read.csv("https://raw.githubusercontent.com/drcdavidson/mock_HSgrads/main/ACS_Percent.csv")
ACS[1] <- str_pad(ACS$County_FIPS, 3, pad = "0")


#Create Random County_FIPS Proportional to ACS
County_UG <- tibble(County = rep(c(ACS$County_Name),ACS$UG.Population),
               Value = runif(488799))

County_UG_Sample <- County_UG %>% 
  group_by(County) %>%
  sample_frac(25000/488799)

#Delete 3 Random Rows for County
County_UG_Sample <- County_UG_Sample[-sample(1:nrow(County_UG_Sample), 3), ]

#Remove unneeded file
rm(County_UG)

#Create MOCK HSgrads Dataframe
HSgrads <- data.frame(ID,Gender,Race,ACT_Score,HS_GPA,
                      HS_Type,College_Type, PostHS_Plan,FirstGen,
                      PellElig,County_UG_Sample$County)

#Rename County_Name Column
names(HSgrads)[11] <- 'County_Name'

#Merge County_Names with FIPS
HSgrads <- merge(HSgrads,ACS,by="County_Name")

#Delete Unneeded Columns in HSgrads
HSgrads <- HSgrads[-c(14,15)]

#Save HSgrads as CSV for Tableau
write.csv(HSgrads, "C:/Users/cdavi/OneDrive/Desktop/Documents/R_Projects/mock_HSgrads/HSgrads.csv",row.names = FALSE)


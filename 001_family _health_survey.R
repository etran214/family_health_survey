library(tidyverse)
library(haven)

family_health_survey <- read_dta("IAHR52FL.dta")


# 01 get data ----of household data between "hhid" and "shstruc"
household_level <- 
  select(family_health_survey, hhid:shstruc)

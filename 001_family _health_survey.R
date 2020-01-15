library(tidyverse)
library(haven)

family_health_survey <- read_dta("IAHR52FL.dta")


# 01 get data ----of household data between "hhid" and "shstruc"
household_level <- 
  select(family_health_survey, hhid:shstruc)




# 02 plot ---- number of household members in the entire sample
#  hv009  -  the number of listed household members

ggplot(data = household_level, 
       mapping = aes(x = hv009)) +					
  geom_histogram( fill = 'orange', size = 6,
                  binwidth = 0.50) +				
  labs(x = "Number of Household Members",
       title = "Distribution of Household Size")




#  03 get data ---- for household size by type of urban areas
# reviewed survey questionnaire and recode5 map 
# hv009  -  the number of listed household members
# hv025 -  the type of place of residence (urban == 1) 
# hv0026 - place of residence 

family_health_survey%>% 
  group_by(hv025) %>% 
  count()
# this verifies that --- 1 == urban, count is 50236

family_health_survey%>% 
  group_by(hv026) %>% 
  count()
# place of residence listed as:
# 0 - captial / large city
# 1 - small city
# 2 - town
# 3 - countryside


urban_household <- family_health_survey %>% 
  select(hv009:hv026) %>% 
  rename(household_size = hv009, urban_areas = hv026) %>% 
  filter(hv025 == 1)

ggplot(data = urban_household, 
       mapping = aes(x = factor(urban_areas), y = household_size)) +
  geom_boxplot(color = 'brown') +
  labs(x = "Type of Urban Area", 
       y = "Number of Household Members",
       title = "Distribution of Household Size in Urban Areas")+
  scale_x_discrete(labels = c("Capital / Large City", "Small City", "Town"))

urban_household%>% 
  group_by(urban_areas) %>% 
  summarise(mean = mean(household_size),
            median = median(household_size))


urban_household%>% 
  group_by(urban_areas) %>% 
  summarise(mean = mean(household_size, na.rm = TRUE),
            median = median(household_size, na.rm = TRUE))               
#removing missing value shows the same data.






library(tidyverse)
library(tidytuesdayR)

tt <- tt_load('2021-01-19')

households <- tt$households %>% janitor::clean_names()
crops      <- tt$crops %>% janitor::clean_names()
gender     <- tt$gender %>% janitor::clean_names()


households <- households %>% 
  mutate(county = str_trim(tolower(county)))

crops <- crops %>% 
  rename(county = sub_county) %>% 
  mutate(county = str_trim(tolower(county)))

gender <- gender %>% 
  mutate(county = str_trim(tolower(county)))

census_data <- households %>% 
  inner_join(crops, by = 'county') %>% 
  inner_join(gender, by = 'county') 

census_data

write_csv(census_data, 'scripts/data/census_data.csv')




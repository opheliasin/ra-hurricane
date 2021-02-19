library(dplyr)
stores <- read.csv(file = "possible_store_counties.csv")

#assign GEOID to each county 
stores$hh_state_fips <- sprintf("%02d", stores$hh_state_fips)
stores$hh_county_fips <- sprintf("%03d", stores$hh_county_fips)

stores$geoid <- paste(stores$hh_state_fips,stores$hh_county_fips, sep="")

stores_summary <- stores %>% 
  group_by(geoid, hh_county) %>% 
  summarise(total_treated = sum(treated==1), total_stores = sum(treated==0 | treated==1)) %>%
  mutate(treated_percentage = total_treated/total_stores * 100)

stores_summary$treated_percentage <- round(stores_summary$treated_percentage,digits=2)

write.csv(stores_summary,"treated_stores.csv", row.names = FALSE)

library(tidyverse)
library(here)
library(sf)
library(janitor)

HDI <- read_csv(here::here("hw4_data", "HDR21-22_Composite_indices_complete_time_series.csv"),
                locale = locale(encoding = "latin1"),
                na = " ", skip=0)
World <- st_read("hw4_data/World_Countries_(Generalized)/World_Countries__Generalized_.shp")

install.packages("countrycode")
library(countrycode)

HDIcols <- HDI %>%
  clean_names()%>%
  select(iso3, country, gii_2019, gii_2010)%>%
  mutate(iso_code=countrycode(country, origin = "country.name", destination = 'iso2c'))%>%
  mutate(iso_code2=countrycode(iso3, origin = 'iso3c', destination = 'iso2c'))

join_HDI <- World%>%
  clean_names() %>%
  left_join(.,
            HDIcols,
            by = c("iso" = "iso_code"))

join_HDI2 <- World %>%
  clean_names() %>%
  left_join(.,
            HDIcols,
            by = c("country" = "country"))
  
### Samantha Rickle
### 28/09/2025
### Data Cleaning

library(readr)
library(tidyverse)
library(here)
library(ggthemes)
library(dplyr)
library(writexl)

ccz_ltu <- read.csv(here("Data/Micro_LTU.csv"))
ccz_ltu_filtered <- ccz_ltu %>% mutate(
  depth_range_m = case_when(Net.. == 1 ~ "1000-1500",
                            Net.. == 2 ~ "700-1000",
                            Net.. == 3 ~ "450-700",
                            Net.. == 4 ~ "70-450",
                            Net.. == 5 ~ "0-70")) %>% ## Renaming net #s to depth ranges
  filter(
    !Net..%in% c(0, "4plus5"),
    !tolower(Tow.Type) %in% "deep") ## filtering deep tows
    
chord_ccz <- filter(ccz_ltu_filtered, Phylum.broader.classification == "Chordata") ### filtering only chordata

target_sp_ccz <- filter(chord_ccz, LTU %in% c("Diaphus pacificus",
                                              "Diogenicthys laternatus",
                                              "Lampanyctus parvicauda", 
                                              "Scopeloberyx malayanus", 
                                              "Scopelogadus bispinosus", 
                                              "Argyropelecus lychnus", 
                                              "Bathylagoides nigrigenys", 
                                              "Vinciguerria lucetia", 
                                              "Idiacanthus antrostomus",
                                              "Scopelengys tristis"))
ccz_target_cleaned <- target_sp_ccz %>% ## deleting select columns
  select(-1, ## phylumn/broader classification
         -2, ## order
         -4, ## genera
         -5, ## species
         -18, ## depth filtered
         -19, ## volume filtered
         -20, ## corrected volume
         -21, ## volume filtered per 10,000m cubed
         -22, ## n per 10,000m cubed
         -23, ## n per 10,000m squared
         -24, ## mass
         -25, ## mass correction factor
         -26, ## corrected mass
         -27, ## g per 10,000m cubed
         -28, ## g per 10,000m squared
         -31, ## broad classification again
         -32, ## micronekton (y/n)
         -33, ## jar size
         -34) ## comments

ccz_target_cleaned <- ccz_target_cleaned[, c("Label", "Sample..", "n", "Family", "LTU", "Date", "Cruise.Number", "Site", "Tow.Type", "Tow..", "Net..", "depth_range_m", "Preservative", "ETP.Endemic.")]


write_xlsx(ccz_target_cleaned, path = "ccz_target_cleaned.xlsx") 

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
  filter(!Net..%in% c(0, "4plus5"), ## filtering out net 0s and 4plus5
         !Tow.Type%in% "Deep") ## filtering deep tows

chord_ccz <- filter(ccz_ltu, Phylum.broader.classification == "Chordata"), %>% ### filtering only chordara

target_sp_ccz <- filter(chord_ccz, LTU %in% c("Diaphus pacificus",
                                             "Diogenichthys laternatus", ### not showing up for some reason
                                             "Lampanyctus parvicauda", 
                                             "Scopeloberyx malayanus", 
                                             "Scopelogadus bispinosus", 
                                             "Argyropelecus lychnus", 
                                             "Bathylagoides nigrigenys", 
                                             "Vinciguerria lucetia", 
                                             "Idiacanthus antrostomus",
                                             "Scopelengys tristis"))


write_xlsx(target_sp_ccz, path = "target_sp_ccz.xlsx") 

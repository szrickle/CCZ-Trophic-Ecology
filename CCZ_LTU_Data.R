### Samantha Rickle
### 17/09/2025
### CCZ LTU data

### libraries
library(readr)
library(tidyverse)
library(here)
library(ggthemes)
library(dplyr)

### data
ccz_ltu <- read.csv("/Users/samantharickle/Desktop/R Stuff/CCZ-Trophic-Ecology/Data/Micro_LTU.csv") 
ccz_ltu <- ccz_ltu %>% mutate(
                  depth_range_m = case_when(Net.. == 1 ~ "1000-1500",
                                            Net.. == 2 ~ "700-1000",
                                            Net.. == 3 ~ "450-700",
                                            Net.. == 4 ~ "70-450",
                                            Net.. == 5 ~ "0-70")) %>%
  filter(!Net..%in% c(0, "4plus5"))

ccz_ltu$depth_range_m <- factor(ccz_ltu$depth_range_m, levels = c("0-70", "70-450", "450-700", "700-1000", "1000-1500"))

chord_ccz <- filter(ccz_ltu, Phylum.broader.classification == "Chordata") ### filtering only chordara

filtered_ccz <- filter(chord_ccz, LTU %in% c("Diaphus pacificus", "Diogenichthys laternatus", "Lampanyctus parvicauda", "Scopeloberyx malayanus", "Scopelogadus bispinosus", "Argyropelecus lychnus", "Bathylagoides nigrigenys", "Vinciguerria lucetia", "Idiacanthus antrostomus"))

ggplot(data = filtered_ccz, 
       mapping = aes(x = log(n), 
                     y = fct_rev(depth_range_m),
                     fill = LTU)) +
  geom_violin(alpha = 0.7,
              show.legend = FALSE) +
  facet_wrap(~LTU, ncol = 4) +
  labs(y = "Depth Range (m)",
       x = "Log Abundance") +
  theme_bw() +
  theme(strip.text = element_text(face = "italic"))

  

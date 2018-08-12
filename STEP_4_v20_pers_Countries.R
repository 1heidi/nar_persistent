## STEP 4: Country-level metrics
##Purpose: Reshape and calculate host(operator) country-level metrics
##Package(s): tidyverse, moments
##Input file(s): nar_v20_pers_2.csv
##Output file(s): nar_v20_pers_4_plot.csv, Figure_2A_Countries.TIFF

library(tidyverse)

pers_2 <- read.csv("nar_v20_pers_2.csv") ## see notes on origin of this file in the script for STEP 2 and the Readme file for this dataset

## Country/Operation Organizations
pers_2_country <- pers_2  %>%
    mutate(host = trimws(pers_2$host)) %>%
      mutate(art_years_aft_debut = article_year - debut_yr) 

pers_2_country_filt <- droplevels(filter(pers_2_country, access_confirmed == "yes" & art_years_aft_debut >4)) ## remove databases no longer available as well as any with a debut article only and any with less than 5 years between debut and update articles (the latter could have been done earlier in the process during STEP 1, but all long-lived databases were retained in case the time frame (e.g. maybe 3 yrs instead) was suggested by a reviewer))

country_count <- as.data.frame(table(pers_2_country_filt$primary_country)) ## to calculate frequency per country

write.csv(country_count, "nar_v20_pers_4_plot.csv", row.names = FALSE)

ggplot() + 
  geom_bar(data = country_count, aes(x = Var1, y = Freq), stat = "identity") +
  ggtitle("Current Database Operations by Country") +
  xlab("Country Codes") +
  ylab("Database Count") +
  ##facet_grid(~ panel, scales = "free_x") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10), limits = c(0,30), expand = c(0, 0)) +
  theme(plot.title = element_text(face='bold',size=11,hjust=0.5),
        axis.title.x = element_text(face='bold',size=11,hjust=0.5, vjust = 0),
        axis.text.x = element_text(face='bold',size=9,color='black',angle = 90),
        ##axis.ticks.x = element_text(face='bold',size=12,color='black'),
        axis.title.y = element_text(face='bold',size=11,vjust=1),
        axis.text.y = element_text(face='bold',size=9,color='black'))

library(moments)
hist(country_count$Freq)
mean(country_count$Freq) ## -> 4.785714
sd(country_count$Freq) ## -> 6.874463
skewness(country_count$Freq) ## -> 2.360855
kurtosis(country_count$Freq) ## -> 7.662764

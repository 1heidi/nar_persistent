## STEP 3: Host-level metrics
##Purpose: Reshape and calculate host(operator)-level metrics
##Package(s): tidyverse, moments
##Input file(s): nar_v20_pers_2.csv
##Output file(s): nar_v20_pers_3_plot.csv, nar_v20_pers_2_supp_tab3.csv, Figure_2B_Hosts.TIFF

library(tidyverse)
library(moments)

pers_2 <- read.csv("nar_v20_pers_2.csv") ## see notes on origin of this file in the script for STEP 2 and the Readme file for this dataset

pers_2_host <- pers_2  %>%
  mutate(host = trimws(pers_2$host)) %>%
    mutate(art_years_aft_debut = article_year - debut_yr) 

pers_2_host_filt <- droplevels(filter(pers_2_host, access_confirmed == "yes" & art_years_aft_debut >4)) ## remove databases no longer available as well as any with a debut article only and any with less than 5 years between debut and update articles (the latter could have been done earlier in the process during STEP 1, but all long-lived databases were retained in case the time frame (e.g. maybe 3 yrs instead) was suggested by a reviewer))

## Plot Current Database Operations by Organization Type

## counts of each host code
host_count <- as.data.frame(table(pers_2_host_filt$host_code)) 
write.csv(host_count, "nar_v20_pers_3_plot.csv", row.names = FALSE)

ggplot() + 
  geom_bar(data = host_count, aes(x = Var1, y = Freq), stat = "identity") +
  ggtitle("Current Database Operations by Organization Type") +
  xlab("Organizational Codes") +
  ylab("Database Count") +
  ##facet_grid(~ panel, scales = "free_x") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10), limits = c(0,30), expand = c(0, 0)) +
  theme(plot.title = element_text(face='bold',size=11,hjust=0.5),
        axis.title.x = element_text(face='bold',size=11,hjust=0.5, vjust = 0),
        axis.text.x = element_text(face='bold',size=9,color='black'),
        ##axis.ticks.x = element_text(face='bold',size=12,color='black'),
        axis.title.y = element_text(face='bold',size=11,vjust=1),
        axis.text.y = element_text(face='bold',size=9,color='black'),
        strip.background = element_blank(),
        strip.text = element_text(face='bold',size=11,color='black'),
        panel.spacing = unit(1, "lines"))

## stats for databases per host (table 2 and supplemental table 3)

pers_2_host_filt2 <- separate_rows(pers_2_host_filt, host, sep = ";")
pers_2_host_filt2 <- mutate(pers_2_host_filt2, host = trimws(pers_2_host_filt2$host))

unique_hosts <- pers_2_host_filt2  %>%
  group_by(host) %>%
      mutate(db_per_host = sum(length(db_id)))

unique_hosts <- distinct(select(unique_hosts, host, host_code, db_per_host))

write.csv(unique_hosts, "nar_v20_pers_2_supp_tab3.csv", row.names = FALSE)

unique_hosts <- unique_hosts  %>%
  group_by(host_code) %>%
    mutate(count_hosts_by_code = sum(length(host_code)))

library(moments)
hist(unique_hosts$db_per_host)
mean(unique_hosts$db_per_host) ## -> 1.4
sd(unique_hosts$db_per_host) ## -> 1.195229
skewness(unique_hosts$db_per_host) ## -> 3.96981
kurtosis(unique_hosts$db_per_host) ## -> 20.44327


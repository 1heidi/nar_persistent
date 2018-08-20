## STEP 2: Funder-level metrics
##Purpose: Reshape and calculate funder-level metrics for both individual organizations and organizational types
##Package(s): tidyverse, moments
##Input file(s): nar_v20_pers_2.csv, nar_pers_funder_codes.csv
##Output file(s): nar_v20_pers_2_supp_tab1.csv (for table 1 and supp table 1), nar_v20_pers_2_supp_tab2.csv, nar_v20_pers_2_plot.csv, Figure_1_Funders.TIFF

# library(tidyverse)
# library(moments)

pers_2 <- read.csv("nar_v20_pers_2.csv") ## started with nar_v20_pers_1 and reviewed URLs and NAR articles manually to add names of funding and hosting organizations. Org codes for hosts are included in nar_v20_pers_2.csv. Databases reported multiple funders (89 unique) and org codes had be assigned to these funders separately in nar_pers_funder_codes.csv. Funder codes are then mapped to nar_v20_pers_2.csv in the script below.

## separate out funders per article into distinct rows 
pers_2_funder <- separate_rows(pers_2, funder, sep = ";")

pers_2_funder <- pers_2_funder  %>%
  mutate(funder = trimws(pers_2_funder$funder)) %>%
    mutate(art_years_aft_debut = article_year - debut_yr) 

pers_2_funder <- filter(pers_2_funder, access_confirmed == "yes" & art_years_aft_debut >4) ## remove databases no longer available as well as any with a debut article only and any with less than 5 years between debut and update articles (the latter could have been done earlier in the process during STEP 1, but all long-lived databases were retained in case the time frame (e.g. maybe 3 yrs instead) was suggested by a reviewer))

distinct(select(pers_2_funder, db_id)) # count of databases in final sample set -> 67

## map org codes to funders
fund_codes <- read.csv("nar_pers_funder_codes.csv") 
pers_2_coded <- left_join(pers_2_funder, fund_codes, by = "funder") 

## count databases per funder
pers_2_coded <- pers_2_coded  %>% 
  group_by(funder) %>%
    mutate(count_dbs_per_funder = length(db_id))

## created 4 additional columns: for each database to 1) aggregate all funder org codes, 2) deduplicate to condense aggregated funder org codes, 3) count individual funding orgs (all distinct orgs!), and 4) count funding org codes (condensed org types!)
pers_2_coded <- pers_2_coded %>% 
  group_by(db_id) %>%
    mutate(funder_code = ordered(funder_code)) %>%
       mutate(all_funder_codes = paste(sort(funder_code), collapse="")) %>%
          mutate(cond_funder_codes = paste(sort(unique(funder_code)), collapse="")) %>%
              mutate(count_all_funders_per_db = nchar(all_funder_codes)) %>%
                  mutate(count_funder_types_per_db = nchar(cond_funder_codes))

#### resulting pers_2_coded is the main dataframe used from here on

## create table for all funders reported (table 1 and supplemental table 1)
pers_2_coded_filt <- ungroup(pers_2_coded)
pers_2_coded_filt <- filter(pers_2_coded_filt, funder!= "not_reported")
pers_2_coded_filt <- select(pers_2_coded_filt, funder, funder_code, count_dbs_per_funder)
pers_2_coded_filt <- distinct(pers_2_coded_filt)

write.csv(pers_2_coded_filt, "nar_v20_pers_2_supp_tab1.csv", row.names = FALSE)

## "number of databases supported by each unique funding organization" 
hist(pers_2_coded_filt$count_dbs_per_funder) 
mean(pers_2_coded_filt$count_dbs_per_funder) ## -> 1.977528
sd(pers_2_coded_filt$count_dbs_per_funder) ## -> 3.431066
skewness(pers_2_coded_filt$count_dbs_per_funder) ## -> 6.077922
kurtosis(pers_2_coded_filt$count_dbs_per_funder) ## -> 45.61974

## "89 individual funding organizations were mapped to categories"
funding_orgs_mapped <- as.data.frame(table(pers_2_coded_filt$funder_code))

## Results
# A -> 13
# C -> 7
# G -> 29
# I -> 19
# P -> 12
# S -> 9

## "number of unique funding organizations attributed within each database article" (also supplemental tab 2)
funders_per_db <- filter(pers_2_coded, funder!= "not_reported")
funders_per_db <- distinct(select(funders_per_db, db_id, resource_name, debut_yr, all_funder_codes, cond_funder_codes, count_all_funders_per_db, count_funder_types_per_db))
hist(funders_per_db$count_all_funders_per_db)
mean(funders_per_db$count_all_funders_per_db) ## -> 2.793651
sd(funders_per_db$count_all_funders_per_db) ## -> 2.840711
skewness(funders_per_db$count_all_funders_per_db) ## -> 3.870593
kurtosis(funders_per_db$count_all_funders_per_db) ## -> 22.7558

write.csv(funders_per_db, "nar_v20_pers_2_supp_tab2.csv", row.names = FALSE)

## Figure 1 - Combinations of Funding Organization Types for Long-Lived Databases

plot <- ungroup(funders_per_db)
plot <-plot %>%
  group_by(cond_funder_codes) %>%
      mutate(count = length(cond_funder_codes))
plot <- distinct((select(plot, cond_funder_codes, count, count_funder_types_per_db)))

x1 <- data.frame(filter(plot, count_funder_types_per_db == 1))
x2 <- data.frame(filter(plot, count_funder_types_per_db == 2))
x3 <- data.frame(filter(plot, count_funder_types_per_db == 3))
x4 <- data.frame(filter(plot, count_funder_types_per_db == 4))

x1 <- select(x1, -count_funder_types_per_db)
x2 <- select(x2, -count_funder_types_per_db)
x3 <- select(x3, -count_funder_types_per_db)
x4 <- select(x4, -count_funder_types_per_db)

x1$panel <- "1 Funder Type (n = 38)"
x2$panel <- "2 Funder Types (n = 14)"
x3$panel <- "3 Funder Types (n = 7)"
x4$panel <- "4 Funder Types (n = 4)" 

panel <- rbind(x1, x2, x3, x4)
plot <- right_join(plot, panel, by = "cond_funder_codes")
plot <- select(plot, -count.x)
names(plot)[names(plot) == 'count.y'] <- 'count'

write.csv(plot, "nar_v20_pers_2_plot.csv", row.names = FALSE)

ggplot() + 
  geom_bar(data = plot, aes(x = cond_funder_codes, y = count), stat = "identity") +
  ggtitle("Combinations of Funding Organization Types for Long-Lived Databases\n") +
  xlab("\nOrganizational Codes") +
  ylab("Database Count\n") +
  facet_grid(~ panel, scales = "free_x") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10), limits = c(0,35), expand = c(0, 0)) +
  theme(plot.title = element_text(face='bold',size=16,hjust=0.5),
        axis.title.x = element_text(face='bold',size=16,hjust=0.5, vjust = 0),
        axis.text.x = element_text(face='bold',size=12,color='black'),
        ##axis.ticks.x = element_text(face='bold',size=12,color='black'),
        axis.title.y = element_text(face='bold',size=16,vjust=1),
        axis.text.y = element_text(face='bold',size=12,color='black'),
        strip.background = element_blank(),
        strip.text = element_text(face='bold',size=12,color='black'),
        panel.spacing = unit(1, "lines"))

## count databases that "reported a single distinct organization" as a funder
pers_2_coded_singles <- filter(pers_2_coded, count_all_funders_per_db == 1)
pers_2_coded_singles_counts <- as.data.frame(table(pers_2_coded_singles $funder_code)) 

## Results
# A -> 1
# G -> 20
# I -> 1
# P -> 2
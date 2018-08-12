## STEP 1: Descriptive stats for databases the 105 databases >15 years old as found in original nar study
##Package(s): tidyverse
##Input file(s): nar_v20_7.csv, nar_v20.csv, nar_id_mapping.csv
##Output file(s): nar_v20_pers_1.csv

library(tidyverse)

## First get a list of the databases >15 years old from nar_v20_7 since those have citation quartiles and maintenance updates (may want to evaluate based on these variables). This file does not include the article DOI though, so will then need the original nar_v20.csv and nar_id_mapping.csv files from Imker 2018 (see readme).

nar_v20_7 <- read.csv("nar_v20_7.csv")
nar_v20_7_oldest <- filter(nar_v20_7, debut_yr < 2002)
nar_v20_7_oldest <- select(nar_v20_7_oldest, -maintdiff, -maint_aft_debut)

## Find the most recent article for each databases to get the most recent URL and DOI (will end up being for all databases since using original nar_v20 file).

nar_v20 <- read.csv("nar_v20.csv")
nar_map <- read.csv("nar_id_mapping.csv") ## to get DOIs
nar_map <- select(nar_map, -db_id)

nar_v20_doi <- left_join(nar_v20, nar_map, by = "article_id")

nar_v20_doi_latest <- nar_v20_doi %>%
  group_by(db_id) %>%
      filter(article_year == max(article_year))

## merge the oldest database (nar_v20_7_oldest) with their newest articles (nar_v20_doi_latest)

nar_v20_pers <- left_join(nar_v20_7_oldest, nar_v20_doi_latest, by = "db_id")
nar_v20_pers <- distinct(nar_v20_pers) ##returns 105

nar_v20_pers <- select(nar_v20_pers, article_id, article_year, article_global_id, db_id, resource_name.x, status, debut_yr, total_articles, total_citations, db_last_update, quartile, notes)

write.csv(nar_v20_pers, "nar_v20_pers_1.csv", row.names = FALSE )

## using nar_v20_pers_1.csv, manually review NAR papers via DOI and add data for the host and funding organizations AND use the URL to check if each database is still available. The resulting csv from that manual process will be called nar_v20_pers_2.csv.

# TABLE OF CONTENTS
### TABLE OF CONTENTS
---------------------

* DATASET TITLE
* AUTHORS AND AFFILIATIONS
* LANGUAGE
* SUMMARY/ABSTRACT
* KEYWORDS
* FILE ORGANIZATION
* DATASET DESCRIPTION 
* DATA DICTIONARY
* DATA ANALYSIS
* SHARING & ACCESSING INFORMATION
* ADDITIONAL NOTES/COMMENTS

### DATASET TITLE

Funding and Operating Organizations for Long-Lived Molecular Biology Databases

### AUTHORS AND AFFILIATIONS

* Name: Heidi Imker
* Organization/institution: University of Illinois at Urbana-Champaign
* ORCID: 0000-0003-4748-7453
* Email: imker@illinois.edu

### LANGUAGE

* English

### SUMMARY/ABSTRACT

The organizations that contribute to the longevity of 67 long-lived molecular biology databases published in Nucleic Acids Research (NAR) between 1991-2016 were identified to address two research questions 1) which organizations fund these databases? and 2) which organizations maintain these databases? Funders were determined by examining funding acknowledgements in each database's most recent NAR Database Issue update article published (prior to 2017) and organizations operating the databases were determine through review of database websites.

* Please read the associated openly available research article for context, additional details, and results: 

  * Imker, Heidi (2018): Who Bears the Burden of Long-Lived Molecular Biology Databases? bioRxiv, TBD

* The archived dataset that accompanies the preprint is also available at:

  * Imker, Heidi (2018): Funders and Operators of Long-Lived Molecular Biology Databases. University of Illinois at Urbana-Champaign. TBD
  
### KEYWORDS

online databases; research infrastructure; sustainability; data sharing, molecular biology; bioinformatics

### FILE ORGANIZATION

* This dataset consists of 22 files:
  * 1 Readme file (MD)
  * 1 Readme file for dataset archived in the Illinios Data Bank (TXT)
  * 3 image files of figures (TIFF)
  * 1 R project file (RPROJ)
  * 9 new data files (CSV) 
  * 4 R script files (R)
  * Additionaly, three data files are used from https://doi.org/10.13012/B2IDB-4311325_V1:
    * nar_id_mapping.csv
    * nar_v20.csv
    * nar_v20_7.csv
  
* The initial input data files are nar_v20_7.csv, nar_v20.csv, and nar_id_mapping.csv.

* Each script is named for its step in the analysis process, with an additional short descriptor (see also “DATA ANALYSIS” section below). As data was reshaped and analyzed, scripts created subsequent CSV files which are named accordingly, e.g., STEP_1_v20_pers_Sample.R created nar_v20_pers_1.csv from the initial input files.

* In file names, "pers" stands for "persistent" to distinguish this sub-project from the first NAR census study already reported.

* CSV files appended with “plot” are the exact data used for plots in article figures. 

* CSV files appended with “supp_tab” are the exact data used for article tables and supplemental tables.

* Files necessary to create Figures
  * Figure 1 STEP_2_v20_pers_Funders.R & nar_v20_pers_2_plot.csv
  * Figure 2 
    * Panel A: STEP_2_v20_pers_Countries.R & nar_v20_pers_4_plot.csv
    * Panel B: STEP_2_v20_pers_Hosts.R & nar_v20_pers_3_plot.csv

* Files necessary to create Tables
  * Table 1 and Supplemental Table 1: STEP_2_v20_pers_Funders.R & nar_v20_pers_2_supp_tab1.csv
  * Table 2 and Supplemental Table 3: STEP_2_v20_pers_Hosts.R & nar_v20_pers_2_supp_tab3.csv
  * Supplemental Table 2: STEP_2_v20_pers_Funders.R & nar_v20_pers_2_supp_tab2.csv

### DATASET DESCRIPTION 

#### Data sources: 

* Imker, Heidi (2018): Molecular Biology Databases Published in Nucleic Acids Research between 1991-2016. University of Illinois at Urbana-Champaign. https://doi.org/10.13012/B2IDB-4311325_V1

* Funding statements were obtained from reading the associated articles on the Nucleic Acids Research (NAR) website at https://academic.oup.com/nar.

* Database websites were used to evaluate operating organization and country.

#### Data collection dates:

* Current availability for databases was reconfirmed in March 2018 and the date of database last update was also updated (if found).

### DATA DICTIONARY

* Variables for nar_v20_pers_1.csv, as described at above referenced for source data.
* New variables for nar_v20_pers_2.csv:
  * **access_confirmed** = 1) "yes"" if URL resolves and database available, 2) "no" if URL does not resolve, and 3) "false_positive" if URL resolves but databases not available or use not recommended per notification on database website
  * **update_2018** = year last updated, if available; otherwise 1) "unknown" if no date found or 2) "not_applicable" if access was not confirmed
  * **host** = name of organization(s) operating the database, highest level of the organization reported only
  * **host_code** = "A" for academic, "C" for consortium/collective, "G" forgovernment), "I" for industry, "P" for philanthropic, and "S" for society/association
  * **funder** = name of organization(s) funding the database, highest level of the organization reported only
  * **primary_country** = country in which the database appears to be operated out of, reported in ISO 3166-1 alpha-3
  * **multi_sign** = 1) "single" if only one funder was reported, 2) "mult" if multiple funders reported, and 3) "not reported" if no acknowledgement of funding  was found
* New variables for nar_pers_funder_codes.csv:
  * **funder_code** = "A" for academic, "C" for consortium/collective, "G" forgovernment), "I" for industry, "P" for philanthropic, and "S" for society/association
* New variables for nar_v20_pers_2_supp_tab1.csv
  * **count_dbs_per_funder** = total count of databases per unique funder
* New variables for nar_v20_pers_2_supp_tab2.csv
  * **all_funder_codes** = codes for each unique funder reported in the article
  * **cond_funder_codes** = codes condensed by funder type (e.g. GGAA = GA)
  * **count_all_funders_per_db** = total number of all unique funders reported (e.g. GGAA = 4)
  * **count_funder_types_per_db** = number of unique funder types for (e.g. GA = 2)
* New variables for nar_v20_pers_2_supp_tab3.csv
  * **dbs_per_host** = number of databases operated by each unique host
  * **count_hosts_per_code** = count of the number of hosts per code (e.g. total number of hosts classified as A (academic), etc.)

### DATA ANALYSIS

* The initial input data files nar_v20_7.csv, nar_v20.csv, and nar_id_mapping.csv were used to 1) identify databases that have remained available >15 yrs since debuting in NAR and 2) retrieve the global article identifers (usually DOI) for those databases' most recent NAR article.

* Note nar_v20_pers_2.csv was created by manual addition of funding and hosting(operating) organizations as well as countries to nar_v20_pers_1.csv as each article and database was reviewed.

* Note nar_pers_funder_codes.csv was also created by a manual process that classified each of the 89 funders found in nar_v20_pers_2.csv.

#### Program used:

* R version 3.3.3 (2017-03-06)
* RStudio 1.0.136
* Platform: x86_64-apple-darwin13.4.0 (64-bit)
* Running under: OS X El Capitan 10.11.6
* Attached base packages:
  * stats     
  * graphics  
  * grDevices 
  * utils    
  * datasets  
  * methods   
  * base     
* Other attached packages:
  * moments_0.14    
  * bindrcpp_0.2.2 
  * dplyr_0.7.6     
  * purrr_0.2.2.2  
  * readr_1.1.1     
  * tidyr_0.8.1    
  * tibble_1.4.2    
  * ggplot2_2.2.1  
  * tidyverse_1.1.1

#### There are 4 scripts that work sequentially:

**STEP 1** SAMPLE Purpose: Descriptive stats for databases >15 years old as found in original NAR study
   * Package(s): tidyverse
   * Input file(s):  nar_v20_7.csv, nar_v20.csv, nar_id_mapping.csv
   * Output file(s): nar_v20_pers_1.csv
   
**STEP 2** FUNDERS Purpose: Reshape and calculate funder-level metrics for both individual organizations and organizational types
   * Package(s): tidyverse, moments
   * Input file(s): nar_v20_pers_2.csv, nar_pers_funder_codes.csv
   * Output file(s): nar_v20_pers_2_supp_tab1.csv (for table 1 and supp table 1), nar_v20_pers_2_supp_tab2.csv, nar_v20_pers_2_plot.csv, Figure_1_Funders.TIFF

**STEP 3** HOSTS Purpose: Reshape and calculate host(operator)-level metrics
   * Package(s): tidyverse, moments 
   * Input file(s): nar_v20_pers_2.csv
   * Output file(s): nar_v20_pers_3_plot.csv, nar_v20_pers_2_supp_tab3.csv, Figure_2B_Hosts.TIFF

**STEP 4** COUNTRIES Purpose: Reshape and calculate host (operator) country-level metrics
   * Package(s): tidyverse, moments
   * Input file(s): nar_v20_pers_2.csv
   * Output file(s): nar_v20_pers_4_plot.csv, Figure_2A_Countries.TIFF

### SHARING & ACCESSING INFORMATION

* **Formally:** CC0 to facilitate ease-of-use
* **Informally:** Please cite this dataset regardless. It matters to me, and provenance is important. The citation is:

   * Imker, Heidi (2018): Funders and Operators of Long-Lived Molecular Biology Databases. University of Illinois at Urbana-Champaign. TBD

### ADDITIONAL NOTES/COMMENTS

There are bound to errors in this dataset. Please let me know if any are found. 






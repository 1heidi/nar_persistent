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
  * 9 data files (CSV) 
  * 4 R script files (R)
  * Additionaly, three data files are used from https://doi.org/10.13012/B2IDB-4311325_V1:
    * nar_id_mapping.csv
    * nar_v20.csv
    * nar_v20_7.csv
  
* The initial input data files are nar_v20_7.csv, nar_v20.csv, and nar_id_mapping.csv, which are used to 1) identify databases that have remained available >15 since having a debut article published in NAR and 2) retrieve the global article identifers (usually DOI) those database's most recent NAR article.

* Each script is named for its step in the analysis process, with an additional short descriptor (see also “DATA ANALYSIS” section below). As data was reshaped and analyzed, scripts created subsequent CSV files which are named accordingly, e.g., STEP_1_v20_pers_Sample.R created nar_v20_pers_1.csv. 

* CSV files appended with “plot” are the exact data used for plots in article figures. 

* CSV files appended with “supp_tab” are the exact data used for article tables and supplemental tables.

* Files necessary to create Figures
  * Figure 1 
  * Figure 2 

* Files necessary to create Tables
  * Table 1: 
  * Table 2:
  * Supplemental Table 1:
  * Supplemental Table 2:
  * Supplemental Table 3:

### DATASET DESCRIPTION 

#### Data sources: 

* Imker, Heidi (2018): Molecular Biology Databases Published in Nucleic Acids Research between 1991-2016. University of Illinois at Urbana-Champaign. https://doi.org/10.13012/B2IDB-4311325_V1

* Funding statements were obtained from reading the associated articles on the Nucleic Acids Research (NAR) website at https://academic.oup.com/nar)

#### Data collection dates:

* Current availability for databases was reconfirmed in March 2018 and database websites were also evaluated at that time to determine operating organization

### DATA DICTIONARY

* Variables for nar_v20_pers_1.csv, as described for Imker 2018.
* New variables for nar_v20_pers_2.csv:
  * **access_confirmed** = 
  * **update_2018** =
  * **host** =
  * **host_code** =
  * **funder** =
  * **primary_country** =
  * **multi_sign** = 1) "single" if only one funder was reported, 2) "mult" if multiple funders reported, and 3) "not reported" if no acknowledgement of funding  was found
* New variables for nar_pers_funder_codes.csv:
 * **funder_code** =

### DATA ANALYSIS

* Note nar_v20_pers_2.csv was created by manual addition of organization and countired to nar_v20_pers_1.csv as each article was reviewed.

* Note nar_pers_funder_codes.csv was also created by a manual process that classified each of the funders found in nar_v20_pers_2.csv.

#### Program used:

#### There are 4 scripts that work sequentially:

**STEP 1** Purpose: Descriptive stats for databases the 105 databases >15 years old as found in original nar study
   * Package(s): tidyverse
   * Input file(s):  nar_v20_7.csv, nar_v20.csv, nar_id_mapping.csv
   * Output file(s): nar_v20_pers_1.csv
   
**STEP 2** Purpose: 
   * Package(s): tidyverse,
   * Input file(s): 
   * Output file(s): 

**STEP 3** Purpose: 
   * Package(s): tidyverse, 
   * Input file(s): 
   * Output file(s): 

**STEP 4** Purpose:
   * Package(s): tidyverse, 
   * Input file(s): 
   * Output file(s): 

### SHARING & ACCESSING INFORMATION

* **Formally:** CC0 to facilitate ease-of-use
* **Informally:** Please cite this dataset regardless. It matters to me, and provenance is important. The citation is:

   * Imker, Heidi (2018): Funders and Operators of Long-Lived Molecular Biology Databases. University of Illinois at Urbana-Champaign. TBD

### ADDITIONAL NOTES/COMMENTS

There are bound to errors in this dataset. Please let me know if any are found. 






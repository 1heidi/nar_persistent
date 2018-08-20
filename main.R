###################
## Automate package install and load

is_installed <- function(package_name) is.element(package_name, installed.packages()[,1])

# If a package is not installed, install it. Then load the package.
install_and_load <- function(package_name) {
  if(!is_installed(package_name)) {
    install.packages(package_name)
  }
  library(package_name, character.only = TRUE)
}

install_packages <- function(packages) {
  for(package in packages) {
    install_and_load(package)
  }
}

install_packages(c("tidyverse", "moments", "RCurl"))

source("STEP_1_v20_pers_Sample.R")
source("STEP_2_v20_pers_Funders.R")
source("STEP_3_V20_pers_Hosts.R")
source("STEP_4_v20_pers_Countries.R")

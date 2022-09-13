# ugh

# list of required packages
list.of.packages <- c(
  'data.table',
  'tidyverse',
  'jsonlite',
  'jpeg',
  'png',
  'raster',
  'rgdal',
  'rmarkdown', 
  'knitr'
)

# identify new (not installed) packages
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# install new (not installed) packages
if(length(new.packages)) 
  install.packages(new.packages, 
                   repos='http://cran.rstudio.com/')

# load all of the required libraries
sapply(list.of.packages, library, character.only = T)

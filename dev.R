# 
# Author: Daniel
###############################################################################


Sys.setenv('COSM_API_KEY' = '...') # automatically (run configuration)

###############################################################################
#library("roxygen2")
library("roxygen")
#roxygenize(package.dir="C:/Users/Daniel/git/nuest-cosm")

options(digits.secs = 3)
setwd("C:/Users/Daniel/git/")
roxygenize("nuest-cosm")


##############################################################################

rfiles <- list.files("C:/Users/Daniel/git/nuest-cosm/R/", full.names = TRUE)
lapply(rfiles, source)
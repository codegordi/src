######################################
#
# startup.R
#
# cgutierrez - my startup sourcer
#
#####################################

library(ggplot2)
library(plyr)
library(dplyr)
library(reshape2)
#library(rjson)
library(lubridate)
#library(RColorBrewer)
library(assertthat)
library(stringr)
library(scales)
library(psych)
library(SDMTools)
library(matrixStats)

#home.dir = "/home/cgutierrez/"  # Linux
home.dir = "/Users/cgutierrez"  # Mac OS
#src.dir = "/home/cgutierrez/src/R/"  # Linux
src.dir = "/Users/cgutierrez/src/R"  # Mac OS

source(paste0(src.dir, "/tic_toc.R"))  # load poor-wo/man's benchmarking functions

library(readr)
library(ggplot2)
library(ggthemes)
library(cowplot)
library(dplyr)
library(parallel)
library(devtools)
unloadNamespace('rmarkdown')
library(vars)
library(frequencyConnectedness)
library(BigVAR)
library(lubridate)
library(psych)
library(tseries)
library(rtadfr)
library(Hmisc)
library(igraph)
library(influenceR)
library(svglite)


time_stamp <- seq(as.Date("2015-09-01"), as.Date("2022-06-01"), by="day")

time_range <- c(2410:4748)

time_length <- c(1: (length(time_stamp)-99))



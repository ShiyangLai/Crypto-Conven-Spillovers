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

focals <- c("USDBTC", "USDDOGE", "USDLTC", "USDXRP",   # four cryptocurrency
            "USDEUR", "USDJPY", "USDGBP", "USDAUD", "USDCAD",
            "USDCHF", "USDCNY", "USDSEK", "USDNZD")   # nine conventional currency

conven <- c(5: 13)

crypto <- c(1: 4)

time_stamp <- seq(as.Date("2014-01-01"), as.Date("2022-01-01"), by="day")

time_range <- c(1826:4748)

time_length <- c(1:2824)

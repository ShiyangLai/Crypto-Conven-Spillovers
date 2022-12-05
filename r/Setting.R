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
library(crypto2)
library(quantmod)
library(extRemes)

coin_list_2015 <- crypto_list(only_active=TRUE) %>%
                dplyr::filter(first_historical_data<="2015-08-31",
                last_historical_data>="2022-06-16")

coins_2015 <- crypto_history(coin_list = coin_list_2015, start_date = "20150831",
                             end_date="20220616", interval="daily")

write.csv(coins_2015, '../Data/coins_2015_2022.csv')

time_length <- c(1: (length(time_stamp)-99))

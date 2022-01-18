# read the original exchange rate data set
library(readr)
conven_data <- read_csv("Exp Data/v2/conv_exchange.csv", col_types = cols(Date = col_date(format = "%Y-%m-%d")))
crypto_data <- read_csv("Exp Data/v2/crypto_exchange.csv", col_types = cols(Date = col_date(format = "%Y-%m-%d")))

# visualize
library(ggplot2)
library(ggthemes)
library(cowplot)
library(dplyr)
a1 <-  ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDBTC)) +
    ylab('BTC') + xlab('Year')
a2 <-  ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDLINK)) +
  ylab('LINK') + xlab('Year')
a3 <-  ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDLTC)) +
  ylab('LTC') + xlab('Year')
a4 <-  ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDETH)) +
  ylab('ETH') + xlab('Year')
a5 <-  ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDXRP)) +
  ylab('XRP') + xlab('Year')
a6 <-  ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDBNB)) +
  ylab('BNB') + xlab('Year')
plot_grid(a1, a2, a3, a4, a5, a6, ncol = 3, nrow = 2)

# read the original exchange rate data set
library(readr)
conven_data <- read_csv("Exp Data/v2/conv_exchange.csv", col_types = cols(Date = col_date(format = "%Y-%m-%d")))
crypto_data <- read_csv("Exp Data/v2/crypto_exchange.csv", col_types = cols(Date = col_date(format = "%Y-%m-%d")))

# visualize cryptocurrency
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
a7 <- ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDDOGE)) +
  ylab('DOGE') + xlab('Year')
a8 <- ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDBUSD)) +
  ylab('BUSD') + xlab('Year')
a9 <- ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDADA)) +
  ylab('ADA') + xlab('Year')
a10 <- ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDUSDT)) +
  ylab('USDT') + xlab('Year')
a11 <- ggplot() + geom_line(aes(x=crypto_data$Date, y=1/crypto_data$USDBCH)) +
  ylab('BCH') + xlab('Year')
plot_grid(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10,
          ncol = 2, nrow = 5)

# visualize conventional currency
a1 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDEUR)) +
  ylab('EUR') + xlab('Year')
a2 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDPKR)) +
  ylab('PKR') + xlab('Year')
a3 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDNOK)) +
  ylab('NOK') + xlab('Year')
a4 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDKRW)) +
  ylab('KRW') + xlab('Year')
a5 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDHUF)) +
  ylab('HUF') + xlab('Year')
a6 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDCHF)) +
  ylab('CHF') + xlab('Year')
a7 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDBRL)) +
  ylab('BRL') + xlab('Year')
a8 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDHKD)) +
  ylab('HKD') + xlab('Year')
a9 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDRUB)) +
  ylab('RUB') + xlab('Year')
a10 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDJPY)) +
  ylab('JPY') + xlab('Year')
plot_grid(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10,
          ncol = 2, nrow = 5)




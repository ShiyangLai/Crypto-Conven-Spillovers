# read the original exchange rate data set
conven_data <- read_csv("Exp Data/v2/conv_exchange.csv", col_types = cols(Date = col_date(format = "%Y-%m-%d")))
crypto_data <- read_csv("Exp Data/v2/crypto_exchange.csv", col_types = cols(Date = col_date(format = "%Y-%m-%d")))

# visualize cryptocurrency
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
a1 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDAUD)) +
  ylab('AUD') + xlab('Year')
a2 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDBRL)) +
  ylab('BRL') + xlab('Year')
a3 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDCAD)) +
  ylab('CAD') + xlab('Year')
a4 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDCLP)) +
  ylab('CLP') + xlab('Year')
a5 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDCZK)) +
  ylab('CZK') + xlab('Year')
a6 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDCNY)) +
  ylab('CNY') + xlab('Year')
a7 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDDKK)) +
  ylab('DKK') + xlab('Year')
a8 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDEUR)) +
  ylab('EUR') + xlab('Year')
a9 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDHKD)) +
  ylab('HKD') + xlab('Year')
a10 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDINR)) +
  ylab('INR') + xlab('Year')
a11 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDHUF)) +
  ylab('HUF') + xlab('Year')
a12 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDILS)) +
  ylab('ILS') + xlab('Year')
a13 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDJPY)) +
  ylab('JPY') + xlab('Year')
a14 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDMXN)) +
  ylab('MXN') + xlab('Year')
a15 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDNOK)) +
  ylab('NOK') + xlab('Year')
a16 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDNZD)) +
  ylab('NZD') + xlab('Year')
a17 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDPKR)) +
  ylab('PKR') + xlab('Year')
a18 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDPLN)) +
  ylab('PLN') + xlab('Year')
a19 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDRUB)) +
  ylab('RUB') + xlab('Year')
a20 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDSGD)) +
  ylab('SGD') + xlab('Year')
a21 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDZAR)) +
  ylab('ZAR') + xlab('Year')
a22 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDKRW)) +
  ylab('KRW') + xlab('Year')
a23 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDGBP)) +
  ylab('GBP') + xlab('Year')
a24 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDCHF)) +
  ylab('CHF') + xlab('Year')
a25 <- ggplot() + geom_line(aes(x=conven_data$Date, y=1/conven_data$USDSEK)) +
  ylab('SEK') + xlab('Year')
plot_grid(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10,
          a11, a12, a13, a14, a15, a16, a17, a18, a19, a20,
          a21, a22, a23, a24, a25,
          ncol = 5, nrow = 5)




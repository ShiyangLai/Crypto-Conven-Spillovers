dataframe1 <- matrix(ncol=length(coins), nrow=length(time_length))
dataframe2 <- matrix(ncol=length(coins), nrow=length(time_length))

for (i in c(1: length(coins))) {
  outdegrees <- vector(mode='numeric')
  indegrees <- vector(mode='numeric')
  for (j in time_length) {
    if (coins[i] %in% crypto) {
      outdegrees <- append(outdegrees, sum(as.data.frame(sp$list_of_tables[[j]][[1]][[1]])[conven, coins[i]]))
      indegrees <- append(indegrees, sum(as.data.frame(sp$list_of_tables[[j]][[1]][[1]])[coins[i], conven]))
    } else {
      outdegrees <- append(outdegrees, sum(as.data.frame(sp$list_of_tables[[j]][[1]][[1]])[conven, coins[i]]))
      indegrees <- append(indegrees, sum(as.data.frame(sp$list_of_tables[[j]][[1]][[1]])[coins[i], conven]))
    }
  }
  dataframe1[,i] <- indegrees
  dataframe2[,i] <- outdegrees
}
colnames(dataframe1) <- coins
colnames(dataframe2) <- coins
dataframe1<- as.data.frame(dataframe1)
dataframe2<- as.data.frame(dataframe2)
dataframe1['time_stamp'] <- time_stamp[c(100:length(time_stamp))][time_length]
dataframe2['time_stamp'] <- time_stamp[c(100:length(time_stamp))][time_length]
write.csv(dataframe1, '../Results/Volatility cross-market indegree.csv')
write.csv(dataframe2, '../Results/Volatility cross-market outdegree.csv')

ggplot() +
  geom_line(aes(x=time_stamp[c(100:length(time_stamp))][time_length], y=dataframe$USDBITCNY, color='BITCNY')) +
  geom_line(aes(x=time_stamp[c(100:length(time_stamp))][time_length], y=dataframe$USDBTC, color='BTC')) +
  geom_line(aes(x=time_stamp[c(100:length(time_stamp))][time_length], y=rowMeans(dataframe[,crypto]), color='Crypto->Trad Mean')) +
  # geom_line(aes(x=time_stamp[time_length], y=rowMeans(dataframe[,conven]), color='Trad->Crypto Mean')) +
  geom_line(aes(x=time_stamp[c(100:length(time_stamp))][time_length][time_length], y=dataframe$USDLTC, color='LTC')) +
  # geom_line(aes(x=time_stamp[100:][time_length], y=dataframe$USDXRP, color='XRP')) +
  # geom_line(aes(x=time_stamp[100:][time_length], y=dataframe$USDDOGE, color='DOGE')) +
  # geom_line(aes(x=time_stamp[100:][time_length], y=dataframe$USDETH, color='ETH')) +
  xlab('Time') + ylab('Cross-market Connectedness') +
  theme_bw() +
  scale_color_lancet()

ggplot() +
  geom_line(aes(x=time_stamp[time_length], y=dataframe$USDCNY, color='CNY')) +
  geom_line(aes(x=time_stamp[time_length], y=dataframe$USDGBP, color='GBP')) +
  geom_line(aes(x=time_stamp[time_length], y=dataframe$USDJPY, color='JPY')) +
  geom_line(aes(x=time_stamp[time_length], y=dataframe$USDEUR, color='EUR')) +
  geom_line(aes(x=time_stamp[time_length], y=dataframe$USDAUD, color='AUD')) +
  geom_line(aes(x=time_stamp[time_length], y=dataframe$USDHKD, color='HKD')) +
  xlab('Time') + ylab('Cross-market Connectedness') +
  theme_bw() +
  scale_color_lancet()
  
  

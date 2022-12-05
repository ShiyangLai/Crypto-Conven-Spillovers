preturn_results.table <- data.frame(cryp_trad_s = preturn_connectedness$p_cry_trad_s,
                                    trad_cryp_s = preturn_connectedness$p_trad_cry_s,
                                    cryp_cryp_s = preturn_connectedness$p_cry_cry_s,
                                    trad_trad_s = preturn_connectedness$p_trad_trad_s,
                                    cryp_trad_m = preturn_connectedness$p_cry_trad_m,
                                    trad_cryp_m = preturn_connectedness$p_trad_cry_m,
                                    cryp_cryp_m = preturn_connectedness$p_cry_cry_m,
                                    trad_trad_m = preturn_connectedness$p_trad_trad_m,
                                    cryp_trad_l = preturn_connectedness$p_cry_trad_l,
                                    trad_cryp_l = preturn_connectedness$p_trad_cry_l,
                                    cryp_cryp_l = preturn_connectedness$p_cry_cry_l,
                                    trad_trad_l = preturn_connectedness$p_trad_trad_l)
write.csv(preturn_results.table, file="../Results/preturn_table.csv")

nreturn_results.table <- data.frame(cryp_trad_s = nreturn_connectedness$p_cry_trad_s,
                                    trad_cryp_s = nreturn_connectedness$p_trad_cry_s,
                                    cryp_cryp_s = nreturn_connectedness$p_cry_cry_s,
                                    trad_trad_s = nreturn_connectedness$p_trad_trad_s,
                                    cryp_trad_m = nreturn_connectedness$p_cry_trad_m,
                                    trad_cryp_m = nreturn_connectedness$p_trad_cry_m,
                                    cryp_cryp_m = nreturn_connectedness$p_cry_cry_m,
                                    trad_trad_m = nreturn_connectedness$p_trad_trad_m,
                                    cryp_trad_l = nreturn_connectedness$p_cry_trad_l,
                                    trad_cryp_l = nreturn_connectedness$p_trad_cry_l,
                                    cryp_cryp_l = nreturn_connectedness$p_cry_cry_l,
                                    trad_trad_l = nreturn_connectedness$p_trad_trad_l)
write.csv(nreturn_results.table, file="../Results/nreturn_table.csv")

volatility_results.table <- data.frame(cryp_trad_s = volatility_connectedness$p_cry_trad_s,
                                    trad_cryp_s = volatility_connectedness$p_trad_cry_s,
                                    cryp_cryp_s = volatility_connectedness$p_cry_cry_s,
                                    trad_trad_s = volatility_connectedness$p_trad_trad_s,
                                    cryp_trad_m = volatility_connectedness$p_cry_trad_m,
                                    trad_cryp_m = volatility_connectedness$p_trad_cry_m,
                                    cryp_cryp_m = volatility_connectedness$p_cry_cry_m,
                                    trad_trad_m = volatility_connectedness$p_trad_trad_m,
                                    cryp_trad_l = volatility_connectedness$p_cry_trad_l,
                                    trad_cryp_l = volatility_connectedness$p_trad_cry_l,
                                    cryp_cryp_l = volatility_connectedness$p_cry_cry_l,
                                    trad_trad_l = volatility_connectedness$p_trad_trad_l)
write.csv(volatility_results.table, file="../Results/volatility_table.csv")

# as.data.frame(describe(returns[time_length, crypto]))
exchange <- read_csv("~/Desktop/Cryptocurrency/Data/preprocessed/exchange_cleaned.csv")
# estimate test statistic and data-stamping sequence
obs <- length(time_length)
r0 <- 100
test <- rtadf(1/exchange[time_length, ]$USDBTC, r0, test='sadf')

# simulate critical values and data-stamping threshold
cvs <- rtadfSimPar(obs, nrep=1000, r0, test = 'sadf')

testDf <- list("test statistic" = test$testStat, "critical values" = cvs$testCVs)  # test results

print(testDf)  

StampDf.BTC <- data.frame('The backward SADF sequence (left axis)'= test$testSeq,
                          'The 95% critical value sequence (left axis)'= cvs$datestampCVs[,2],
                          'The price of Bitcoin (right axis)' = 1/exchange[time_length, ]$USDBTC,
                          'Time'= time_stamp[c(100:length(time_stamp))])  # data for datestamping procedure

colors <- c("The backward SADF sequence (left axis)" = "#2323A6",
            "The 95% critical value sequence (left axis)" = "#A52422",
            "Price in USD (right axis)" = "#0D5A0D")

ggplot(StampDf.BTC) +
  geom_line(aes(x=StampDf.BTC$Time, y=StampDf.BTC$The.backward.SADF.sequence..left.axis., color="The backward SADF sequence (left axis)"), size=1) +
  geom_line(aes(x=StampDf.BTC$Time, y=StampDf.BTC$The.95..critical.value.sequence..left.axis., color="The 95% critical value sequence (left axis)"), size=1) +
  geom_line(aes(x=StampDf.BTC$Time, y=StampDf.BTC$The.price.of.Bitcoin..right.axis./5000, color="Price in USD (right axis)"), size=1) +
  scale_y_continuous('Critical Values', sec.axis = sec_axis(~.*5000, name='Price')) +
  theme_cowplot() + scale_color_manual(values = colors) +
  labs(title="BTC", x="Time", color='') +
  theme(legend.position = 'none', plot.margin = margin(0.5,0.5,0.5,0.5, "cm"), 
        text=element_text(family="Times New Roman"))



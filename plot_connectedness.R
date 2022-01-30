# define a function to perform the task
plot_connectedness <- function(dataset) {
  model.basic <- constructModel(dataset, p=3, struct = "Basic",
                                gran=c(10, 25), RVAR=FALSE, h=1,
                                cv="Rolling", MN=FALSE, verbose=FALSE,
                                IC=TRUE)
  result <- cv.BigVAR(model.basic)
  
  cryptoTotrad_s <- vector(mode="numeric", length=0)
  tradTocrypto_s <- vector(mode="numeric", length=0)
  cryptoTotrad_m <- vector(mode="numeric", length=0)
  tradTocrypto_m <- vector(mode="numeric", length=0)
  cryptoTotrad_l <- vector(mode="numeric", length=0)
  tradTocrypto_l <- vector(mode="numeric", length=0)
  
  dy12 <- spilloverBK12(result, n.ahead = 100, no.corr = F, partition = bounds)
  s <- dy12$tables[[1]]
  cryptoTotrad_s <- append(cryptoTotrad_s, as.numeric(s[c(12:37), c(1:11)]))
  tradTocrypto_s <- append(tradTocrypto_s, as.numeric(s[c(1:11), c(12:37)]))
  m <- dy12$tables[[2]]
  cryptoTotrad_m <- append(cryptoTotrad_m, as.numeric(m[c(12:37), c(1:11)]))
  tradTocrypto_m <- append(tradTocrypto_m, as.numeric(m[c(1:11), c(12:37)]))
  l <- dy12$tables[[3]]
  cryptoTotrad_l <- append(cryptoTotrad_l, as.numeric(l[c(12:37), c(1:11)]))
  tradTocrypto_l <- append(tradTocrypto_l, as.numeric(l[c(1:11), c(12:37)]))
  
  colors <- c("Crypto->Currency" = "red", "Currency->Crypto" = "blue")
  a <- ggplot() + 
    geom_density(data = as.data.frame(tradTocrypto_s), alpha=0.9,
                 aes(x=tradTocrypto_s, ..scaled.., fill="Currency->Crypto")) +
    geom_density(data = as.data.frame(cryptoTotrad_s), alpha=0.9,
                 aes(x=cryptoTotrad_s, ..scaled.., fill="Crypto->Currency")) +
    labs(x="Connectedness", y="Probability", fill='') +
    scale_color_manual(values = colors) + theme_cowplot() +
    theme(legend.position = c(0.7, 0.8),
          plot.margin = margin(0.5,0.8,0.5,0.8, "cm"),
          text=element_text(family="Times New Roman"))
  return(a)
}


# apply plot_connectedness to each dataset
as <- sapply(list(return.matrix, preturn.matrix, nreturn.matrix,
                  volatility.matrix), plot_connectedness, simplify = TRUE)


# plot the four
plot_grid(as[[1]], as[[2]], as[[3]], as[[4]], align = 'v', ncol = 2, nrow = 2)

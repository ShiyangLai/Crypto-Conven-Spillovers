# define a function to perform the task
plot_connectedness <- function(dataset) {
  model.basic <- constructModel(dataset, p=3, struct = "Basic",
                                gran=c(10, 25), RVAR=FALSE, h=1,
                                cv="Rolling", MN=FALSE, verbose=FALSE,
                                IC=TRUE)
  result <- cv.BigVAR(model.basic)
  
  crypTotrad_s <- vector(mode="numeric", length=0)
  tradTocryp_s <- vector(mode="numeric", length=0)
  crypTocryp_s <- vector(mode="numeric", length=0)
  tradTotrad_s <- vector(mode="numeric", length=0)
  
  crypTotrad_m <- vector(mode="numeric", length=0)
  tradTocryp_m <- vector(mode="numeric", length=0)
  crypTocryp_m <- vector(mode="numeric", length=0)
  tradTotrad_m <- vector(mode="numeric", length=0)
  
  crypTotrad_l <- vector(mode="numeric", length=0)
  tradTocryp_l <- vector(mode="numeric", length=0)
  crypTocryp_l <- vector(mode="numeric", length=0)
  tradTotrad_l <- vector(mode="numeric", length=0)
  
  dy12 <- spilloverBK12(result, n.ahead = 100, no.corr = F, partition = bounds)
  
  s <- dy12$tables[[1]]
  crypTotrad_s <- append(crypTotrad_s, as.numeric(s[c(12:37), c(1:11)]))
  tradTocryp_s <- append(tradTocryp_s, as.numeric(s[c(1:11), c(12:37)]))
  crypTocryp_s <- append(crypTocryp_s, as.numeric(s[c(1:11), c(1:11)]))
  tradTotrad_s <- append(tradTotrad_s, as.numeric(s[c(12:37), c(12:37)]))
  
  m <- dy12$tables[[2]]
  crypTotrad_m <- append(crypTotrad_m, as.numeric(m[c(12:37), c(1:11)]))
  tradTocryp_m <- append(tradTocryp_m, as.numeric(m[c(1:11), c(12:37)]))
  crypTocryp_m <- append(crypTocryp_m, as.numeric(m[c(1:11), c(1:11)]))
  tradTotrad_m <- append(tradTotrad_m, as.numeric(m[c(12:37), c(12:37)]))
  
  
  l <- dy12$tables[[3]]
  crypTotrad_l <- append(crypTotrad_l, as.numeric(l[c(12:37), c(1:11)]))
  tradTocryp_l <- append(tradTocryp_l, as.numeric(l[c(1:11), c(12:37)]))
  crypTocryp_l <- append(crypTocryp_l, as.numeric(l[c(1:11), c(1:11)]))
  tradTotrad_l <- append(tradTotrad_l, as.numeric(l[c(12:37), c(12:37)]))
  
  colors <- c("Crypto->Curren" = "#20639B",
              "Curren->Crypto" = "#3CAEA3",
              "Crypto->Crypto" = "#F6D55C",
              "Curren->Curren" = "#ED553B")
  a <- ggplot() + 
    geom_density(data = as.data.frame(tradTocryp_s), alpha=0.8,
                 aes(x=tradTocryp_s, fill="Curren->Crypto")) +
    geom_density(data = as.data.frame(crypTotrad_s), alpha=0.8,
                 aes(x=crypTotrad_s, fill="Crypto->Curren")) +
    # geom_density(data = as.data.frame(crypTocryp_s), alpha=0.8,
                 # aes(x=crypTocryp_s, fill="Crypto->Crypto")) +
    # geom_density(data = as.data.frame(tradTotrad_s), alpha=0.8,
                 # aes(x=tradTotrad_s, fill="Curren->Curren")) +
    labs(x="Connectedness", y="Probability", fill='') +
    scale_color_manual(values = colors) + theme_cowplot() +
    theme(legend.position = c(0.6, 0.8),
          plot.margin = margin(0.5,0.8,0.5,0.8, "cm"),
          text=element_text(family="Times New Roman"))
  return(a)
}


# apply plot_connectedness to each dataset
a11 <- plot_connectedness(return.matrix)
a12 <- plot_connectedness(preturn.matrix)
a13 <- plot_connectedness(nreturn.matrix)
a14 <- plot_connectedness(volatility.matrix)


# plot the four
plot_grid(a11, a12, a13, a14,
          align = 'v', ncol = 2, nrow = 2)


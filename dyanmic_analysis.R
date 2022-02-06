# next, rolling the time window
cl <- makeCluster(6)
clusterEvalQ(cl, library(BigVAR))
clusterEvalQ(cl, library(frequencyConnectedness))
clusterExport(cl, 'bounds')

big_var_est <- function(data) {
  Model <- constructModel(data, p = 4, struct = "Basic", gran = c(10, 25), RVAR=FALSE,
                          h=1, cv="Rolling", MN=FALSE, verbose=FALSE, IC=TRUE)
  Model1Results <- cv.BigVAR(Model)
}

sp <- spilloverRollingBK12(volatility.matrix, n.ahead = 100, no.corr = F, func_est = "big_var_est",
                           params_est = list(), window = 100, partition = bounds, cluster = cl)
stopCluster(cl)
plotOverall(sp)

# calculate the spillover between cryptocurrency and traditional currency
# short term first
p_cry_trad_s <- vector(mode="numeric", length=0)
p_trad_cry_s <- vector(mode="numeric", length=0)
for (i in time_length) {
  cry_trad <- as.numeric(sp$list_of_tables[[i]][[1]][[1]][conven, crypto])
  trad_cry <- as.numeric(sp$list_of_tables[[i]][[1]][[1]][crypto, conven])
  p_cry_trad_s <- append(p_cry_trad_s, sum(cry_trad) / (length(conven) * length(crypto)))
  p_trad_cry_s <- append(p_trad_cry_s, sum(trad_cry) / (length(conven) * length(crypto)))
}

p_cry_trad_m <- vector(mode="numeric", length=0)
p_trad_cry_m <- vector(mode="numeric", length=0)
for (i in time_length) {
  cry_trad <- as.numeric(sp$list_of_tables[[i]][[1]][[2]][conven, crypto])
  trad_cry <- as.numeric(sp$list_of_tables[[i]][[1]][[2]][crypto, conven])
  p_cry_trad_m <- append(p_cry_trad_m, sum(cry_trad) / (length(conven) * length(crypto)))
  p_trad_cry_m <- append(p_trad_cry_m, sum(trad_cry) / (length(conven) * length(crypto)))
}

p_cry_trad_l <- vector(mode="numeric", length=0)
p_trad_cry_l <- vector(mode="numeric", length=0)
for (i in time_length) {
  cry_trad <- as.numeric(sp$list_of_tables[[i]][[1]][[3]][conven, crypto])
  trad_cry <- as.numeric(sp$list_of_tables[[i]][[1]][[3]][crypto, conven])
  p_cry_trad_l <- append(p_cry_trad_l, sum(cry_trad) / (length(conven) * length(crypto)))
  p_trad_cry_l <- append(p_trad_cry_l, sum(trad_cry) / (length(conven) * length(crypto)))
}

dates <- seq(as.Date("2015-1-1"), as.Date("2022-1-1"), by = "days")
colors <- c("Curren->Crypto" = "#213FE7", "Crypto->Curren" = "#D82121")

a1 <- ggplot() +
  geom_line(aes(x=dates[time_length], y=p_cry_trad_s, color='Crypto->Curren'), size=1) +
  geom_line(aes(x=dates[time_length], y=p_trad_cry_s, color='Curren->Crypto'), size=1) +
  labs(y="Connectedness", x="Time", color='') +
  scale_color_manual(values = colors) + theme_cowplot() +
  theme(legend.position = c(0.4, 0.9),
        text=element_text(family="Times New Roman"))
a2 <- ggplot() +
  geom_line(aes(x=dates[time_length], y=p_cry_trad_m, color='Crypto->Curren'), size=1) +
  geom_line(aes(x=dates[time_length], y=p_trad_cry_m, color='Curren->Crypto'), size=1) +
  labs(y="Connectedness", x="Time", color='') +
  scale_color_manual(values = colors) + theme_cowplot() +
  theme(legend.position = c(0.4, 0.9),
        text=element_text(family="Times New Roman"))
a3 <- ggplot() +
  geom_line(aes(x=dates[time_length], y=p_cry_trad_l, color='Crypto->Curren'), size=1) +
  geom_line(aes(x=dates[time_length], y=p_trad_cry_l, color='Curren->Crypto'), size=1) +
  labs(y="Connectedness", x="Time", color='') +
  scale_color_manual(values = colors) + theme_cowplot() +
  theme(legend.position = c(0.4, 0.9),
        text=element_text(family="Times New Roman"))
plot_grid(a1, a2, a3,
          align = 'v', cols = 1)


# within market
p_trad_trad_s <- vector(mode="numeric", length=0)
p_cry_cry_s <- vector(mode="numeric", length=0)
for (i in c(1:2459)) {
  trad_trad <- as.numeric(sp$list_of_tables[[i]][[1]][[1]][c(6:14),c(6:14)])
  cry_cry <- as.numeric(sp$list_of_tables[[i]][[1]][[1]][c(1:5),c(1:5)])
  p_trad_trad_s <- append(p_trad_trad_s, sum(trad_trad) / 81)
  p_cry_cry_s <- append(p_cry_cry_s, sum(cry_cry) / 25)
}
p_trad_trad_m <- vector(mode="numeric", length=0)
p_cry_cry_m <- vector(mode="numeric", length=0)
for (i in c(1:2459)) {
  trad_trad <- as.numeric(sp$list_of_tables[[i]][[1]][[2]][c(6:14),c(6:14)])
  cry_cry <- as.numeric(sp$list_of_tables[[i]][[1]][[2]][c(1:5),c(1:5)])
  p_trad_trad_m <- append(p_trad_trad_m, sum(trad_trad) / 81)
  p_cry_cry_m <- append(p_cry_cry_m, sum(cry_cry) / 25)
}
p_trad_trad_l <- vector(mode="numeric", length=0)
p_cry_cry_l <- vector(mode="numeric", length=0)
for (i in c(1:2459)) {
  trad_trad <- as.numeric(sp$list_of_tables[[i]][[1]][[3]][c(6:14),c(6:14)])
  cry_cry <- as.numeric(sp$list_of_tables[[i]][[1]][[3]][c(1:5),c(1:5)])
  p_trad_trad_l <- append(p_trad_trad_l, sum(trad_trad) / 81)
  p_cry_cry_l <- append(p_cry_cry_l, sum(cry_cry) / 25)
}

colors <- c("Curren->Curren" = "#213FE7", "Crypto->Crypto" = "#D82121")

a1 <- ggplot() +
  geom_line(aes(x=dates[c(1:2459)], y=p_cry_cry_s, color='Crypto->Crypto'), size=1) +
  geom_line(aes(x=dates[c(1:2459)], y=p_trad_trad_s, color='Curren->Curren'), size=1) +
  labs(y="Connectedness", x="Time", color='') +
  scale_color_manual(values = colors) + theme_cowplot() +
  theme(legend.position = 'none', text=element_text(family="Times New Roman"))
a2 <- ggplot() +
  geom_line(aes(x=dates[c(1:2459)], y=p_cry_cry_m, color='Crypto->Crypto'), size=1) +
  geom_line(aes(x=dates[c(1:2459)], y=p_trad_trad_m, color='Curren->Curren'), size=1) +
  labs(y="Connectedness", x="Time", color='') +
  scale_color_manual(values = colors) + theme_cowplot() +
  theme(legend.position = 'none', text=element_text(family="Times New Roman"))
a3 <- ggplot() +
  geom_line(aes(x=dates[c(1:2459)], y=p_cry_cry_l, color='Crypto->Crypto'), size=1) +
  geom_line(aes(x=dates[c(1:2459)], y=p_trad_trad_l, color='Curren->Curren'), size=1) +
  labs(y="Connectedness", x="Time", color='') +
  scale_color_manual(values = colors) + theme_cowplot() +
  theme(legend.position = 'bottom',
        text=element_text(family="Times New Roman"))
plot_grid(a1, a2, a3,
          align = 'v', cols = 1)




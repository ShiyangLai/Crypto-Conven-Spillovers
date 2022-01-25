# calculate the VAR-L model
library(devtools)
# install_github("tomaskrehlik/frequencyConnectedness", tag = "dev")
unloadNamespace('rmarkdown')
library(vars)
library(frequencyConnectedness)
library(BigVAR)
library(lubridate)

returns <- read_csv("Exp Data/v2/returns.csv", 
                    col_types = cols(...1 = col_date(format = "%Y-%m-%d")))

conven_returns <- read_csv("Exp Data/v2/conv_returns.csv", 
                    col_types = cols(...1 = col_date(format = "%Y-%m-%d")))

crypto_returns <- read_csv("Exp Data/v2/crypto_returns.csv", 
                           col_types = cols(...1 = col_date(format = "%Y-%m-%d")))


########################## returns ##############################

# time
time_stamp <- seq(as.Date("2009-01-02"), as.Date("2022-01-01"), by="day")

# transform to matrix
return.matrix <- data.matrix(returns[,c(2:38)])

# for conventional currency, the best lag is 9
VARselect(conven_returns[,c(2:27)], lag.max=20, type='both')

# for cryptocurrency, the best lag is 2
VARselect(filter(crypto_returns, ...1 >= ymd('2018-01-01'))[,c(2:12)], lag.max=20, type='both')

# set lag order to 9 according to AIC and FPE
model.basic <- constructModel(return.matrix, p=3, struct = "Basic",
                              gran=c(26, 26), RVAR=FALSE, h=1,
                              cv="Rolling", MN=FALSE, verbose=FALSE,
                              IC=TRUE)
result <- cv.BigVAR(model.basic)
plot(result)
SparsityPlot.BigVAR.results(result)
result


########################## positive returns ############################

#


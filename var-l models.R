# calculate the VAR-L model
library(devtools)
# install_github("tomaskrehlik/frequencyConnectedness", tag = "dev")
unloadNamespace('rmarkdown')
library(vars)
library(frequencyConnectedness)
library(BigVAR)
library(lubridate)

focals <- c("USDBTC", "USDETH", "USDDOGE", "USDLTC", "USDXRP",
            "USDEUR", "USDJPY", "USDGBP", "USDAUD", "USDCAD",
            "USDCHF", "USDCNY", "USDSEK", "USDNZD")

returns <- read_csv("Exp Data/v2/returns.csv", 
                    col_types = cols(...1 = col_date(format = "%Y-%m-%d")))
returns <- returns[, focals]

positive_returns <- read_csv("Exp Data/v2/preturns.csv",
                             col_types = cols(...1 = col_date(format = "%Y-%m-%d")))
positive_returns <- positive_returns[, focals]

negative_returns <- read_csv("Exp Data/v2/nreturns.csv",
                             col_types = cols(...1 = col_date(format = "%Y-%m-%d")))
negative_returns <- negative_returns[, focals]

volatility <- read_csv("Exp Data/v2/volatility.csv",
                       col_types = cols(...1 = col_date(format = "%Y-%m-%d")))
volatility <- volatility[, focals]
  
time_range <- c(2556:4748)
time_length <- c(1:2094)
########################## returns ##############################

# time 2009-2022
time_stamp <- seq(as.Date("2016-01-01"), as.Date("2022-01-01"), by="day")

# transform to matrix
return.matrix <- data.matrix(returns[time_range, ])

# try a var model
white_noise <- matrix(rnorm(4748*37, 0, 10e-9), 4748, 37)
model.var <-VAR(white_noise, p=3) 
dy12 <- spilloverBK12(model.var, n.ahead = 100, no.corr = F, partition = bounds)

# for conventional currency, the best lag is 9
VARselect(returns, lag.max=20, type='both')

# for cryptocurrency, the best lag is 2
VARselect(filter(crypto_returns, ...1 >= ymd('2018-01-01'))[,c(2:12)], lag.max=20, type='both')

# set lag order to 3 according to AIC and FPE
model.basic <- constructModel(return.matrix, p=3, struct = "Basic",
                              gran=c(10, 25), RVAR=FALSE, h=1,
                              cv="Rolling", MN=FALSE, verbose=FALSE,
                              IC=TRUE)
result <- cv.BigVAR(model.basic)
plot(result)
SparsityPlot.BigVAR.results(result)
result


########################## positive returns ############################

# transform to matrix
preturn.matrix <- data.matrix(positive_returns[c(2191:4748),])
# train a VAR-LASSO model
model.basic <- constructModel(preturn.matrix, p=3, struct = "Basic",
                              gran=c(10, 25), RVAR=FALSE, h=1,
                              cv="Rolling", MN=FALSE, verbose=FALSE,
                              IC=TRUE)
result <- cv.BigVAR(model.basic)
SparsityPlot.BigVAR.results(result)
result


########################## negative returns ############################

# transform to matrix
nreturn.matrix <- data.matrix(negative_returns[c(2191:4748),])
# train a VAR-LASSO model
model.basic <- constructModel(nreturn.matrix, p=3, struct = "Basic",
                              gran=c(10, 25), RVAR=FALSE, h=1,
                              cv="Rolling", MN=FALSE, verbose=FALSE,
                              IC=TRUE)
result <- cv.BigVAR(model.basic)
SparsityPlot.BigVAR.results(result)
result


########################## volatility ############################

# transform to matrix
volatility.matrix <- data.matrix(volatility[c(2191:4748),])
# train a VAR-LASSO model
model.basic <- constructModel(volatility.matrix, p=3, struct = "Basic",
                              gran=c(10, 25), RVAR=FALSE, h=1,
                              cv="Rolling", MN=FALSE, verbose=FALSE,
                              IC=TRUE)
result <- cv.BigVAR(model.basic)
SparsityPlot.BigVAR.results(result)
result







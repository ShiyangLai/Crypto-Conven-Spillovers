# next, rolling the time window
library(parallel)
cl <- makeCluster(6)
clusterEvalQ(cl, library(BigVAR))
clusterEvalQ(cl, library(frequencyConnectedness))
clusterExport(cl, 'bounds')

big_var_est <- function(data) {
  Model <- constructModel(data, p = 3, struct = "Basic", gran = c(10, 25), RVAR=FALSE,
                          h=1, cv="Rolling", MN=FALSE, verbose=FALSE, IC=TRUE)
  Model1Results <- cv.BigVAR(Model)
}

sp <- spilloverRollingBK12(return.matrix, n.ahead = 100, no.corr = F, func_est = "big_var_est",
                           params_est = list(), window = 100, partition = bounds, cluster = cl)
stopCluster(cl)
plotOverall(sp)

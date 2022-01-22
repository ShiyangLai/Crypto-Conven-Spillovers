# calculate connectedness with frequency
bounds <- c(pi+0.00001, pi/2, pi/7, 0)
dy12 <- spilloverBK12(result, n.ahead=100, no.corr=F, partition=bounds)
dy12
net(dy12)
library(readr)                       # library for csv data reading
library(vars)                        # library for simple VAR model
library(BigVAR)                      # library for large VARX model
library(frequencyConnectedness)      # library for spillovers calculation
library(igraph)                      # library for graph analysis

# read data
returns <- read_csv("~/Desktop/Cryptocurrency/Data/preprocessed/returns_cleaned.csv")
preturns <- read_csv("~/Desktop/Cryptocurrency/Data/preprocessed/preturn_cleaned.csv")

# get all currency names
coins <- colnames(preturn)[c(2:length(colnames(preturn)))]

# get all cryptocurrencies names and conventional currencies names
crypto <- coins[c(1:85)]
conven <- coins[c(86:length(coins))]

# var lag selection
# VARselect(returns[,coins], lag.max=30, type='both')

# do one lag term VAR fitting, the running time increase exponentially with the lag term, p.
start_time <- Sys.time()   # record the starting time
# fit <- VAR(returns[,coins], p=1, type = 'both')
# fit <- VAR(returns[,coins], p=1, type='const')
model <- constructModel(data.matrix(nreturn[,coins]), p=1, struct = "Basic",
                               gran=c(10, 25), RVAR=FALSE, h=1,
                               cv="Rolling", MN=FALSE, verbose=FALSE,
                               IC=TRUE)
fit <- cv.BigVAR(model)
plot(fit)
SparsityPlot.BigVAR.results(fit)

end_time <- Sys.time()    # record the ending time
print(end_time - start_time)

# calculate spillovers
bounds <- c(pi+0.00001, pi/2, pi/7, 0)
dy12 <- spilloverBK12(fit, n.ahead=100, no.corr=F, partition=bounds)

# network analysis (need to parallel)
magic_fun <- function(x){
  return (x*100)}

# use magic function to transform the original output to data frame
df <- data.frame(dy12$tables[[1]])
# df$name <- colnames(df)

# write it into repository
write_csv(df, '../Data/n_network_short.csv')

# load data as graph
g <- graph.adjacency(as.matrix(df), mode="directed", weighted=TRUE) # For directed
g <- simplify(g, remove.loops = TRUE)   # omit self links

# determine the width and the color of edges
E(g)$width <- (log(E(g)$weight+1)+0.1)/max((log(E(g)$weight+1)+0.1))
color_map <- vector(mode='numeric')
for (i in c(1:length(ends(g, es=E(g), names=T)[,1]))) {
  if (is.element(ends(g, es=E(g), names=T)[i,1], crypto) && is.element(ends(g, es=E(g), names=T)[i,2], conven)) {
    color_map[i] <- adjustcolor('#6C3483', alpha.f=E(g)$width[i])     # color links from cryptocurrencies to conventional currencies
  } else {
    if (is.element(ends(g, es=E(g), names=T)[i,1], conven) && is.element(ends(g, es=E(g), names=T)[i,2], crypto)) {
      color_map <- adjustcolor('#6C3483', alpha.f=E(g)$width[i])
    } else {
      color_map <- adjustcolor('#1C2833', alpha.f=E(g)$width[i])
    }
  }
}
E(g)$edge.color <- color_map

# determine the color of nodes. The opacity reflects the within-market in-degree/out-degree
g_c.in <- g
g_c.in <- delete.edges(g_c.in, which(E(g_c.in)$edge.color=='#6C3483'))
in_degree <- strength(g_c.in, mode='in')
indeg <- (in_degree-min(in_degree)+10)/(max(in_degree)-min(in_degree)) * 1.3
color_map <- vector(mode='numeric')
for (i in coins) {
  if (is.element(i, crypto)) {
    color_map[i] <- adjustcolor('darkred', alpha.f=indeg[i])
  } else {
    color_map[i] <- adjustcolor('darkblue', alpha.f=indeg[i])
  }
}
V(g)$color <- color_map

# determine the size of nodes. The size reflects cross-market in-degree/out-degree
g_c.out <- g
g_c.out <- delete.edges(g_c.out, which(E(g_c.out)$edge.color=='#1C2833'))
V(g)$size <- log((strength(g_c.out, mode='in') + 1) * 3) * 7

# frame color
indeg <- (in_degree-min(in_degree)+10)/(max(in_degree)-min(in_degree)) * 4
color_map <- vector(mode='numeric')
for (i in coins) {
  if (is.element(i, crypto)) {
    color_map[i] <- adjustcolor('darkred', alpha.f=indeg[i])
  } else {
    color_map[i] <- adjustcolor('darkblue', alpha.f=indeg[i])
  }
}

# draw the plot
g %>%
  add_layout_(with_fr(maxit=5000), normalize()) %>%
  plot(edge.arrow.size=0.1, vertex.label=NA, vertex.frame.color=NA,
       edge.color = adjustcolor(E(g)$edge.color, .01), vertex.size=V(g)$size,
       vertex.color=V(g)$color, edge.curved=0.2, shape='circle', vertex.arrow.size=1)

title("Connectedness within 100 days",cex.main=1.7, family="Times", line = -34.2)

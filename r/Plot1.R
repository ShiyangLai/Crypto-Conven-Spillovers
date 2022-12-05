library(png)
library(grid)

short_return <- readPNG('../Results/return_short.png')
medium_return <- readPNG('../Results/return_medium.png')
long_return <- readPNG('../Results/return_long.png')

svglite("../Data/myplot.svg", width = 11, height = 9.1)

ggplot() +
  geom_line(aes(x=c(0, 1, 2), y=c(0.354, 0.213, 0.092)), color='grey', size=0.8, alpha=1, linetype = 2) +
  geom_point(aes(x=c(0, 1, 2), y=c(0.354, 0.213, 0.092)), color='#6A6A6A', size=2, alpha=0.8) +
  # geom_line(aes(x=c(0, 1, 2), y=c(0.007396172, 0.00255197, 0.0021458)), color='grey', size=0.8, alpha=1, linetype = 2) +
  # geom_line(aes(x=c(0, 1, 2), y=c(0.005105005, 0.00485442, 0.001060568)), color='green', size=0.8, alpha=1, linetype=2) +
  # geom_line(aes(x=c(0, 1, 2), y=c(8.117785e-05, 3.985362e-05, 1.648727e-05)), color='orange', size=0.8, alpha=1, linetype=2) +
  theme_cowplot() +
  xlab('Frequency') + ylab('Avg. Weighted Degree') +
  theme(legend.position = "none", plot.margin = margin(12,14,0.5,0.5, "cm"),
        text=element_text(family="Arial", colour = '#505050'),
        axis.line = element_line(colour = '#505050'), axis.text = element_text(colour = '#505050'),
        axis.title = element_text(size = 12, color = '#505050')) +
  scale_x_discrete(limits=c(0, 1, 2), labels=c("Short", "Medium", "Long"))

grid.raster(short_return, x=.25, y=0.75, width=.42)
grid.raster(medium_return, x=.72, y=0.75, width=.42)
grid.raster(long_return, x=.72, y=0.30, width=.42)

dev.off()

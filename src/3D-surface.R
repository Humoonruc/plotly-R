library(tidyverse)
library(plotly)
library(htmlwidgets)

scale <- 1000


sigmoid <- function(x) {
  1 / (1 + exp(-x))
}

cal_z <- function(x, y) {
  10 * x - 15 * y
}

cal_a <- function(x, y) {
  cal_z(x, y) %>% sigmoid()
}


x1 <- runif(scale) %>% sort()
## x1 <- c(0.2,0.6)
y1 <- runif(scale) %>% sort()
## y1 <- c(0.2, 0.6)
z1 <- outer(x1, y1, cal_a)
p1 <- plot_ly(type = "surface", x = x1, y = y1, z = ~z1)
p1
saveWidget(p1, "./figure/sigmoid曲面1.html", selfcontained = F, libdir = "lib")


x2 <- seq(0, 1, length.out = scale + 1)
y2 <- seq(0, 1, length.out = scale + 1)
z2 <- outer(x2, y2, cal_a)
p2 <- plot_ly(type = "surface", x = x2, y = y2, z = ~z2)
saveWidget(p2, "./figure/sigmoid曲面2.html", selfcontained = F, libdir = "lib")
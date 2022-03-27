## inset-plots.R

# import modules
library(tidyverse)
library(data.table)
library(magrittr)
library(plotly)
library(htmlwidgets)
library(xfun)
library(downloadthis)


fig <- plot_ly() %>%
  add_lines(x = c(1, 2, 3), y = c(4, 3, 2)) %>%
  add_lines(x = c(20, 30, 40), y = c(30, 40, 50), xaxis = "x2", yaxis = "y2") %>%
  layout(
    xaxis2 = list(domain = c(0.6, 0.95), anchor = "y2"),
    yaxis2 = list(domain = c(0.6, 0.95), anchor = "x2")
  )
fig

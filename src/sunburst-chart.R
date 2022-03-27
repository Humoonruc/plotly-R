## Sunburst-chart.R

# import modules
library(tidyverse)
library(data.table)
library(magrittr)
library(plotly)
library(htmlwidgets)
library(xfun)
library(downloadthis)


p0 <- plot_ly()

p <- p0 %>% add_trace(
  type = "sunburst",
  # 数据结构分为三个向量
  # 第一个是所有块的名称
  # 第二个指出了所有块的父级块
  # 第三个是数字
  # 当branchvalues = "remainder"时，子块与父块数值的加总才被映射为父块在图中的角度
  # 当branchvalues = "total"时，父块数值本身被映射为父块在图中的角度
  labels = c("Eve", "Cain", "Seth", "Enos", "Noam", "Abel", "Awan", "Enoch", "Azura"),
  parents = c("", "Eve", "Eve", "Seth", "Seth", "Eve", "Eve", "Awan", "Eve"),
  values = c(10, 14, 12, 10, 2, 6, 6, 4, 4),
  branchvalues = "remainder"
)
p


p <- p0 %>% add_trace(
  type = "sunburst",
  labels = c("Eve", "Cain", "Seth", "Enos", "Noam", "Abel", "Awan", "Enoch", "Azura"),
  parents = c("", "Eve", "Eve", "Seth", "Seth", "Eve", "Eve", "Awan", "Eve"),
  values = c(45, 14, 12, 10, 2, 6, 6, 4, 4),
  branchvalues = "total"
)
p


# Sunburst with Repeated Labels

d <- data.table(
  ids = c(
    "North America", "Europe", "Australia", "North America - Football", "Soccer",
    "North America - Rugby", "Europe - Football", "Rugby",
    "Europe - American Football", "Australia - Football", "Association",
    "Australian Rules", "Autstralia - American Football", "Australia - Rugby",
    "Rugby League", "Rugby Union"
  ),
  labels = c(
    "North<br>America", "Europe", "Australia", "Football", "Soccer", "Rugby",
    "Football", "Rugby", "American<br>Football", "Football", "Association",
    "Australian<br>Rules", "American<br>Football", "Rugby", "Rugby<br>League",
    "Rugby<br>Union"
  ),
  # parents 使用ids而非labels
  parents = c(
    "", "", "", "North America", "North America", "North America", "Europe",
    "Europe", "Europe", "Australia", "Australia - Football", "Australia - Football",
    "Australia - Football", "Australia - Football", "Australia - Rugby",
    "Australia - Rugby"
  )
)

p <- plot_ly(d, ids = ~ids, labels = ~labels, parents = ~parents, type = "sunburst")
p

# Controlling text orientation inside sunburst sectors

df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/718417069ead87650b90472464c7565dc8c2cb1c/coffee-flavors.csv")

fig <- plot_ly() %>% add_trace(
  type = "sunburst",
  ids = df$ids,
  labels = df$labels,
  parents = df$parents,
  insidetextorientation = "radial", # 内部文本不再是环向，而是统一为轴向
  maxdepth = 2 # 更低级别的不再显示
)
fig

# Subplots
d1 <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/coffee-flavors.csv")
d2 <- read.csv("https://raw.githubusercontent.com/plotly/datasets/718417069ead87650b90472464c7565dc8c2cb1c/sunburst-coffee-flavors-complete.csv")

fig <- plot_ly() %>%
  add_trace(
    ids = d1$ids,
    labels = d1$labels,
    parents = d1$parents,
    type = "sunburst",
    maxdepth = 2,
    domain = list(column = 0)
  ) %>%
  add_trace(
    ids = d2$ids,
    labels = d2$labels,
    parents = d2$parents,
    type = "sunburst",
    maxdepth = 3,
    domain = list(column = 1)
  ) %>%
  layout(
    # 多幅图构成的“网格”
    grid = list(columns = 2, rows = 1),
    margin = list(l = 0, r = 0, b = 0, t = 0),
    colorway = c(
      "#636efa", "#EF553B", "#00cc96", "#ab63fa", "#19d3f3",
      "#e763fa", "#FECB52", "#FFA15A", "#FF6692", "#B6E880"
    ),
    extendsunburstcolors = TRUE
    # If `TRUE`, the sunburst slice colors (given by `sunburstcolorway`
    # or inherited from `colorway`) will be extended to three times
    # its original length by first repeating every color 20% lighter
    # then each color 20% darker. This is intended to reduce the likelihood
    # of reusing the same color when you have many slices, but you can set
    # `FALSE` to disable. Colors provided in the trace, using `marker.colors`,
    # are never extended.
  )
fig
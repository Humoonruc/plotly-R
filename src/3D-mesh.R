## 3D-mesh.R

# import modules
library(tidyverse)
library(data.table)
library(magrittr)
library(plotly)
library(htmlwidgets)
library(xfun)
library(downloadthis)


fig <- plot_ly(
  x = c(0, 0, 1, 1, 0, 0, 1, 1),
  y = c(0, 1, 1, 0, 0, 1, 1, 0),
  z = c(0, 0, 0, 0, 1, 1, 1, 1),
  # 共8个顶点
  i = c(7, 0, 0, 0, 4, 4, 2, 6, 4, 0, 3, 7), # 每个三角面的第一个顶点的index
  j = c(3, 4, 1, 2, 5, 6, 5, 5, 0, 1, 2, 2), # 每个三角面的第二个顶点的index
  k = c(0, 7, 2, 3, 6, 7, 1, 2, 5, 5, 7, 6), # 每个三角面的第三个顶点的index
  # 共12个三角面，作为三维图形的表面
  facecolor = rep(toRGB(viridisLite::inferno(6)), each = 2),
  # 两个三角面构成一个正方形面，共用一个颜色
  type = "mesh3d"
)

fig


helicopter <- fread("./Rmd/data/3d-mesh-helicopter.csv")
helicopter

# 求各面三点的平均z值，以此作为该面涂色的依据
zmean <- 1:nrow(helicopter) %>%
  map_dbl(function(n) {
    surface <- helicopter[n, ]
    index1 <- surface$i + 1
    index2 <- surface$j + 1
    index3 <- surface$k + 1
    helicopter[c(index1, index2, index3), ] %>%
      pull(z) %>%
      mean()
  })

library(scales)
num_to_color <- function(num_domain, color_range) {
  color_scale <- colour_ramp(color_range)

  num_domain %>%
    rescale() %>%
    color_scale()
}
color_range <- c("red", "green", "blue")
# color_range <- brewer_pal(palette = "RdBu")(9)
facecolor <- num_to_color(zmean, color_range)

p7 <- plot_ly(
  data = helicopter,
  x = ~x, y = ~y, z = ~z,
  i = ~i, j = ~j, k = ~k, # 各三角面三个顶点的索引
  # facecolor = ~facecolor,
  facecolor = facecolor, # 数据中已包含颜色属性，此处演示如何计算颜色
  opacity = 1,
  type = "mesh3d"
)
p7

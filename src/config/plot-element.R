## plot-element.R
library(tidyverse)
library(data.table)
library(magrittr)
library(plotly)
library(htmlwidgets)


# 初始化画布（坐标系）
axis_template <- list(
  # nticks = 20,
  # zeroline = TRUE,
  zerolinecolor = "white",
  gridcolor = "white"
)
create_canvas <- function(if_square_grid = FALSE, ...) {
  if (if_square_grid == TRUE) {
    square_grid <- list(
      scaleanchor = "x", # 使y轴与x轴的比例尺相同
      scaleratio = 1 # 从而grid为方格
    )
  } else {
    square_grid <- list()
  }

  plot_ly(
    ...,
    width = 800,
    height = 600
  ) %>%
    layout(
      # title = list(
      #   font = list(family = "Times New Roman")
      # ),
      paper_bgcolor = "white",
      plot_bgcolor = "#e5ecf6",
      legend = list(
        bgcolor = "rgba(229,236,246,0)", # 透明度为0，不要遮挡网格
        x = 1, xanchor = "right"
      ),
      xaxis = c(
        axis_template, list(title = list(standoff = 20))
      ),
      yaxis = c(
        axis_template, list(title = list(standoff = 10)),
        square_grid
      )
    )
}

# create_canvas()
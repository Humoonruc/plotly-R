[TOC]

#  Plotly

安装：https://plotly.com/r/getting-started/

官网：https://plotly.com/r/ （每一项都可以点开 “more …”）

基本部件：https://plotly.com/r/plotly-fundamentals/

参数查询：https://plotly.com/r/reference/

## Grammar

在母函数`plot_ly()`中，最好只定义数据(如果图形元素并非来自同一个数据框，那就连数据都不需要定义)、映射、准备被继承的公共元素属性、layout 和 config，**千万不要给出 type 和 mode，否则会自动出现一个 trace0**.

而后在添加具体图层的函数中表明 type 和 mode，如`add_trace()`, `add_markers`, `add_lines()`, `add_text()`, `add_annotations()`

```R
p0 <- plot_ly() %>%
  layout(
    xaxis = list(title = xtitle),
    yaxis = list(title = ytitle)
  ) %>%
  config(mathjax = "cdn")

p <- p0 %>%
  add_markers(
    x = c(1, 2, 3, 4),
    y = c(1, 4, 9, 16)
  )
```



#### Updating figures

https://plotly.com/r/creating-and-updating-figures/

用`add_trace()`及其变体添加内容；用`style(p, marker=…, traces=...)` 更新图中部分 trace 的样式

#### [export plotly figure](./src/export.html)

将 plotly 生成的图保存为外部文件

#### [LaTeX in plotly](./src/LaTeX-in-plotly.html)

含有 $\LaTeX$ 的图，若保存时`selfcontained=FALSE`，则只有在（网络或本地）服务器上，主文件才能访问所需的依赖文件（mathjax），从而正确显示公式。

## Gallery

### Basic Charts

#### [Bar Charts](./src/bar-chart.html)

#### Pie Charts

#### Sunburst Charts

点击可折叠

#### Tables

可拖动列

可以结合 Subplots，做成 Table with Chart，解决排版问题

#### Treemap Charts

### Statistical Charts

#### Regression

https://plotly.com/r/ml-regression/

### Scientific Charts

#### Log Plots

#### Contour Plots

等值线图

#### Heatmaps

#### Network Graph

#### Carpet Plot

#### Polar Charts

#### Display Image Data

https://plotly.com/r/displaying-images/

### Financial Charts

#### Time Series and Date Axes

#### Candlestick Charts

K 线图

### Maps

考虑上 D3.js

#### Filled Area in Mapbox

### 3D Charts

相机设置 https://plotly.com/python/3d-camera-controls/

#### 3D Scatter, Line, Mesh, Cone

#### 3D Surface

#### 3D Tri-Surf Plots

三维模型的表面上色问题

### Subplots

#### 2D Basic Subplots

https://plotly.com/r/subplots/

多张图任意拼在一张图上，涉及共享坐标轴、图例等问题

#### Inset Plots

#### Map Subplots

#### 3D Subplots

#### Mixed Subplots

#### 

### Transforms

#### Filter

#### Group By

#### Aggregations

### 控件

#### Buttons

#### Dropdown Events

#### Range Sliders and Selectors

#### Sliders

### Animations

考虑上比较节省空间的 Plotly.js，甚至 D3.js





## 参数

[可视化神器Plotly(5)---参数详解 - 简书 (jianshu.com)](https://www.jianshu.com/p/4f4daf47cc85)

### plot_ly()

width, height: 设置图形尺寸

### add_trace()

- connectgaps：布尔变量，用于连接缺失数据；
- dx、dy：x、y坐标轴的步进值，默认值是1；
- error_x、error_y：x、y出错信息；
- fillcolor：填充指定区域的颜色；
- fill：设置要填充纯色的区域，默认为none(不填充)，其它设置项如下：

1. **tozerox** 和 **tozeroy** 分别表示填充曲线到x=0和y=0的区域；
2. **tonextx** 和 **tonexty** 分别表示填充曲线到x和y方向上的前一条曲线之间的区域，如果前面没有曲线，则效果同**tozerox** 和 **tozeroy**；
3. **toself** 表示将曲线的各端点连接成闭合的形状；
4. **tonext** 表示将2条曲线各端点均连接成闭合的形状，前提是一条曲线包围另一条曲线；

- hoverinfo：当用户与图表交互时，鼠标指针显示的参数，包括：x、y
  z (坐标轴数据)、text(文字信息)、name(图形名称)等参数的组合，可以使用 **+**、all、none 和 skip作为组合连接符，默认是all(全部消失)；
- hoveron：当用户与图表交互时，鼠标指针显示的模式，共有3种模式：points(点图)、fill(填充图)、points+fill(点图+填充图)；
- ids：在动画图表中，数据点和图形key键的列表参数；
- legendgroup：图例参数，默认是空字符串；
- line：线条参数，包括线条宽度、颜色、格式等，有如下设置项：

1. color：元组，元素为字符串颜色序列，设置对应图表节点的颜色；
2. width：数值，设置线条宽度；
3. dash：线条格式，包括：dash(虚短线)、dot(虚点)、dashdot(短线和点)；
4. shape：进行数据点的插值设置，即根据已有的零散数据点，找到一条满足一定条件的曲线，使之经过全部的数据点。共有6种插值方式：'linear'、'spline'、'hv'、'vh'、'hvh'和'vhv。

- marker：数据节点参数，包括大小、颜色、格式等，有如下设置项：

1. size：列表，元素为相应节点的尺寸大小；
2. sizeref：缩放的比例，如设置为2，则缩小为原来的1/2；
3. sizemode：缩放的标准，默认以**diameter**(直径)缩放，也可选择以**area**(面积)缩放；

- mode：图形格式，包括lines(线形图)、markers(散点图)、text(文本)。使用 **+** 或 none 等符号进行模式组合；
- name：名称参数；
- opacity：透明度参数，取值范围0～1，表示相应节点的透明度；
- rsrc、xsrc、ysrc、tsrc、idssrc、textsrc、textpositionsrc：字符串源数组列表，作为Plotly网格标识符，用于设置特殊图表所需的r参数、x参数、y参数、t参数、ids参数、text(文本)参数、textposition(文本位置)参数等；
- r、t：仅用于极坐标图，r用于设置径向坐标(半径)；t用于设置角坐标；
- showlegend：布尔变量，默认True，设置显示图例名称。仅一条数据时，需要显式地声明才会显示图例；
- showscale：布尔变量，设置是否显示颜色跟踪条，默认为False；
- stream：数据流，用于实时显示数据图表；
- textfont：文本字体参数，包括字体名称、颜色、大小等；
- textposition：“文本”元素的位置参数，包括：top left(左上)、top center(中上)、top right(右上)、middle  left(左中)、middle center(中心)、middle   right(右中)、bottom left(左下)、bottom center(中下)、bottom right(右下)模式，默认是middle center(中心)模式；
- text：文本数据，元素为相应节点的悬浮文字内容；
- type：数据显示模式，包括：constant(常数)、percent(百分比)、sqrt(平方根)、array(数组)模式；
- x0、y0：坐标轴起点坐标；
- xcalendar、ycalendar：坐标时间参数的格式，默认是公历；
- x，y：设置x、y轴的坐标数据；

### layout()

#### title

设置图表的标题，如下配置项

1. text：字符串，标题内容；
   1. 设置标题的标准写法是`title = list(text = "...")`，**若写为`title = "..."`，则会将之前设置的标题其他属性覆盖为默认值**！ 

2. font：设置标题字体。包含：字体、颜色、大小等；
3. x、y：取值0～1之间，设置在标准化坐标中位置，0.5为居中；
4. xanchor：设置标题相对于x位置的水平对齐方式，有如下取值："auto" | "left" | "center" | "right" ；
5. yanchor：设置标题相对于y位置的垂直对齐方式，有如下取值："auto" | "top" | "middle" | "bottom" ；
6. pad：设置标题的填充。

#### legend

设置图例的字体、颜色、位置等，包括如下设置项：

1. x, y, xanchor, yanchor: 图例在坐标系内的位置
2. bordercolor：设置图例外边框颜色；
3. borderwidth：设置图例外边框的线条宽度；

#### margins

设置 图表的页面边距。1) 主要的4个参数：1、r、t、b，分别对应：左右上下，除了上(t)默认值为100，其它默认值均为80；2) pad：设置绘图区域和轴线之间的填充量，默认值为0；3) autoexpand：布尔型，表示是否默认自动；

#### colors

- paper_bgcolor, 背景颜色。默认值："#fff" ；

- plot_bgcolor, 设置x轴和y轴之间的绘图区域的颜色。默认值："#fff" ；
- colorway, 给 traces 赋颜色向量

#### dragmode

设置拖动交互的模式，默认为"zoom" ，包括： "zoom" | "pan" | "select" | "lasso" | "orbit" | "turntable" | False。“select”和“lasso”仅适用于使用标记或文本散布痕迹。“轨道”和“转盘”仅适用于3D场景；

#### xaxis, yaxis

https://plotly.com/r/axes/

https://plotly.com/r/multiple-axes/

设置x、y 坐标轴参数，包括如下设置项：

1. title：设置坐标轴的标题，包括标题内容、字体、颜色、大小等；
   1. 设置坐标轴标题的标准写法是`xaxis = list(title = list(text = "..."))`，**若写为`xaxis = list(title = "...")`，则会将之前设置的坐标轴其他属性覆盖为默认值**！ 

2. tickformat：设置刻度线标签格式，如：**','** 可以显示千分位标示；**'YYYY-MM-DD'**可以将日期格式化为类似 **2019-01-01**；
3. ticksuffix：设置刻度标签后缀字符串；
4. tickprefix：设置刻度标签前缀字符串；
5. type：设置轴类型。默认情况下('-')，通过查看引用相关轴的迹线数据，尝试确定轴类型，有如下取值："-" | "linear" | "log" | "date" | "category" | "multicategory"
6. showline：布尔值，确定是否显示坐标轴直线；
7. zeroline : 布尔值，确定是否在该轴的0值处绘制垂直的直线；
8. linecolor：坐标轴线的颜色；
9. linewidth：坐标轴线的宽度；
10. range：列表，设置坐标轴的取值范围；
11. overlaying：设置相同的坐标轴id(双坐标)；
12. rangemode：根据输入数据的极值计算范围。默认为"normal"，取值为“tozero”`，则范围扩展为0，无论输入数据是否为“非负”，无论输入数据如何，范围都是非负的。目前笔者用到过的场景：双Y坐标轴时，实现Y轴的0刻度线对齐；
13. side：设置坐标轴在绘图区域的位置，共4个取值：top、bottom(默认)、left、right；
14. autotick：布尔变量，是否删除部分日期，False为保持原状；
15. ticks：是否绘制刻度线，包括：outside(外部)、inside(内部)，默认为空(' ')，不显示刻度线；
16. ticklen：设置刻度线长度，默认为5；
17. tickwidth：设置刻度线宽度，默认为1；
18. tickcolor：设置刻度线颜色，默认值："#444" ；
19. tickfont：设置刻度线标签字体，包括字体、颜色、大小；
20. nticks：设置坐标轴的最大刻度个数；
21. showticklabels：布尔变量，默认为True，确定是否绘制刻度标签；
22. showgrid：布尔值，确定是否绘制网格线。如果为“True”，则在每个刻度线处绘制网格线；
23. gridcolor：设置网格线的颜色；
24. gridwidth：设置网格线的宽度；
25. rangeslider：设置滑动条，有如下设置项：
    1）bgcolor：设置滑动条的背景颜色，默认值："#fff" ；
    2）bordercolor：设置滑动条的边框颜色，默认值："#444" ；
    3）borderwidth：设置滑动条的边框宽度，默认无；
    4）autorange：布尔值，设置是否根据输入数据计算滑动条的范围。如果提供 `range`，则 `autorange`设置为“False”；
    5）range：列表，设置滑动条的范围。如果未设置，则默认为完整的x轴范围。如果轴 `type`是“log”，则必须设置范围；如果轴 `type`是“date”，则它应该是日期字符串或日期数据，Plotly对时间序列的支持比较友好，既支持字符串格式，又支持日期/时间格式；如果轴“type”是“ category”，它应该是数字或比例，其中每个类别按其出现的顺序从零开始分配序列号；
    6）thickness：设置滑动条的高度，作为总绘图区域高度的一部分，默认值：0.15 ；
    7）visible：布尔值，默认为True，设置滑动条是否可见；
    8）y：设置滑动条的轴范围是否与主图中的值相同；
26. rangeslider：设置范围选择按钮，有如下设置项：
    1）visible：设置范围选择按钮是否可见。特别说明：范围选择按钮仅适用于数据为date或设置“type”为“date”的x轴；
    2）buttons：设置按钮，有如下设置项：
    `a、` visible：布尔值，设置此按钮是否可见，默认为True；
    `b、` step：设置按钮的时间单位，默认为"month" ，包括如下取值："month" | "year" | "day" | "hour" | "minute" | "second" | "all" ；
    `c、` count：数值，默认为1，用于设置按钮时间单位的数量，与 `step`一起使用，指定该按钮的时间筛选范围；
    `d、` stepmode：设置时间范围的更新模式，默认为"backward"，按则开始位置为“计数”乘以“步”，若设置为"todate" ，则开始位置返回当年的开始日期；
    `e、` label：设置按钮上显示的文本内容；
    3）x、y：取值0～1之间，设置在标准化坐标中位置，0.5为居中；
    4）xanchor：设置标题相对于x位置的水平对齐方式，有如下取值："auto" | "left" | "center" | "right" ；
    5）yanchor：设置标题相对于y位置的垂直对齐方式，有如下取值："auto" | "top" | "middle" | "bottom" ；
    6）font：设置标题字体。包含：字体、颜色、大小等；
    7）bgcolor：设置范围选择按钮的背景颜色，默认值："#eee" ；
    8）bordercolor：设置范围选择按钮的边框颜色，默认值："#444" ；
    9）borderwidth：设置范围选择按钮的边框宽度，默认无；

#### shapes

https://plotly.com/r/shapes/

https://plotly.com/r/reference/#layout-shapes

在图的任意位置加入作为标注的几何图形，包括 rect, circle, line, path 等

还可以用`hline()`, `vline()`加入垂直和水平参考线

#### images

https://plotly.com/r/images/

背景图片或logo

### config()

https://plotly.com/r/configuration-options/

scrollZoom, 是否可滚动缩放

responsive, 是否自动响应设备尺寸

staticPlot, 是否自动显示静态图片

displayModeBar, 是否一直显示/永不显示交互栏

displaylogo, 是否在交互栏上显示 plotly 的 logo

toImageButtonOptions, 对下载静态图片进行设置

locale, 设置本地（语言、日期等）格式



## Turn ggplot2 to plotly

`ggplotly()`可以将ggplot2图对象转化为 plotly 图对象，然后使用plotly的API操作


## Animation


动画属性文档: https://github.com/plotly/plotly.js/blob/master/src/plots/animation_attributes.js

button 属性文档: https://github.com/plotly/plotly.js/blob/master/src/components/updatemenus/attributes.js

slider 属性文档: https://github.com/plotly/plotly.js/blob/master/src/components/sliders/attributes.js

```{r}
x <- rnorm(100) %>% sort()
y <- 0.5 * x + rnorm(100, sd = 0.1)

dt <- data.table(
  x = x,
  y = y,
  f = 1:1000
)

animation <- plot_ly(
  data = dt,
  x = ~x,
  y = ~y,
  type = "scatter",
  mode = "markers",
  marker = list(color = "lightgrey", opacity = 0.5)
) %>%
  add_trace(
    x = ~x,
    y = ~y,
    frame = ~f, # frame 为滑动条
    type = "scatter",
    mode = "markers",
    showlegend = F,
    marker = list(color = "red")
  ) %>%
  std_animate()

animation %>%
  saveWidget("./animation/demo.html",
             selfcontained = F,
             libdir = "lib")

animation
```

```{r}
animation <- gapminder::gapminder %>%
  plot_ly(
    x = ~gdpPercap,
    y = ~lifeExp,
    size = ~pop,
    color = ~continent,
    frame = ~year,
    text = ~country,
    hoverinfo = "text", # 鼠标悬停时只显示国名
    type = "scatter",
    mode = "markers"
  ) %>%
  layout(
    # x轴改为对数坐标
    xaxis = list(type = "log")
  ) %>%
  std_animate()

animation %>%
  saveWidget("./animation/动态气泡图.html", selfcontained = F, libdir = "lib")

animation
```


```{r echo=FALSE}
# 允许用户从页面下载文件
xfun::embed_file("./animation/动态气泡图.zip", text = "下载该 htmlwidget 以嵌入目标网页")
```

## 保存与嵌入

### 保存为静态文件

首先要安装依赖的 python 库 kaleido，以下为安装方法：

```R
install.packages('reticulate')
reticulate::install_miniconda()
reticulate::conda_install('r-reticulate', 'python-kaleido')
reticulate::conda_install('r-reticulate', 'plotly', channel = 'plotly')
reticulate::use_miniconda('r-reticulate')
```

安装完毕后调用`reticulate::py_config()`检查python的路径是否为刚刚安装的 r-miniconda 版本。

> 两个路径的对比：
>
> C:/Users/Humoonruc/AppData/Local/r-miniconda/envs/r-reticulate/python.exe
>
>
> C:/Users/Humoonruc/AppData/Local/Programs/Python/Python310/python.exe

如果不是，就在项目根目录加入一个 .Renviron 文件，里面写入一行

```
RETICULATE_PYTHON="C:/Users/.../AppData/Local/r-miniconda/envs/r-reticulate/python.exe"
```

重启 Rstudio，在 Options 中手动修改 Python Interpreter 的路径。

<img src="img/image-20220324125205045.png" alt="image-20220324125205045" style="zoom: 67%;" />

<img src="img/image-20220324125318689.png" alt="image-20220324125318689" style="zoom:67%;" />

直到通过`reticulate::py_config()`检查，才能调用`plotly::save_image(p, file, ..., width = NULL, height = NULL, scale = NULL)`，将 plotly 生成的图保存为静态文件，类型包括 png, jpg, jpeg, webp, svg, pdf

```R
save_image(p, file = "./figure/export-png.png", width = 800, height = 600)
save_image(p, file = "./figure/export-svg.svg", width = 600, height = 600)
save_image(p, file = "./figure/export-pdf.pdf")
```

**注意**：上述安装和调用`plotly::save_image()`都必须在 Rstudio 中进行，在 VSCode 中会由于 python 版本不匹配而无法使用（因为 VSCode 中的 R 解释器 radian 是安装在之前 python 版本之内的）。

### 保存为.html并嵌入网页

plotly 生成的图其实都是 htmlwidget，用 HTML5 的`<iframe></iframe>`标签即可直接嵌入到任何网页中，使用起来极其方便。

#### 保存为独立的 .html

这种情况将图形所依赖的各种 css 文件和 js 文件都嵌入到了 html 文件内部，因此 html 的 size 往往会很大，不利于网络传播。好处则是，即使在本地打开，也能完整显示，不存在浏览器拒绝访问本地文件的问题。

```{r}
p <- plot_ly(x = 1:10, y = 1:10) %>% add_markers()
htmlwidgets::saveWidget(p, "./figure/self-contain.html", selfcontained = T)
```

#### 保存为 .html 及其依赖文件

分开保存图形和依赖文件，因为**依赖文件往往都是很多图共用的**。

由于浏览器会阻止本地文件的读取，所以依赖文件比较复杂时，本地打开可能显示不完整，要在 vscode 中通过构建本地服务器来打开。

```{r}
p <- plot_ly(x = rnorm(100))
htmlwidgets::saveWidget(p, "./figure/Not-self-contain.html", selfcontained = F, libdir = "lib") # 依赖文件夹只写名字即可，其路径会自动跟随html文件，放在同一目录中
```

#### 嵌入网页

在嵌入页面用 `<iframe>` 标签引入即可

```{html}
<iframe src="./animation/动态气泡图.html" frameborder="0" width="600px" height="400px"></iframe>
```

注：Rmarkdown 中用`<iframe>`语法似乎无效，但直接打印 plotly 图像（`print(p)`或直接`p`），即可使之出现在最终导出的 html 中。

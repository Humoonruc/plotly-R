[TOC]



#  Notes of R plotly

安装：https://plotly.com/r/getting-started/

官网：https://plotly.com/r/ （每一项都可以点开 “more …”）

基本部件：https://plotly.com/r/plotly-fundamentals/

参数查询：https://plotly.com/r/reference/

一些可能会用到的官方数据：[plotly/datasets: Datasets used in Plotly examples and documentation (github.com)](https://github.com/plotly/datasets)

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

demo: https://plotly.com/r/creating-and-updating-figures/

- `add_trace()`及其变体添加数据

- `style(p, marker=…, traces=...)` 更新图中部分 trace 的样式

- `images()`,[update background layout images](https://plotly.com/r/displaying-images/)
- `annotations()`, [update annotations](https://plotly.com/r/text-and-annotations/)
- `shapes()`, [update shapes](https://plotly.com/r/shapes/)

但它们都不能更新 trace 中的数据，只有 Plotly.js 提供的 `Plotly.animate()` 可以做到

#### export plotly figure

[export.Rmd](./src/export.html)

将 plotly 生成的图保存为外部文件

#### LaTeX in plotly

<a href='./src/LaTeX-in-plotly.html'><img src='./figure/LaTeX-in-plotly.svg'></a>

含有 $\LaTeX$ 的图，若保存时`selfcontained=FALSE`，则只有在（网络或本地）服务器上，主文件才能访问所需的依赖文件（mathjax），从而正确显示公式。

#### Multiple Axes

第二个y轴，用`layout()`中的`yaxis2=list(overlaying="y",  side="right"…)` 属性来设置，其数据在`add_trace()`中添加并写明 `yaxis = "y2"`

https://plotly.com/r/multiple-axes/

#### Colorway

设置多个 trace 的颜色

```R
layout(colorway = c('#f3cec9', '#e7a4b6', '#cd7eaf', '#a262a9', '#6f4d96', '#3d3b72', '#182844'))
```





## Gallery

### Basic Charts

#### Bar Charts

<a href='./src/bar-chart.html'><img src='./figure/bar-chart.svg'></a>

#### Pie Charts

#### Sunburst Charts

点击可折叠子级块

#### Tables

<a href='./src/table.html'><img src='./figure/table.svg'></a>

可拖动列

可以结合 Subplots，做成 Table with Chart，解决排版问题

#### Treemap Charts



### Statistical Charts

#### Regression

<a href='./src/regression.html'><img src='./figure/regression.svg'></a>

more demo: https://plotly.com/r/ml-regression/

### Scientific Charts

#### Log Plots

#### Contour Plots

等值线图

#### Heatmaps

#### Network Graph

#### Carpet Plot

#### Polar Charts

#### Display Image Data

more demo: https://plotly.com/r/displaying-images/

### Financial Charts

#### Time Series and Date Axes

#### Candlestick Charts

K 线图

### Maps

鉴于地图的标准格式为 GeoJson 和 TopoJson，还是考虑直接上 D3.js

### 3D Charts

相机设置 https://plotly.com/python/3d-camera-controls/

#### 3D Scatter, Line

#### 3D Cone

#### 3D Surface

#### 3D Mesh

3D 模型的表面都是三角面。plotly 中的格式为：(x, y, z) 表示点的坐标，(i, j, k) 表示三角面的三个顶点的 index



### Subplots

#### 2D Basic Subplots

more demo: https://plotly.com/r/subplots/

多张图任意拼在一张图上，涉及共享坐标轴、图例等问题

#### Inset Plots

https://plotly.com/r/insets/

#### Map Subplots

#### 3D Subplots

#### Mixed Subplots

https://plotly.com/r/mixed-subplots/

### Transforms

#### Filter

#### Group By

#### Aggregations

### 控件

`updatemenu()`

- restyle(): modify data or data attributes
- relayout(): modify layout attributes
- update(): modify data and layout attributes
- animate():start or pause an animation (only available offline)

R plotly 中的切换都是突兀的，不像 plotly.js 一样由中间帧和动画效果

#### Buttons and Dropdown Events

都是预先画好的内容，主要是用按钮点击切换图层和渲染的 style

https://plotly.com/r/custom-buttons/

https://plotly.com/r/dropdowns/

#### Range Sliders and Selectors

选取一定范围的数据，同时会改变坐标轴的 range

https://plotly.com/r/range-slider/

https://plotly.com/r/sliders/



### Animations

2D 和 3D 图均可制作动画。

制作动画有两种思路：

1. 为数据框单独设置一个时间轴变量，每帧只显示部分数据，这是`R plotly`使用的方式。这造成数据量非常大，而且必须提前计算好，使用起来不够灵活——但也不是不能做。
   1. 比如平面上一个旋转过程，必须给出所有中间角度的变换矩阵，计算出过程中每一帧的坐标，组成一个大数据框，并将 frame 映射为时间。
2. 间隔一定时间，在原图上实时更新数据，这是`plotly.js`经常使用的方式。
   1. 动画属性文档: https://github.com/plotly/plotly.js/blob/master/src/plots/animation_attributes.js
   2. button 属性文档: https://github.com/plotly/plotly.js/blob/master/src/components/updatemenus/attributes.js
   3. slider 属性文档: https://github.com/plotly/plotly.js/blob/master/src/components/sliders/attributes.js

#### Basic and Cumulative Animations

<a href='./src/animation.html'><img src='./figure/animation/gapminder.svg'></a>

`animation_opts()`设置动画属性，`frame`设置两帧之间的时间（毫秒），`transition`设置平滑动画的时间，`easing`设置插值的方式，`redraw`设为 F 可以提高性能

```R
animation_opts(
  p,
  frame = 500,
  transition = frame,
  easing = "linear",
  redraw = TRUE,
  mode = "immediate" # 若有其他指令（如演示时用户的交互行为），立即停止播放响应要求
)
```

`animation_slider()`设置时间轴，`hide = FALSE`可以将其隐藏

```R
animation_slider(
  hide = FALSE, # 是否隐藏动画进度条
  currentvalue = list(
    ## prefix = "YEAR: ",
    font = list(color = "red")
  )
)
```

`animation_button()`设置开启动画的按钮，`label`属性可设置其上的文字

```R
    animation_button(
      visible = TRUE,
      type = "buttons", # 触发器是下拉菜单式 dropdown 还是按钮式 buttons
      # direction = "up", # 若为 dropdown，菜单出现在触发器的哪个方向 up/down/left/right
      x = 1.05, xanchor = "left",
      y = 0, yanchor = "top",
      label = "Run"
    )
```





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
   1. text 中可以加入`<b></b>`等 html 标签设置文本样式
   
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



## Turn ggplot2 to plotly

`ggplotly()`可以将ggplot2图对象转化为 plotly 图对象，然后使用plotly的API操作



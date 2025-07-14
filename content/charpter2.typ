#import "../lib.typ": *


= ElegantTypstBook 设置说明

== 参数总览

- `media` (string): 输出介质，可选 `"pad"` 或 `"normal"`，决定排版用纸尺寸与配色方案。默认 `"normal"`。
- `theme` (string): 主题色调，可选 `"light"` 或 `"dark"`。影响整体背景与文字基色。默认 `"light"`。
- `size` (length): 正文字号。可写 `pt` / `mm` / `em` 等单位。默认 `11pt`。
- `pad-size` (length): 针对投屏/网页阅读的字号；未显式设置时沿用 `size`。默认 `11pt`。
- `title` (string | none): 文档主标题，用于封面、页眉与 PDF 元数据。默认 `none`。
- `short-title` (string | none): 短标题，出现在页眉与目录；缺省时回退到 `title`。默认 `none`。
- `description` (string | none): 摘要/副标题，可填入一句话简介。默认 `none`。
- `authors` (array): 作者列表。每项为字典，如 `(name, github?, homepage?, affiliations)`。默认空数组 `()`。
- `affiliations` (array): 机构对照表，每项形如 `(id, name)`，供作者用 `id` 引用。默认空数组 `()`。
- `semester` (string | none): 学期信息（如 “2025 春”），常见于课堂报告模板。默认 `none`。
- `date` (datetime | none): 创建日期，典型写法 `datetime(year: 2025, month: 7, day: 14)`。默认 `none`。
- `bibliography-file` (string | none): BibTeX/CSL JSON 路径；为空则禁用引用与参考文献。默认 `none`。
- `bibstyle` (string): 引用与文献样式 ID，例如 `"gb-7714-2015-numeric"`, `"apa"`。默认 `"gb-7714-2015-numeric"`。
- `paper-size` (string): 纸张尺寸，仅 `media: "normal"` 时生效，如 `"a4"`、`"letter"`。默认 `"a4"`。
- `color` (color): 主题强调色 (HEX/CSS 名/色关键字)。用于一级标题、表格线与 `strong` 高亮。默认 `"#000000"`。
- `font` (object): 字体族配置。可指定 `main`、`mono`、`cjk`、`math`、`math-cjk` 等子字段；缺省为 `default-font`。
- `lang` (string): 主要语言代码，影响分词、连字符、标点。默认 `"zh"`。
- `region` (string): 地区代码，用于细化本地化规则。默认 `"cn"`。
- `first-line-indent` (object): 段首缩进设置 `{amount, all}`；`all` 为 `true` 时连首段也缩进。默认 `{0pt, false}`。
- `maketitle` (bool): 是否自动生成封面页。默认 `false`。
- `makeoutline` (bool): 是否自动插入目录。默认 `false`。
- `outline-depth` (int): 目录层级深度，`2` 表示到 `subsection`。默认 `2`。
- `cover-image` (string | none): 封面背景图文件路径或 `none`。默认 `none`。
- `background-color` (color | none): 正文背景色，建议仅在 `theme: "light"` 下使用。默认 `none`。
- `body` (content): 文档的内容。
== 设备选项
如果在 iPad 上看无需切边，放大你可以使用下面的选项将版面设置为 `pad`模式： \
`media` (string): 输出介质，可选 `"pad"` 或 `"normal"`，决定排版用纸尺寸与配色方案。默认 `"normal"`。
== 颜色主题
你可以配置 `color` 为颜色主题，可选参数有 `orange` `blue` `olive` `red` `eastern` `yellow` `navy`
此颜色用于一级标题、表格线与 `strong` 高亮//TODO 颜色主题表格更新
== 封面
// === 封面个性化
// === 封面图
// === 徽标
// === 自定义封面
封面内容暂不更新
== 编号
=== 章标标题
本模板内置 2 套章标题显示风格，包含 hang（默认）与 display 两种风格，区别在于章标题单行显示（hang）
与双行显示（display），本说明使用了 hang。调用方式为
```typ
```
在章标题内，章节编号默认是以数字显示，也即第 1 章，第 2 章等等，如果想要把数字改为中文，可以使用
```typ
```
可以使用 `numbly` 包设置标题编号样式：

```typ
#set heading(numbering: numbly("{1:一}、", default: "1.1  "))
```

参数中，`{*:1}` 的 `*` 代表标题的级别，`1` 代表标题的格式。`{1:一}、` 代表一级标题的格式为 `一、`，并且设置了默认格式 `1.1  `。

*注意*，本模板默认去除了标题 numbering 后的空格，所以在设置标题编号时请注意空格的使用。如 `"1.1  "` 的末尾有两个空格，这样在标题编号后会有两个空格。
=== 数学公式编号

为每个行间公式设置了公式编号，样式为 (a.b) ，其中a为章节号，b为该章公式序号
#theorem(title: "傅立叶级数的复数形式")[
  $f(x)$ 周期为 $2l$ ，且在每个周期内分段单调且有界（或者分段可导），则有
  $ f(x) tilde.eq sum_(n=-oo)^(+oo) F_n e^(i (n pi)/l x) $
  $ F_n= 1/(2l) integral_(-l)^l f(x) e^(-i (n pi)/l x) #text[数学公式中文字插入示例] $
  第一个式子不是等号，因为在间断点处级数收敛到间断点两断的平均值
]
数学公式中文字插入示例$ #text[情况a，b,c] cases(#text[方式一：测试文字], #text[方式二：测试文字?测试、顿号，逗号：冒号]) $
== 图像编号
惠更斯原理的表述：设 $S$ 为波源，在 $t$ 时刻由振源发处的波振动传播到了面 $Sigma$ 上，#highlight()[我们认为 S 上的每一面元都可以看作次波的波源]，由各个面元发出的次波将在 $t^prime$ 时刻形成一个新的次波面，这些次波面的包络面 $Sigma^prime$ 就是 $t^prime$ 时刻的波面。@zhaooptics2021
#grid(
  columns: (50%, 1fr),
  // 第一列50%宽度，第二列自动填充剩余空间
  gutter: 1em,
  // 列间距
  [
    #figure(image("../figures/prob1.svg", width: 80%, format: auto), caption: "惠更斯原理的示意图         ")
  ],
  [
    #figure(
      image("../figures/prob1-2.svg", width: 100%, format: auto),
      caption: "惠更斯原理的示意图",
    )
  ],
)
#important-box[你需要在`image` 中传入`format:auto`才能使得`dark`模式下自动添加底色]
== 数学环境简介
在我们这个模板中，我们定义了两种不同的定理模式 mode，包括简单模式（simple）和炫彩模式（fancy），
默认为 fancy 模式，不同模式的选择为
=== 定理类环境的使用

==== 定理目录
#outline(title: none, target: figure.where(kind: "theorem"))
==== 基本定理环境
基于 #link("https://github.com/OrangeX4/typst-theorion")[*Theorion 包*]，我们可以创建@def:prime 、@thm:euclid 、@lemma  和@proposition  等定理环境。
#definition[
  A natural number is called a #highlight[_prime number_] if it is greater than 1
  and cannot be written as the product of two smaller natural numbers.
] <def:prime>

#definition[123]

#example[
  The numbers $2$, $3$, and $17$ are prime. As proven in @cor:infinite-prime,
  this list is far from complete! See @thm:euclid for the full proof.
] <example>

#proof[
  By contradiction: Suppose $p_1, p_2, dots, p_n$ is a finite enumeration of all primes.
  Let $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,
  it cannot be prime. Thus, some prime $p_j$ divides $P + 1$.
  Since $p_j$ also divides $P$, it must divide their difference $(P + 1) - P = 1$,
  a contradiction.
]

#corollary[
  There is no largest prime number.
] <cor:infinite-prime>

#theorem(title: "Euclid's Theorem")[
  There are infinitely many prime numbers.
] <thm:euclid>

#lemma[
  引理内容。
] <lemma>

#proposition[
  命题内容。
] <proposition>

#emph-box[
  强调内容。
]

#quote-box[
  引用内容。
]

#remark[
  注解内容。
]

#note-box[
  在快速浏览时也应该注意的重要信息。
]

#tip-box[
  帮助更好使用的可选建议信息。
]

#important-box[
  为了成功使用必须了解的关键信息。
]

#warning-box[
  可能存在风险，需要立即注意的关键信息。
]

#caution-box[
  可能带来负面后果的提醒信息。
]
==== fancy 模式
==== simple 模式
==== 修改计数器
==== 自定义定理类环境

=== 三线表

基于 #link("https://github.com/OrangeX4/typst-tablem")[*Tablem 包*]，提供了简单好用的三线表功能，如@three-line-table。



```typ
#figure(
  three-line-table[
    | Substance             | Subcritical °C | Supercritical °C |
    | --------------------- | -------------- | ---------------- |
    | Hydrochloric Acid     | 12.0           | 92.1             |
    | Sodium Myreth Sulfate | 16.6           | 104              |
    | Potassium Hydroxide   | 24.7           | <                |
  ],
  caption: "三线表示例"
) <three-line-table>
```

#figure(
  three-line-table[
    | Substance             | Subcritical °C | Supercritical °C |
    | --------------------- | -------------- | ---------------- |
    | Hydrochloric Acid     | 12.0           | 92.1             |
    | Sodium Myreth Sulfate | 16.6           | 104              |
    | Potassium Hydroxide   | 24.7           | <                |
  ],
  caption: "三线表示例",
) <three-line-table>

=== Markdown 渲染



基于 #link("https://github.com/SabrinaJewson/cmarker.typ")[*Cmarker 包*] 和 #link("https://github.com/mitex-rs/mitex")[*MiTeX 包*]，支持 Markdown 渲染，包括数学公式，如：

`````typ
#md(````markdown
  支持 **加粗**、*斜体*、~~删除线~~、[链接](https://typst.com)、LaTeX 数学公式 $\max_{x \in X} f(x)$ 等 Markdown 语法。
````)
`````

#rect(
  width: 100%,
  md(
    ````markdown
      支持 **加粗**、*斜体*、~~删除线~~、[链接](https://typst.com)、LaTeX 数学公式 $\max_{x \in X} f(x)$ 等 Markdown 语法。
    ````,
  ),
)

== 列表环境
本模板定制了有序列表和无序列表，示例如下
#grid(
  columns: (50%, 2fr),
  gutter: 0em,
  // 列间距
  [
    - first item of nesti;
      - second item of nesti;
        - first item of nestii;
        - second item of nestii;
          - first item of nestiii;
          - second item of nestiii.
  ],
  [
    + first item of nesti;
      + second item of nesti;
        + first item of nestii;
        + second item of nestii;
          + first item of nestiii;
          + second item of nestiii.
  ],
)

== 参考文献
=== 打印文献
=== 修改文献格式
== 添加序章
如果你想在第一章前面添序章，不改变原本章节序号，可以在第一章内容前面使用
```typ
```
//TODO 序章功能
== 目录选项与深度
== 章节摘要
模板新增了一个章节摘要环境（introduction），使用示例
```typ
```
效果如下：
环境的标题文字可以通过这个环境的可选参数进行修改，修改方法为：
```typ
```
//TODO 章节摘要功能
== 章后习题
前面我们介绍了例题和练习两个环境，这里我们再加一个，章后习题（problemset）环境，用于在每一章
结尾，显示本章的练习。使用方法如下
```typ
```
效果如下：
```typ
```

== 旁注
使用marginpar=margintrue 获得保留右侧旁注的版面设计
在使用旁注的时候，需要注意的是，文本和公式可以直接在旁注中使用。\
待更新

= 字体选项
字体选项独立成章的原因是，我们希望本模板的用户关心模板使用的字体，知晓自己使用的字体以及遇到字体相关的问题能更加便捷地找到答案。

先在终端 / 命令行输入 ```bash typst fonts``` 查看当前可用的字体，以在文档开头加入 `font` 参数修改字体设置以及使用的字体：

```typ
#let font = (
  main: "IBM Plex Sans",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif SC",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)

#show: ori.with(
  // ... 保持原有的参数
  font: font,
)
```

== 数学字体选项
== 使用 newtx 系列字体
=== 连字符
=== 宏包冲突
== 中文字体选项
提供中文字体选项 `chinesefont`，可选项有
+ ctexfont：默认选项，使用 ctex 宏包根据系统自行选择字体，可能存在字体缺失的问题，更多内容参考
ctex 宏包官方文档1。
+ founder：方正字体选项（需要安装方正字体），后台调用 ctex 宏包并且使用 fontset=none 选项，然后设
置字体为方正四款免费字体，方正字体下载注意事项见后文，用户只需要安装方正字体即可使用该选项。
+ nofont：后台会调用 ctex 宏包并且使用 fontset=none 选项，不设定中文字体，用户可以自行设置中文字体，具体见后文。
//TODO 字体设置待更新
=== 方正字体选项
typst会默认调用系统已有的字体，部分系统字体缺失严重，因此，用户希望能够使用其它字体，
我们推荐使用方正字体。方正的方正书宋、方正黑体、方正楷体、方正仿宋四款字体均可免费试用，且可用于商
业用途。用户可以自行从方正字体官网下载此四款字体，在下载的时候请务必注意选择 GBK 字符集，也可以使
用 LATEX 工作室提供的方正字体，提取码为：njy9 进行安装。安装时，Win 10 用户请右键选择为全部用户安装，
否则会找不到字体。
=== 其他中文字体
如果你想完全自定义字体2，你可以选择 `chinesefont=nofont`，然后在导言区设置
```typ
```




= 其他宏包设置
== `unify` 单位包使用方法简介


== `pinit` 脚注包使用方法
=== 强调
在此放置脚注` #pin("h1")` #pin("h1")，可以强调此内容。#pin("h2") ` #pin("h2")`在此放置第二个脚注，然后在之后写`#pinit-highlight("h1","h2")` 即可
#pinit-highlight("h1", "h2")




=== 画线
在此放置脚注` #pin("l1")` #pin("l1") ，可以画线。 \ #pin("l2") ` #pin("l1")`在此放置第二个脚注
然后在之后写\
`#pinit-line(stroke: 2pt + red, start-dy: -0.25em, end-dy: -0.25em, "l1", "l2")` 即可
#pinit-line(stroke: 2pt + red, start-dy: -0.25em, end-dy: -0.25em, "l1", "l2")

=== 脚注
这是一个问题？#pin("que")这是答案#pin("ans")，使用`#pinit-point-to()[]`和`#pinit-point-from()[]`即可
#pinit-point-to("que", fill: red, redbold[问题])

#pinit-point-from("ans", body-dx: +10pt)[
  答案
]
#linebreak()
=== 框
在此放置脚注` #pin("r1")` #pin("r1") 可以画框。  #pin("r2") ` #pin("r1")`在此放置第二个脚注\ 然后在之后写`#pinit-rect("r1","r2")` 即可
#pinit-rect("r1", "r2")

= ElegantTypstBook 写作示例
= 常见问题集
= 版本更新历史












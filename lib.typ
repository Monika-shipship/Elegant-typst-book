#import "@preview/numbly:0.1.0": numbly
#import "@preview/unify:0.7.1": * // 单位
#import "@preview/pinit:0.2.2": * // 相对脚注
#import "@preview/cetz:0.4.0": * // 绘图
#import "@preview/fletcher:0.5.8": * // 优雅的箭头
#import "@preview/tablem:0.2.0": tablem, three-line-table // markdown-like tables
#import "@preview/cheq:0.2.2": * // markdown-like checklist
#import "@preview/zero:0.3.3": * // 科学数字表示法
#import "@preview/showybox:2.0.4": showybox
#import "@preview/ctheorems:1.1.3": *
#import "@preview/zebraw:0.5.5": * // 代码块
#import "@preview/physica:0.9.5": * // 物理专用数学公式
#import "@preview/mitex:0.2.5": * // 输出tex代码
#import "@preview/cmarker:0.1.5": render as cmarker-render
#import "@preview/theorion:0.3.3": *
// theorion公式相关设置
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *

#let md = cmarker-render.with(math: mitex)
//字体字典
#let default-font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif SC",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)

// ElegantBook 风格字体配置（基于 LaTeX ElegantBook 的真实字体设置）
#let elegantbook-font = (
  main: ("Times New Roman", "SimSun"), // 英文主字体：Times New Roman + 中文宋体
  sans: ("Arial", "SimHei"), // 无衬线字体：Arial + 中文黑体
  mono: ("Courier New", "SimSun"), // 等宽字体：Courier New + 中文宋体
  cjk: "SimSun", // 中文正文：宋体
  cjk-sans: "SimHei", // 中文粗体/标题：黑体
  cjk-title: "SimHei", // 中文一级标题专用：黑体
  emph-cjk: "KaiTi", // 中文斜体：楷体
  math: ("New Computer Modern Math", "Cambria Math", "Times New Roman"), // 数学字体
  math-cjk: "SimSun", // 数学中文字体：宋体
)

// 字体风格字典
#let font-styles = (
  ori: default-font,
  elegantbook: elegantbook-font,
)
//颜色字典
#let palettes = (
  green: (
    structure: rgb(0, 120, 2),
    main: rgb(0, 120, 2),
    second: rgb(230, 90, 7),
    third: rgb(0, 160, 152),
  ),
  cyan: (
    structure: rgb(31, 186, 190),
    main: rgb(59, 180, 5),
    second: rgb(175, 153, 8),
    third: rgb(244, 105, 102),
  ),
  blue: (
    structure: rgb(60, 113, 183),
    main: rgb(0, 166, 82),
    second: rgb(255, 134, 24),
    third: rgb(0, 174, 247),
  ),
  gray: (
    structure: rgb(150, 150, 150),
    main: rgb(150, 150, 150),
    second: rgb(150, 150, 150),
    third: rgb(150, 150, 150),
  ),
  black: (structure: rgb(0, 0, 0), main: rgb(0, 0, 0), second: rgb(0, 0, 0), third: rgb(0, 0, 0)),
)



// 主题自适应的代码框
#let frame-dark = block.with(fill: rgb("#27292c"), inset: (x: 8pt, y: 4pt), radius: 4pt)
#let frame-light = block.with(fill: rgb("#f0f0f0"), inset: (x: 8pt, y: 4pt), outset: (y: 4pt), radius: 4pt)

// 脚注强调
#let crimson = rgb("#c00000")
#let redbold(body) = {
  set text(fill: crimson, weight: "bold")
  body
}


// Definitions for math
#let prox = math.op("prox")
#let proj = math.op("proj")
#let argmax = math.op("argmax", limits: true)
#let argmin = math.op("argmin", limits: true)


/// 序章函数，用于创建不编号的序章
/// - `title` (string): 序章标题
/// - `body` (content): 序章内容
/// -> content
#let preface(title, body) = {
  // 创建序章标记，用于页眉识别
  [#metadata((type: "preface", title: title)) <preface-marker>]

  // 添加到目录中（创建一个不编号的一级标题）
  [#heading(level: 1, numbering: none, outlined: true, title)]

  // 渲染序章内容
  body
}


/// 模板的核心类，规范了文档的格式。
/// - `device` (string): 输出介质，可选 `"pad"` 或 `"normal"`，决定排版用纸尺寸与配色方案。默认 `"normal"`。
/// - `theme` (string): 主题色调，可选 `"light"` 或 `"dark"`。影响整体背景与文字基色。默认 `"light"`。
/// - `size` (length): 正文字号。可写 `pt` / `mm` / `em` 等单位。默认 `10pt`。
/// - `pad-size` (length): 针对投屏/网页阅读的字号；未显式设置时沿用 `size`。默认 `10pt`。
/// - `title` (string | none): 文档主标题，用于封面、页眉与 PDF 元数据。默认 `none`。
/// - `short-title` (string | none): 短标题，出现在页眉与目录；缺省时回退到 `title`。默认 `none`。
/// - `description` (string | none): 摘要/副标题，可填入一句话简介。默认 `none`。
/// - `authors` (array): 作者列表。每项为字典，如 `(name, github?, homepage?, affiliations)`。默认空数组 `()`。
/// - `affiliations` (array): 机构对照表，每项形如 `(id, name)`，供作者用 `id` 引用。默认空数组 `()`。
/// - `semester` (string | none): 学期信息（如 “2025 春”），常见于课堂报告模板。默认 `none`。
/// - `date` (datetime | none): 创建日期，典型写法 `datetime(year: 2025, month: 7, day: 14)`。默认 `none`。
/// - `bibliography-file` (string | none): BibTeX/CSL JSON 路径；为空则禁用引用与参考文献。默认 `none`。
/// - `bibstyle` (string): 引用与文献样式 ID，例如 `"gb-7714-2015-numeric"`, `"apa"`。默认 `"gb-7714-2015-numeric"`。
/// - `paper-size` (string): 纸张尺寸，仅 `device: "normal"` 时生效，如 `"a4"`、`"letter"`。默认 `"a4"`。
/// - `color` (color): 主题强调色 (HEX/CSS 名/色关键字)。用于一级标题、表格线与 `strong` 高亮。默认 `"#000000"`。
/// - `font-style` (string): 字体风格，可选 `"ori"` 或 `"elegantbook"`。`"ori"` 使用现代化字体，`"elegantbook"` 使用传统学术字体。默认 `"ori"`。
/// - `font` (object): 字体族配置。可指定 `main`、`mono`、`cjk`、`math`、`math-cjk` 等子字段；缺省为选定风格的默认字体。
/// - `lang` (string): 主要语言代码，影响分词、连字符、标点。默认 `"zh"`。
/// - `region` (string): 地区代码，用于细化本地化规则。默认 `"cn"`。
/// - `first-line-indent` (object): 段首缩进设置 `{amount, all}`；`all` 为 `true` 时连首段也缩进。默认 `{0pt, false}`。
/// - `maketitle` (bool): 是否自动生成封面页。默认 `false`。
/// - `makeoutline` (bool): 是否自动插入目录。默认 `false`。
/// - `outline-depth` (int): 目录层级深度，`2` 表示到 `subsection`。默认 `2`。
/// - `cover-image` (string | none): 封面背景图文件路径或 `none`。默认 `none`。
/// - `background-color` (color | none): 正文背景色，建议仅在 `theme: "light"` 下使用。默认 `none`。
/// - body (content): 文档的内容。
/// -> content
#let elegant-typst-book(
  device: "normal",
  theme: "light", //fix the bug
  size: 10pt,
  pad-size: 10pt,
  title: none,
  short-title: none,
  description: none,
  authors: (),
  affiliations: (),
  semester: none,
  date: none,
  bibliography-file: none,
  bibstyle: "gb-7714-2015-numeric",
  paper-size: "a4",
  color: "#000000",
  font-style: "ori",
  font: (:),
  lang: "zh",
  region: "cn",
  first-line-indent: (amount: 0pt, all: false),
  maketitle: false,
  makeoutline: false,
  outline-depth: 2,
  cover-image: none,
  background-color: none,
  body,
) = {
  // theorion公式相关设置
  // import cosmos.fancy: *
  // import cosmos.rainbow: *
  // import cosmos.clouds: *
  show: show-theorion

  show: thmrules
  // 使用 zebraw 调整代码块
  show: zebraw
  show: zebraw-init.with(
    background-color: if theme == "dark" {
      // 深色：四色斑马
      (rgb("#2b2d30"), rgb("#2f3134"), rgb("#2b2d30"), rgb("#333639"))
    } else {
      // 亮色：单一浅灰
      rgb("#f5f5f5")
    },
    lang-color: if theme == "dark" { rgb("#2b2d30") } else { teal },
    indentation: 2, // 每 2 个空格一根缩进线
    numbering: true, //是否有行号
    highlight-color: if theme == "dark" { rgb("#44475a") } else { rgb("#eaf2ff") }, // 高亮颜色
  )
  // show: zebraw.with(..zebraw-themes.zebra-reverse)
  // show: zebraw.with(..zebraw-themes.zebra)


  assert(device == "pad" or device == "normal", message: "device must be 'pad' or 'normal'")
  assert(theme == "light" or theme == "dark", message: "theme must be 'light' or 'dark'")
  let page-margin = if device == "pad" { (x: 35pt, y: 35pt) } else { auto }
  let text-size = if device == "pad" { pad-size } else { size }
  let bg-color = if theme == "dark" { rgb("#1f1f1f") } else { rgb("#ffffff") }
  let text-color = if theme == "dark" { rgb("#ffffff") } else { rgb("#000000") }
  let raw-color = if theme == "dark" { rgb("#27292c") } else { rgb("#f0f0f0") }
  // 根据字体风格选择基础字体配置
  let base-font = if font-style == "elegantbook" {
    elegantbook-font
  } else {
    default-font
  }

  // 合并用户自定义字体设置
  let font = base-font + font

  // 主题颜色配置

  // 把 color 解析成真正的 Color（处理 "red" 这类关键字）
  let resolved = if type(color) == str and color.starts-with("#") {
    rgb(color) // 解析颜色字符串为 Color 类型
  } else if type(color) == str and color in palettes {
    // 如果 color 是调色板名，resolved 不需要
    none
  } else { color }

  //  若字符串同时是主题名 → 整套调色板；否则四槽同 resolved
  let palette = if type(color) == str and color in palettes {
    palettes.at(color) // 使用 .at 方法进行动态字段访问
  } else {
    (structure: resolved, main: resolved, second: resolved, third: resolved)
  }

  //  四个真正的 Color 变量
  let structure_color = palette.structure
  let main_color = palette.main
  let second_color = palette.second
  let third_color = palette.third


  /// 设置字体。
  set text(
    font: font.main,
    size: text-size,
    fill: text-color,
    lang: lang,
    region: region,
    weight: if font-style == "elegantbook" { "medium" } else { "regular" }, // 增加字体粗细
  )
  // 设置中文粗体，ElegantBook 风格下使用黑体
  show strong: set text(
    fill: structure_color,
    font: if font-style == "elegantbook" { font.cjk-sans } else { font.main },
    weight: "bold",
  )

  show emph: text.with(font: font.emph-cjk)
  show raw: set text(font: font.mono)
  // 数学公式的字体
  show math.equation: it => {
    set text(font: font.math)
    it
  }
  // 数学公式中引入的中文字的字体
  show math.text: set text(
    font: font.cjk,
    // size: 1em,
  )
  // 文本高亮
  set highlight(fill: structure_color.lighten(50%))

  /// 设置段落样式。
  set par(justify: true, first-line-indent: if first-line-indent == auto {
    (amount: 2em, all: true)
  } else {
    first-line-indent
  })
  // 计数器
  let chaptercounter = counter("chapter")
  /// 设置标题样式。
  // show heading: it => {
  //   // show h.where(amount: 0.3em): none
  //   it
  //   // if it.level == 1 and it.numbering != none {
  //   //   chaptercounter.step()
  //   //   counter(math.equation).update(0)
  //   // }
  // }
  show heading: it => {
    // show h.where(amount: 0.3em): none
    set text(fill: structure_color) if it.level != 1
    it
  }
  show heading: set block(spacing: 1.2em)

  // 调整二级标题字号为LaTeX \Large (14pt)
  // show heading.where(level: 2): it => text(size: 1.4em, it) // 原em单位
  // show heading.where(level: 2): it => text(size: 14pt, it)  // 原设置（接近但不完全匹配）
  show heading.where(level: 2): it => text(size: 14.4pt, it)  // 精确匹配LaTeX \Large (14.4pt for 10pt base)
  
  // 调整三级标题字号为LaTeX \large (12pt)
  // show heading.where(level: 3): it => text(size: 1.2em, it) // 原em单位
  // show heading.where(level: 3): it => text(size: 12pt, it)  // 原设置（基础10pt下的\large）
  show heading.where(level: 3): it => text(size: 12pt, it)  // 精确匹配LaTeX \large (12pt for 10pt base)


  // 配置一级标题 - 简化实现确保黑体加粗
  show heading.where(level: 1): it => {
    let has-prev = query(heading.where(level: 1).before(here())).len() > 0;
    
    // 直接定义标题样式，确保黑体加粗
    let chap = block(width: 100%)[
      #v(+20pt)
      #set align(center)
      #text(
        fill: structure_color,
        font: ("SimHei", "Microsoft YaHei", "Heiti SC", "WenQuanYi Micro Hei"),  // 多系统兼容黑体
        weight: "bold",
        // size: 1.5em,  // 原尺寸（约15pt）
        // size: 1.7em  // 调整为与LaTeX \LARGE一致（约17pt）
        // size: 17pt  // 原设置（接近但不完全匹配）
        size: 17.28pt  // 精确匹配LaTeX \LARGE (17.28pt for 10pt base)
      )[#it]
      #v(+20pt)
    ]
    
    if has-prev {
      pagebreak()
      chap
    } else {
      chap
    }
  }


  /// 设置代码块样式。
  show raw.where(block: false): body => box(
    fill: raw-color,
    inset: (x: 3pt, y: 0pt),
    outset: (x: 0pt, y: 3pt),
    radius: 2pt,
    {
      set par(justify: false)
      body
    },
  )
  // show raw.where(block: true): body => block(
  //   width: 100%,
  //   fill: raw-color,
  //   outset: (x: 0pt, y: 4pt),
  //   inset: (x: 8pt, y: 4pt),
  //   radius: 4pt,
  //   {
  //     set par(justify: false)
  //     body
  //   },
  // )

  // 配置行内代码块
  // show raw.where(
  //   block: false,
  // ): it => box(fill: luma(245), inset: (x: 2pt), outset: (y: 3pt), radius: 1pt)[#it]

  // show raw.where(block: true): it => sourcecode[#it]


  /// 将链接设置蓝色并加下划线，并且对于作者列表禁用此设置
  show link: it => {
    let author-names = ()
    for author in authors {
      author-names.push(author.name)
    }

    if it.body.has("text") and it.body.text in author-names {
      it
    } else {
      underline(stroke: (dash: "densely-dotted"), text(fill: blue, it))
    }
  }


  show image.where(format: auto): it => {
    if theme == "dark" {
      box(fill: rgb("#707580"), inset: 2pt, radius: 2pt)[#it]
    } else { it }
  }


  /// 设置 figure 样式。
  // 原始代码：show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure.caption(position: top)
  
  // 全局设置所有标题字号为 9pt (与LaTeX \small一致)
  show figure.caption: cap => text(size: 9pt, cap)

  /// 设置列表样式。
  set list(indent: 6pt)
  set enum(indent: 6pt)
  set enum(numbering: numbly("{1:1}.", "{2:1})", "{3:a}."), full: true)

  /// 设置引用样式。
  set bibliography(style: "ieee")

  /// 设置文档元数据
  set document(title: title, author: authors.map(author => author.name), date: date)

  // 配置公式的编号和间距
  set math.equation(numbering: (..nums) => (
    context {
      numbering("(1.1)", chaptercounter.at(here()).first(), ..nums)
    }
  ))

  // 配置图像和图像编号
  set figure(numbering: (..nums) => context {
    numbering("1.1", chaptercounter.at(here()).first(), ..nums)
  })


  // 配置表格（不能用if{}，因使用if{}后作用域仅局限在块里，无法影响body）
  set table(
    fill: (_, row) => if row == 0 { structure_color.lighten(60%) } else {
      structure_color.lighten(80%)
    },
    stroke: 1pt + white,
  ) if theme == "light"

  set table.vline(stroke: 1pt + white) if theme == "dark"
  set table.hline(stroke: 1pt + white) if theme == "dark"


  /// 重置页面计数器。
  counter(page).update(1)
  /// 设置页面。
  set page(
    paper: paper-size,
    header: context {
      if here().page() == 1 {
        return
      }
      // 获取正确的章节标题
      let chapter-title = ""

      // 首先检查当前页面是否有序章标记
      let preface-elems = query(<preface-marker>).filter(it => it.location().page() == here().page())

      if preface-elems.len() > 0 {
        // 当前页面有序章，使用序章标题
        chapter-title = preface-elems.first().value.title
      } else {
        // 没有序章，使用正常的章节标题逻辑
        let elems = query(heading.where(level: 1).after(here()))

        if (elems == () or elems.first().location().page() != here().page()) {
          let elems = query(heading.where(level: 1).before(here()))
          if (elems != ()) { chapter-title = elems.last().body }
        } else {
          chapter-title = elems.first().body
        }
      }
      // 修改页眉为 章节标题  short-title  semester
      // 其中章节标题和 semester奇偶轮换，若无短标题(short-title)，就使用标题(title)
      let head-title = text()[

        #if short-title != none {
          short-title
        } else {
          title
        }
      ]
      set text(fill: structure_color)
      let (lefthead, midhead, righthead) = if calc.even(here().page()) == true {
        (chapter-title, head-title, semester)
      } else { (semester, head-title, chapter-title) }

      set text(9pt)  // 与LaTeX \footnotesize一致 (9pt)
      stack(
        spacing: 0.2em,
        grid(
          columns: (1fr, 1fr, 1fr),
          gutter: 0pt,
          align(left, lefthead), align(center, midhead), align(right, righthead),
        ),
        v(0.3em),
        // line(length: 100%, stroke: 1pt + text-color),
        v(.15em),
        line(length: 100%, stroke: .5pt + structure_color),
      )

      // reset footnote counter
      counter(footnote).update(0)
    },
    footer: context {
      if here().page() == 1 { return }
      [
        #if calc.even(here().page()) == true {
          align(left)[#counter(page).display("1 / 1", both: true)]
        } else {
          align(right)[#counter(page).display("1 / 1", both: true)]
        }
      ]
    },
    fill: bg-color,
    // 封面图片和背景图片
    background: context {
      if here().page() == 1 and cover-image != none {
        block(width: 100%, height: 100%)[#image(cover-image, width: 100%, height: 100%)]
      } else if background-color != none {
        block(width: 100%, height: 100%, fill: rgb(background-color))
      }
    },

    // numbering: "1 / 1",
    margin: page-margin,
  )

  /// 标题页。
  if maketitle {
    // Title page
    box(width: 100%, height: 40%)[
      #align(center + bottom)[
        // #v(20%)
        // #text(2em, weight: 500, subject)
        // #v(2em, weak: true)
        // #text(2em, weight: 500, title)
        // #v(2em, weak: true)

        #box(width: 100%, height: 40%)[
          // 显示论文的标题和描述。
          #align(center + bottom)[
            #text(36pt, weight: "bold")[#title]
            #parbreak()
            #if description != none {
              text(size: 16pt, style: "italic")[#description]
            }
          ]
        ]


        // #authors.name
      ]
    ]
    box(width: 100%, height: 40%)[
      #align(center + top)[
        #if authors.len() > 0 {
          box(inset: (y: 10pt), {
            authors
              .map(author => {
                text(16pt, weight: "semibold")[
                  #if "homepage" in author {
                    [#link(author.homepage)[#author.name]]
                  } else { author.name }]
                if "affiliations" in author {
                  super(author.affiliations)
                }
                if "github" in author {
                  link(author.github, box(height: 1.1em, baseline: 13.5%)[#image.decode(githubSvg)])
                }
              })
              .join(", ", last: {
                if authors.len() > 2 {
                  ", and"
                } else {
                  " and"
                }
              })
          })
        }
        #v(-2pt, weak: true)
        #if affiliations.len() > 0 {
          box(inset: (bottom: 10pt), {
            affiliations
              .map(affiliation => {
                text(12pt)[
                  #super(affiliation.id)#h(1pt)#affiliation.name
                ]
              })
              .join(", ")
          })
        }
      ]
    ]
    // v(9em)
    box(width: 100%)[
      #align(center + top)[
        #if date != none {
          text(size: 12pt, "最初写作于：")
          text(size: 12pt, fill: structure_color, weight: "semibold", date.display("[year]年[month]月[day]日"))
          parbreak()
          text(size: 12pt, "最后更新于：")
          text(size: 12pt, fill: structure_color, weight: "semibold", datetime
            .today()
            .display("[year]年[month]月[day]日"))
        } else {
          (
            text(size: 11pt)[最后更新于：#h(5pt)]
              + text(size: 11pt, fill: accen-color, weight: "semibold", datetime
                .today()
                .display("[month repr:long] [day padding:zero], [year repr:full]"))
          )
        }
      ]

    ]
    pagebreak(weak: true)
  }

  /// 目录。
  if makeoutline {
    show heading: align.with(center)
    show outline.entry: set block(spacing: 1.2em)

    outline(depth: outline-depth, indent: 2em)
    pagebreak(weak: true)
  }


  // /// 行间代码块
  // show raw.where(block: true): code => sourcecode(
  //   frame: f => if theme == "dark" { frame-dark(f) } else { frame-lig1ht(f) },
  //   numbers-step: 1,
  //   numbers-side: left,
  //   gutter: 10pt,
  // )[#code]


  // 行内代码块

  // show raw.where(block: false): code => sourcecode(
  //   numbers-side: none, // 不要行号

  //   frame: f => box(
  //     fill: if theme == "dark" { rgb("#27292c") } else { rgb("#f0f0f0") },
  //     inset: (x: 2pt, y: 0pt),
  //     radius: 1pt,
  //     [#f], // ← 把变量 f 插入内容，用 # 前缀
  //   ),
  // )[#code]


  body
  // 显示参考文献
  if bibliography-file != none {
    pagebreak()
    show bibliography: set text(10.5pt)
    bibliography(bibliography-file, title: "参考文献", style: bibstyle) // apply bibstyle here.
  }
}

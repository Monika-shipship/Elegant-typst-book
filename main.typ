#import "lib.typ": *

#set heading(numbering: numbly("{1:第一章 }", default: "1.1  "))

#show: elegant-typst-book.with(
  title: [ElegantTypstBook\ 优美的Typst书籍模板],
  short-title: [ElegantTypstBook],
  // 笔记描述（选填）
  description: [
    文档描述示例\ 逸一时误一世，忆久忆久罢已龄
  ],
  // 笔记创建日期（选填）
  date: datetime(year: 2025, month: 6, day: 24),
  authors: (
    (
      name: "作者一",
      //github: "https://github.com/a-kkiri",
      //homepage: "https://github.com/a-kkiri",
      affiliations: "1,2",
    ),
    (
      name: "作者二",
      //github: "https://github.com/a-kkiri",
      //homepage: "https://github.com/a-kkiri",
      affiliations: "3,4",
    ),
  ),

  // 所属组织列表，每一项包括一个 id 和 name。这些将显示在作者下方。
  affiliations: (
    (id: "1", name: "114 University"),
    (id: "2", name: "514 Inc."),
    (id: "1", name: "1919 University"),
    (id: "2", name: "810 Inc."),
  ),
  // 学期
  semester: "2025 春",
  // 参考书目文件路径及引用样式
  bibliography-file: "refs.bib",
  bibstyle: "gb-7714-2015-numeric",
  // 是否生成标题和目录
  maketitle: true,
  makeoutline: true,
  outline-depth: 4,
  // 主题色 可选green cyan blue gray black
  color: "blue",
  // 字体风格设置 可选 "ori" 或 "elegantbook"
  // "ori": 现代化字体（IBM Plex Serif + Noto Serif SC）
  // "elegantbook": 传统学术字体（TeX Gyre Termes + SimSun，兼容 LaTeX ElegantBook）
  // font-style: "elegantbook",
  // 封面背景图片（选填图片路径或 none）
  // cover-image: "./figures/cover-image.png",
  // 正文背景颜色（选填 HEX 颜色或 none）
  // background-color: "#FAF9DE",
  first-line-indent: auto,
  // theme: "dark", //此处有bug
  // media: "screen",
)

// // 强制一级标题使用黑体加粗（最终解决方案）
// #show heading.where(level: 1): it => {
//   text(
//     font: "SimHei",
//     weight: "bold",
//     size: 1.5em,
//     // fill: rgb(0, 120, 2)
//   )[#it.body]  // 仅应用于标题文本内容，解决样式覆盖问题
// }


// // —— 正文：宋体 ——
//   #set text(lang: "zh", font: "SimSun", size: 11pt)


#preface("序章")[
  这是一个序章示例，用于测试序章功能。

  序章通常用于引言、背景介绍或者概述整本书的内容。它不会影响后续章节的编号，第一章仍然会显示为"第一章"。

  这个序章的标题会在页眉中正确显示，并且具有与正常章节相同的视觉样式。

  == 字体风格测试

  当前使用的是 `elegantbook` 字体风格，具有以下特性：
  - `英文字体`：TeX Gyre Termes（类似 Times New Roman）
  - `中文字体`：宋体（SimSun）系列
  - `一级标题`：使用粗体显示
  - `数学字体`：TeX Gyre Termes Math

  这些设置与 LaTeX ElegantBook 模板保持一致，提供传统学术文档的外观。

  如需切换到现代字体风格，请将 `font-style` 设置为 `"ori"`。
  // —— 第一段：黑体 (SimHei) ——
#text(font: "SimHei", weight: "bold")[
这是第一段文字，使用黑体 SimHei。
]

// —— 第二段：宋体 (SimSun) ——
#text(font: "SimSun")[
这是第二段文字，使用宋体 SimSun。
]
]

#include "content/charpter1.typ"
#include "content/charpter2.typ"

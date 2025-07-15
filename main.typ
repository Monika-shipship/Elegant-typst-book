#import "lib.typ": *

#set heading(numbering: numbly("{1:第一章 }", default: "1.1  "))

#show: elegant-typst-book.with(
  device: "normal", // 输出介质："normal"（印刷）或 "pad"（屏幕阅读），决定用纸尺寸与边距
  title: [ElegantTypstBook\ 优美的Typst书籍模板],
  short-title: [ElegantTypstBook], // 页眉/目录显示的短标题
  // 文档副标题（选填，显示在封面主标题下方）
  description: [
    文档描述示例\ 逸一时误一世，忆久忆久罢已龄
  ],
  // 创建日期（选填，支持自动更新）
  date: datetime(year: 2025, month: 6, day: 24),
  authors: (
    (
      name: "作者一",
      github: "https://github.com/a-kkiri",
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

  // 机构对照表（id需与authors中的affiliations对应）
  affiliations: (
    (id: "1", name: "114 University"),
    (id: "2", name: "514 Inc."),
    (id: "3", name: "1919 University"),
    (id: "4", name: "810 Inc."),
  ),
  semester: "2025 春", // 学期（用于页眉显示）
  // 参考文献配置（需提前准备.bib文件）
  bibliography-file: "refs.bib",
  bibstyle: "gb-7714-2015-numeric", // 国标GB/T 7714-2015 numeric格式
  // 封面与目录生成控制
  maketitle: true, // 自动生成封面页
  makeoutline: true, // 自动生成目录
  outline-depth: 4, // 目录层级（1-4级标题）
  // 主题色："green"/"cyan"/"blue"/"gray"/"black"
  color: "blue",
  // 字体方案："ori"（现代）/"ctex"（兼容）/"founder"（方正）
  font-style: "founder",
  // 封面背景图（暂未配置）
  // cover-image: none,
  // 正文背景色（建议仅light主题使用，如 "#FAF9DE"）
  // background-color: "#FAF9DE",
  first-line-indent: auto, // 自动段首缩进（2字符，首段缩进）
  theme: "dark", // 深色模式
)

#preface("序章")[
  本模板采用`#preface()`函数实现序章功能，具有以下特性：
  - 不影响后续章节编号（第一章仍从"第一章"开始）
  - 支持页眉标题自动识别（通过元数据`<preface-marker>`）
  - 与正文保持一致排版样式（17.28pt黑体标题，10pt正文字号）

  == 模板版本说明
  当前版本：v1.0.0（基于Typst 0.11.0开发）
  核心依赖宏包版本：
  - `@preview/cetz:0.4.0`（绘图引擎）
  - `@preview/theorion:0.3.3`（定理环境）
  - `@preview/tablem:0.2.0`（三线表功能）

  完整序章内容已迁移至附录，可通过目录跳转查看。
]

#include "content/charpter1.typ"
#include "content/charpter2.typ"

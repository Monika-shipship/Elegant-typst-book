#import "../lib.typ": *

= ElegantTypst 系列模板介绍
  我们致力于打造一系列美观、优雅、简便的模板方便用户使用。目前只有 Elegant-Typst-Book，用于排版书籍和笔记。
  本文将介绍本模板的一些设置内容以及基本使用方法。如果您有其他问题，建议或者意见，欢迎在 GitHub上给我们提交 issues
  
GitHub 地址：#link("https://github.com/Monika-shipship/Elegant-typst-book")
== 快速开始

要开始使用此模板，你需要


+ 安装必须的字体包，包括：
  - #link("https://github.com/IBM/plex")[*IBM Plex Sans, Mono*]
  - #link("https://github.com/notofonts/noto-cjk")[*Noto Serif CJK SC*]

+ 导入模板，并在文档开头设置参数，包括标题、作者、课程或主题、学期、时间；
  ```typ
  #import "lib.typ": *

  #set heading(numbering: numbly("{1:一}、", default: "1.1  "))

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
    // 主题色
    accent: blue,
    // 封面背景图片（选填图片路径或 none）
    // cover-image: "./figures/cover-image.png",
    // 正文背景颜色（选填 HEX 颜色或 none）
    // background-color: "#FAF9DE",

    // theme: "dark", //此处有bug
    // media: "screen",
  )

  #include "content/charpter1.typ"
  #include "content/charpter2.typ"
  ```

# Elegant-typst-book

 致力于在typst中复刻elegantbook并增加少量内容，适用于笔记（支持夜间模式）、报告和各类文档。同时也是我个人 Typst 中文写作的最佳实践。

## 更新

- 修复了以下bug：
  - dark模式下标题页和目录页空白的bug
- 增加了以下新功能：
  - 增加了数学公式和插入图像的自动编号功能，数学公式编号默认格式为(a.b)其中a为章节数，b为该章下公式序号
  - 在标题页下增加了创建时间和最后更新时间的box
  - 增加了主题色功能，该主题色会自动以下颜色：
    - 同步一级标题
    - 表格(但在黑色模式下不同步颜色)
    - `strong`的颜色
    - 还有标题页“最后更新时间”处的日期颜色
    - 文本高亮`highlight`
  - 增加了参考文献

## 快速开始

要开始使用此模板，你需要

- 安装必须的字体包，包括：
  - #link["<https://github.com/IBM/plex"](*IBM> Plex Sans, Mono*)
  - #link["<https://github.com/notofonts/noto-cjk"](*Noto> Serif CJK SC*)

- 导入模板，并在文档开头设置参数，包括标题、作者、课程或主题、学期、时间；

  ```typ
    #import "@preview/ori:0.2.2": *

    #show: ori.with(
    title: [Ori in Typst\ 文档标题],
    short-title: [Ori in Typst],
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
    ),
    affiliations: (
      (id: "1", name: "114 University"),
      (id: "2", name: "514 Inc."),
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

    theme: "dark", //此处有bug
    // media: "screen",
  )
  ```

## 特性

### 可配置参数

  模板的核心类，规范了文档的格式。

- `media` (string): 输出介质，可选 `"screen"` 或 `"print"`，决定排版用纸尺寸与配色方案。默认 `"print"`。
- `theme` (string): 主题色调，可选 `"light"` 或 `"dark"`。影响整体背景与文字基色。默认 `"light"`。
- `size` (length): 正文字号。可写 `pt` / `mm` / `em` 等单位。默认 `11pt`。
- `screen-size` (length): 针对投屏/网页阅读的字号；未显式设置时沿用 `size`。默认 `11pt`。
- `title` (string | none): 文档主标题，用于封面、页眉与 PDF 元数据。默认 `none`。
- `short-title` (string | none): 短标题，出现在页眉与目录；缺省时回退到 `title`。默认 `none`。
- `description` (string | none): 摘要/副标题，可填入一句话简介。默认 `none`。
- `authors` (array): 作者列表。每项为字典，如 `(name, github?, homepage?, affiliations)`。默认空数组 `()`。
- `affiliations` (array): 机构对照表，每项形如 `(id, name)`，供作者用 `id` 引用。默认空数组 `()`。
- `semester` (string | none): 学期信息（如 “2025 春”），常见于课堂报告模板。默认 `none`。
- `date` (datetime | none): 创建日期，典型写法 `datetime(year: 2025, month: 7, day: 14)`。默认 `none`。
- `bibliography-file` (string | none): BibTeX/CSL JSON 路径；为空则禁用引用与参考文献。默认 `none`。
- `bibstyle` (string): 引用与文献样式 ID，例如 `"gb-7714-2015-numeric"`, `"apa"`。默认 `"gb-7714-2015-numeric"`。
- `paper-size` (string): 纸张尺寸，仅 `media: "print"` 时生效，如 `"a4"`、`"letter"`。默认 `"a4"`。
- `accent` (color): 主题强调色 (HEX/CSS 名/色关键字)。用于一级标题、表格线与 `strong` 高亮。默认 `"#000000"`。
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

### 主要功能

1. **三线表支持**：基于 [Tablem 包](https://github.com/OrangeX4/typst-tablem)，提供简单的三线表功能
2. **Markdown 渲染**：基于 [Cmarker 包](https://github.com/SabrinaJewson/cmarker.typ)，支持 Markdown 语法，包括加粗、斜体、删除线等
3. **数学公式**：基于 [MiTeX 包](https://github.com/mitex-rs/mitex) 支持 LaTeX 风格的数学公式
4. **定理环境**：基于 [Theorion 包](https://github.com/OrangeX4/typst-theorion)，提供多种定理环境（定义、定理、引理、命题等）
5. **提示框**：包含多种样式的提示框（强调、引用、注意、提示、重要、警告、小心）
6. **编号**：为每个行间公式设置了公式编号，样式为 (a.b)，同时图像也自带编号

### 自定义

#### 标题编号

可以使用 `numbly` 包自定义标题编号样式：

```typst
#set heading(numbering: numbly("{1:一}、", default: "1.1  "))
```

#### 字体设置

可以通过设置 `font` 参数自定义字体：

```typst
#let font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif SC",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)
```

## 致谢

- 感谢 [hongjr03](https://github.com/hongjr03) 的 [typst-assignment-template](https://github.com/hongjr03/typst-assignment-template)
- 感谢 [OrangeX4](https://github.com/OrangeX4) 的[Ori](https://github.com/OrangeX4/typst-ori)，这是我的模板来源
- 感谢 [ctypst](https://github.com/ctypst) 的[elegant-paper-typst](https://github.com/ctypst/elegant-paper-typst)，参考了部分代码
- 感谢 [a-kkiri](https://github.com/a-kkiri) 的[SimpleNote](https://github.com/a-kkiri/SimpleNote)，参考了部分代码
  
## 许可证

MIT License

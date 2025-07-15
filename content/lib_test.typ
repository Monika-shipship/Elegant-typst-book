#import "@preview/numbly:0.1.0": numbly

// 完整字体字典（从lib.typ迁移）
#let ori-font = (
  main: "IBM Plex Serif",
  mono: "IBM Plex Mono",
  cjk: "Noto Serif SC",
  emph-cjk: "KaiTi",
  math: "New Computer Modern Math",
  math-cjk: "Noto Serif SC",
)

// ElegantBook 风格字体配置（基于 LaTeX ElegantBook 的真实字体设置）
#let elegantbook-font = (
  main: "Times New Roman", // 仅保留英文主字体
  sans: ("Arial", "SimHei"), // 无衬线字体：Arial + 中文黑体
  mono: ("Courier New", "SimSun"), // 等宽字体：Courier New + 中文宋体
  cjk: "SimSun", // 中文正文：宋体
  cjk-sans: "SimHei", // 中文粗体/标题：黑体
  cjk-title: ("SimHei", "Microsoft YaHei"), // 中文一级标题专用：黑体（带系统 fallback）
  emph-cjk: "KaiTi", // 中文斜体：楷体
  math: ("New Computer Modern Math", "Cambria Math", "Times New Roman"), // 数学字体
  math-cjk: "SimSun", // 数学中文字体：宋体
)

// 字体风格字典
#let font-styles = (
  ori: ori-font,
  elegantbook: elegantbook-font,
)

/// 恢复最小示例的函数参数结构
#let elegant-typst-book(
  font-style: "elegantbook",
  font: (:),
  body,
)= {
  // 根据字体风格选择基础字体配置
  let base-font = if font-style == "elegantbook" {
    elegantbook-font
  } else {
    ori-font
  }

  // 合并用户自定义字体设置
  let font = base-font + font

  /// 设置字体（仅保留字体相关配置）
  set text(
    font: font.main,
    size: 10pt,  // 使用默认字号，移除size参数依赖
    weight: if font-style == "elegantbook" { "medium" } else { "regular" },
  )

  // 中文粗体设置（从lib.typ迁移）
  show strong: set text(
    font: if font-style == "elegantbook" { font.cjk-sans } else { font.main },
    weight: "bold",
  )

  // 斜体设置（从lib.typ迁移）
  show emph: text.with(font: font.emph-cjk)
  
  // 代码块字体（从lib.typ迁移）
  show raw: set text(font: font.mono)
  
  // 数学公式字体（从lib.typ迁移）
  show math.equation: it => {
    set text(font: font.math)
    it
  }
  
  // 数学公式中文字体（禁用全局覆盖，修复字体冲突）
  // show math.text: set text(
  //   font: font.cjk,
  // )

  // 调试：直接指定字体族并添加系统级fallback
  show heading.where(level: 1): it => {
    text(
      font: font.cjk-sans,
      weight: "bold",
      size: 17.28pt,
      fill: rgb(255, 0, 0)  // 红色标题便于识别
    )[#it]
  }

  // 二级标题样式（从lib.typ迁移）
  show heading.where(level: 2): it => text(size: 14.4pt, it)
  
  // 三级标题样式（从lib.typ迁移）
  show heading.where(level: 3): it => text(size: 12pt, it)

  body
}

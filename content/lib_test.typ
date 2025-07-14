// ---------------- lib_test.typ ----------------
// 极简模板：锁定正文宋体 & 覆盖一级标题为黑体
#let elegant-typst-book(
  device: "normal",
  theme: "light",
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

  // —— 正文：宋体 ——
  set text(lang: "zh", font: "SimSun", size: 11pt)

  // —— 一级标题：黑体加粗放大 ——
  show heading.where(level: 1): it => {
    text(font: "SimHei", weight: "bold", size: 1.6em)[#it.body]
  }

  // —— 渲染正文 ——  
  body
}

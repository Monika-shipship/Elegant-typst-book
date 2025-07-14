#import "@preview/theorion:0.3.3": *
#import cosmos.fancy: *

// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set heading(numbering: "1.1")
#set text(lang: "en")
= Test
#definition[
  define test
]

// ---------------- main_test.typ ----------------
#import "lib_test.typ": elegant-typst-book

#show: elegant-typst-book.with(
  title: [示例文档],
  short-title: [示例],
  maketitle: false,
)

= 第一章 黑体标题

这里是正文，应该呈现为 **宋体 SimSun**。

== 1.1 二级标题（仍用宋体粗体）

更多正文……

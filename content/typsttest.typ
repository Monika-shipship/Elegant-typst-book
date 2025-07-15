#import "@preview/numbly:0.1.0": numbly
#import "lib_test.typ": elegant-typst-book

#set heading(numbering: numbly("{1:第一章 }", default: "1.1  "))

#show: elegant-typst-book.with(
  font-style: "elegantbook"  // 移除size参数，匹配函数定义
)

= 测试一级标题（应显示为黑体）
这是正文内容（应显示为宋体）。通过完整迁移字体配置，此示例应复现完整版本的字体问题。

== 二级标题示例（应显示为宋体加粗）
*粗体文本*（应显示为黑体）和_斜体文本_（应显示为楷体）的样式测试。

// 代码块字体测试
```rust
fn main() {
    println!("代码块应使用Courier New字体");
}
```

// 数学公式测试
$E = m \cdot c^2$（公式中的中文应显示为宋体）

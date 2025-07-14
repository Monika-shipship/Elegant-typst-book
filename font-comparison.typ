#import "lib.typ": *

// 展示两种字体风格的对比文档

= 字体风格对比测试

本文档用于演示 Elegant-typst-book 模板的两种字体风格。

== ElegantBook 风格

#show: elegant-typst-book.with(
  title: [字体风格对比：ElegantBook],
  font-style: "elegantbook",
  color: "blue",
)

= 第一章 传统学术字体风格

这是使用 ElegantBook 字体风格的示例文档。

== 字体特性

当前使用的字体配置：
- **英文字体**：TeX Gyre Termes（类似 Times New Roman）
- **中文字体**：宋体（SimSun）
- **数学字体**：TeX Gyre Termes Math
- **一级标题**：使用粗体显示

这种配置与 LaTeX ElegantBook 模板保持一致，提供传统学术文档的外观。

== 数学公式测试

数学公式使用专门的数学字体：

$ E = m c^2 $

$ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $

牛顿第二定律：$F = m a$

== 中英文混排测试

This is a test of English and Chinese mixed typesetting. 这是中英文混合排版的测试。

**粗体文本测试**：This is bold text. 这是粗体文字。

*斜体文本测试*：This is italic text. 这是斜体文字。

== 代码块测试

行内代码：`print("Hello, World!")`

代码块：
```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

print(fibonacci(10))
```

== 列表测试

1. 有序列表项目一
2. 有序列表项目二
   1. 子项目一
   2. 子项目二
3. 有序列表项目三

- 无序列表项目一
- 无序列表项目二
  - 子项目一
  - 子项目二
- 无序列表项目三

== 表格测试

#table(
  columns: 3,
  [姓名], [年龄], [职业],
  [张三], [25], [工程师],
  [李四], [30], [设计师],
  [王五], [28], [产品经理]
)

= 第二章 对比说明

如需切换到现代字体风格，请将 `font-style` 参数设置为 `"ori"`：

```typst
#show: elegant-typst-book.with(
  font-style: "ori",  // 现代字体风格
  // 其他参数...
)
```

现代字体风格特点：
- **英文字体**：IBM Plex Serif
- **中文字体**：Noto Serif SC  
- **更适合数字化阅读**
- **一级标题不使用粗体**

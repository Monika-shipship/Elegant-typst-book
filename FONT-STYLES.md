# 字体风格指南

Elegant-typst-book 模板现在支持两种字体风格，可以通过 `font-style` 参数进行切换。

## 字体风格选项

### 1. `"ori"` 风格（默认）

现代化字体配置，适合数字化阅读：
- **英文字体**：IBM Plex Serif
- **中文字体**：Noto Serif SC
- **数学字体**：New Computer Modern Math
- **一级标题**：常规字重
- **适用场景**：现代文档、在线阅读、屏幕显示

### 2. `"elegantbook"` 风格

传统学术字体配置，兼容 LaTeX ElegantBook：
- **英文字体**：TeX Gyre Termes（Times 系列）
- **中文字体**：SimSun（宋体）系列
- **数学字体**：TeX Gyre Termes Math
- **一级标题**：粗体显示
- **适用场景**：学术论文、传统文档、印刷出版

## 使用方法

```typst
#show: elegant-typst-book.with(
  // 选择字体风格
  font-style: "elegantbook",  // 或 "ori"
  
  // 其他参数...
  title: [文档标题],
  color: "blue",
)
```

## 字体回退机制

每种风格都提供了完整的跨平台字体回退：

### ElegantBook 风格回退

- **Windows**: SimSun → Noto Serif CJK SC → Source Han Serif SC
- **macOS**: STSong → Songti SC → Noto Serif CJK SC  
- **Linux**: Noto Serif CJK SC → Source Han Serif SC → SimSun

### 英文字体回退

- TeX Gyre Termes → Times New Roman → Liberation Serif → Times

## 自定义字体

你仍然可以通过 `font` 参数进一步自定义字体：

```typst
#show: elegant-typst-book.with(
  font-style: "elegantbook",
  font: (
    // 覆盖特定字体
    cjk: "Custom Chinese Font",
    math: "Custom Math Font",
  ),
)
```

## 示例

查看以下文件获取完整示例：
- `main.typ` - ElegantBook 风格示例
- `font-comparison.typ` - 字体风格对比文档

## 编译

使用 tinymist 编译：
```bash
tinymist compile main.typ
tinymist compile font-comparison.typ
```

或使用 typst 编译：
```bash
typst compile main.typ
typst compile font-comparison.typ

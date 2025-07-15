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
```
## ElegantBook LaTeX 与 Typst 功能对比表

根据 `elegantbook.cls`、`elegantbook-cn.tex` 与 Typst 模板文件的分析，功能差异如下：

| __功能模块__ | __LaTeX 实现（elegantbook.cls/cn.tex）__ | __Typst 实现（main.typ/lib.typ）__ | __状态__ |
|--------------|-------------------------------------------|-------------------------------------|----------|
| __文档基础配置__ | 支持多语言（zh/en/fr等）、设备模式（normal/pad）、字体样式（ori/elegantbook）、颜色主题（5种预设） | 支持设备模式（normal/pad）、字体样式切换，但多语言仅支持中文，颜色主题未完整实现 | 部分实现 |
| __页面布局__ | 自定义纸张尺寸（7.5x10in pad模式）、页边距（16mm均匀边距）、页眉页脚（章节标题+页码奇偶分布） | 已实现pad模式尺寸/边距，但页眉页脚仅显示章节标题，缺少学期信息轮换 | 部分实现 |
| __标题样式__ | 章标题双行/单行切换、中文数字编号（第一章/第1章）、标题前后间距（-20pt/1.3行高） | 仅实现单行标题和中文数字编号，标题间距未精确匹配 | 部分实现 |
| __定理环境__ | fancy/simple双模式、12种预定义环境（theorem/definition/lemma等）、自定义定理命令（\elegantnewtheorem） | 仅实现基础定理环境，缺少样式切换和自定义定理功能 | 缺失 |
| __内容组织__ | 章节摘要（introduction环境）、章后习题（problemset环境）、旁注（marginpar） | 未实现章节摘要和习题环境，旁注功能缺失 | 缺失 |
| __参考文献__ | 支持biblatex/biber、国标GB7714-2015样式、引用样式切换（numeric/authoryear） | 未实现文献管理系统 | 缺失 |
| __特殊功能__ | 版本更新历史（\datechange/change环境）、代码高亮（listings宏包）、数学公式编号（章节+公式序号） | 未实现版本历史和代码高亮，数学公式编号规则不同 | 缺失 |
| __字体配置__ | 英文字体（Times New Roman/TeX Gyre Termes）、中文字体（宋体/黑体/楷体）、数学字体（CM/newtx/mtpro2） | 基础字体映射已实现，但数学字体切换和字体粗细控制不完善 | 部分实现 |

### 后续优化目标（优先级排序）

1. __核心功能补全__：

   - 实现定理环境系统（区分theorem/definition/lemma样式）
   - 添加参考文献支持（适配GB7714-2015格式）
   - 开发章节摘要（introduction）和习题（problemset）环境

2. __样式精确匹配__：

   - 修复标题间距（LaTeX的-20pt顶部负间距）
   - 实现页眉学期信息奇偶页轮换
   - 补全5种颜色主题配置

3. __高级功能移植__：

   - 版本更新历史记录功能
   - 代码块高亮（适配zebraw宏包）
   - 自定义定理环境命令（类似\elegantnewtheorem）

需要优先完成核心功能补全，确保文档结构完整性；再逐步优化样式细节和高级功能，最终实现与LaTeX模板1:1的功能对等。
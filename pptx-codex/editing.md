# 编辑演示文稿

## 基于模板的工作流

当用户给你一个已有 `.pptx` 模板或历史 deck 时，优先走这条路径。

1. 先分析现有 deck：

```bash
python scripts/thumbnail.py template.pptx
python scripts/extract_text.py template.pptx
```

如果本地装了 `markitdown[pptx]`，也可以执行：

```bash
python -m markitdown template.pptx
```

2. 先做 slide 映射：确定每个内容块要落到哪一种版式上。

建议主动使用不同布局，不要整个答辩稿都用“标题 + bullet”。

- 多栏版式
- 图文组合
- 全图叠字
- 引言/过渡页
- 指标卡片页
- 图标列表页

3. 解包：

```bash
python scripts/office/unpack.py template.pptx unpacked/
```

4. 先做结构变更：

- 删除不用的 slide
- 复制需要复用的 slide
- 调整 slide 顺序
- 先完成结构，再开始替换内容

5. 编辑内容：

- 替换所有占位内容
- 如果模板元素数量多于实际内容，删除多余整组元素，不要只清空文字
- 多条内容应拆成多个段落，而不是拼成一段长句

6. 清理：

```bash
python scripts/clean.py unpacked/
```

7. 重新打包：

```bash
python scripts/office/pack.py unpacked/ output.pptx
```

8. 执行 QA。

## 常用脚本

| 脚本 | 作用 |
| --- | --- |
| `scripts/office/unpack.py` | 解包 PPTX |
| `scripts/add_slide.py` | 复制 slide |
| `scripts/clean.py` | 清理孤儿 slide 和关系 |
| `scripts/office/pack.py` | 重打包 PPTX |
| `scripts/thumbnail.py` | 生成缩略总览 |
| `scripts/office/validate.py` | 校验解包目录结构 |

## Slide 操作

Slide 顺序由 `ppt/presentation.xml` 中的 `p:sldIdLst` 控制。

- 重新排序：移动 `p:sldId`
- 删除：删掉无用的 slide 引用并运行 `clean.py`
- 新增：使用 `add_slide.py`

不要手工复制 slide 文件，因为关系、Content Types 和引用很容易出错。

## 常见坑

- 模板里有 4 个卡片，但你只有 3 个内容项，只清空第 4 个会留下空壳
- 新文字比原模板长太多，会引起换行溢出
- 图注、页脚、来源文字常常容易残留
- 布局可复用，但内容密度不可硬塞


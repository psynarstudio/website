-- 依文章 front matter 的 steps 自動產生方法標籤，例如 steps: [觀察, 理解]
local ALL = {"觀察", "理解", "分析", "設計"}

function Pandoc(doc)
  local steps = doc.meta.steps
  if not steps then return doc end
  local on = {}
  for _, s in ipairs(steps) do on[pandoc.utils.stringify(s)] = true end
  local inlines = {}
  for i, name in ipairs(ALL) do
    local classes = {"step-tag"}
    if on[name] then table.insert(classes, "on") end
    if i > 1 then table.insert(inlines, pandoc.Space()) end
    table.insert(inlines, pandoc.Span(name, {class = table.concat(classes, " ")}))
  end
  table.insert(doc.blocks, 1, pandoc.Div(pandoc.Plain(inlines), {class = "step-tags"}))
  return doc
end

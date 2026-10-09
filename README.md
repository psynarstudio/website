# 個人網站（Quarto + GitHub Pages）

## 檔案結構

```
_quarto.yml          網站設定：網站名稱、導覽列、頁尾
styles.scss          視覺：有心敘士標準色、字體、版面
index.qmd            首頁
method.qmd           方法頁
observations/        城市觀察（每篇文章一個資料夾）
analysis/            城市分析（可放 R 程式碼與互動地圖）
works.qmd            作品與工具
about.qmd            關於
collaborate.qmd      合作（導向有心敘士工作室）
_subscribe.qmd       電子報訂閱區塊（各頁共用）
images/              標誌、插畫、照片
CNAME                自訂網址（買好網址後填入）
```

## 第一次設定

1. 安裝 Quarto（quarto.org），RStudio 新版已內建。
2. 在 R 安裝套件：`install.packages(c("rmarkdown", "knitr", "leaflet"))`
3. 用 RStudio 開啟這個資料夾，在 Terminal 執行 `quarto preview`，瀏覽器會打開網站預覽。
4. 全站搜尋 `[` 開頭的方括號，替換成你的內容（名字、網址、帳號等）。

## 新增一篇文章

複製 `observations/2026-10-first-lost/` 整個資料夾，改資料夾名稱，再修改裡面的 `index.qmd` 和 `cover.jpg`。首頁與列表會自動更新。

## 發布到 GitHub Pages

1. 在 GitHub 建立一個新的 repository，把 `site/` 資料夾的內容推上去（`docs/` 不用推，已列入 .gitignore；`_freeze/` 要推）。
2. GitHub repository → Settings → Pages → Source 選 `GitHub Actions`。
3. 之後每次 push 到 `main`，`.github/workflows/publish.yml` 會自動執行 `quarto render` 並發布。

## 後台：Pages CMS

1. 到 https://app.pagescms.org 用 GitHub 帳號登入，授權並選擇這個 repository。
2. 後台會依 `.pages.yml` 出現「城市觀察、城市分析、關於、作品與工具、合作」。
3. 新增文章：填標題、網址代稱、日期、方法標籤、封面圖，在內文欄位寫 Markdown。存檔後約 2–4 分鐘網站更新。
4. 上傳的圖片存在 `images/uploads/`。
5. 方法標籤由 front matter 的 `steps` 自動產生（`step-tags.lua`），不必在內文手寫。
6. 首頁、方法頁版面較複雜，不在後台編輯，請直接改 `index.qmd`、`method.qmd`。
7. 含 R 程式碼的分析文章建議在本機寫好、`quarto render` 確認後再 push。

## 連接自訂網址

1. 把 `CNAME` 檔的內容改成你的網址（只寫網址本身，例如 `example.com`）。還沒買網址前，先刪掉這個檔案，並移除 `_quarto.yml` 裡 `resources` 的 CNAME 那一行。
2. 到你買網址的網站，DNS 設定加入：
   - 四筆 A 記錄，名稱 `@`，指向 `185.199.108.153`、`185.199.109.153`、`185.199.110.153`、`185.199.111.153`
   - 一筆 CNAME 記錄，名稱 `www`，指向 `你的帳號.github.io`
3. GitHub → Settings → Pages → Custom domain 填入網址，等驗證通過後勾選 `Enforce HTTPS`。

## 電子報

在 Buttondown 之類的電子報服務註冊後，把 `_subscribe.qmd` 裡表單的 `action` 換成服務提供的網址。

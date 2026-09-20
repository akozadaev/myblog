+++
date = '2025-12-07T07:50:55+03:00'
draft = false
title = 'Как создать такой блог'
+++

Пока делал блог, столкнулся с некоторыми вопросам:
- Какими технологиями пользоваться?
- Какие инструменты понядобятся?
- Где опубликовать?

Делать какой-то большой самостоятельный обзор мне нее хотелось, поэтому я задал свои вопросы AI. И вот что я получил в ответ.

---

Самый простой и качественный способ создать персональный блог зависит от ваших целей:

---

### ✅ **Если вы хотите быстро, бесплатно и без кода — используйте современные headless CMS + SSG (static site generators)**

#### 🔹 Вариант 1: **[Astro](https://astro.build) + [Content Collections](https://docs.astro.build/en/guides/content-collections/)**
- ✅ Бесплатно, локально, быстро, легко поддерживать
- ✅ Markdown-файлы как «база данных»
- ✅ Минимальный JS во фронтенде → отличная производительность
- ✅ Лёгкое развёртывание на [GitHub Pages](https://pages.github.com/), [Vercel](https://vercel.com), [Netlify](https://netlify.com)
- ✅ Вы можете позже добавить CMS (например, [Decap CMS](https://decapcms.org/) или [TinaCMS](https://tina.io))
- 📦 Шаблон для старта:  
  ```bash
  npm create astro@latest -- --template blog
  ```

#### 🔹 Вариант 2: **[Hugo](https://gohugo.io)** (Go-based, сверхбыстрый)
- ✅ Написан на Go → сборка в мгновение ока (идеально, если вы уже в экосистеме Go)
- ✅ Огромное количество тем (например, [PaperMod](https://github.com/adityatelange/hugo-PaperMod))
- ✅ Полностью статический → безопасен и дёшев в хостинге
- ✅ Поддержка Markdown, автоматическая генерация RSS, SEO-метатегов и т.д.

> ⚡ Совет: если вы — Go-разработчик (как следует из памяти), Hugo будет особенно уместен: без зависимостей, один бинарник, легко встроить в CI через Makefile.

---

### ✅ **Если хочется CMS с UI-редактором (но всё ещё бесплатно и просто)**

| Инструмент | Плюсы | Минусы |
|-----------|-------|--------|
| **[Ghost](https://ghost.org)** | Чистый, ориентирован на блоги, markdown-редактор, встроенный SEO | Бесплатно только self-hosted (нужен VPS/хостинг), облачный — от $9/мес |
| **[Hashnode](https://hashnode.com)** | Бесплатно, поддомен `yourname.hashnode.dev`, поддержка кастомного домена, community | Менее гибкий, реклама в бесплатной версии |
| **[Dev.to](https://dev.to)** | Бесплатно, отличная аудитория разработчиков | Не ваш собственный домен «по-настоящему», ограниченная кастомизация |

> 💡 Для **технического блога** (особенно про Go, Docker, backend) Hashnode или Dev.to — отличный старт: низкий порог входа, встроенная аудитория.

---

### ✅ **Если вы хотите «свой» блог с полным контролем (и готовы к минимальной разработке)**

1. **Стек**:  
   - Backend: Go (например, простой HTTP-сервер с шаблонами `html/template`)  
   - Frontend: базовый HTML/CSS (Tailwind CDN — без сборки)  
   - Контент: Markdown → рендер через [goldmark](https://github.com/yuin/goldmark)  
   - Хостинг: VPS (например, Hetzner Cloud €4.5/мес) + Caddy/nginx  
   - CI/CD: GitHub Actions → сборка и деплой через `scp` или `rsync`

2. **Шаблон-стартер**:  
   - [qvl/astro-blog](https://github.com/qvl/astro-blog)  
   - [spf13/hugo-templates](https://github.com/spf13/hugo-templates)  
   - [go-blog-starter](https://github.com/ribice/golang-clean-arch) (если хочется полноценный Go API + SSR)

---

### 🔚 Рекомендация от меня (с учётом вашего профиля):

> 🚀 **Начните с Hugo + GitHub Pages**  
> - Просто, бесплатно, быстро  
> - Контент хранится в Git — как код  
> - Можно позже добавить API, форму комментариев (через [Utterances](https://utteranc.es/) или [Giscus](https://giscus.app))  
> - Всё это легко автоматизировать через Makefile и CI (вы уже этим занимаетесь)

___

Меня не пришлось долго уговаривать, я выбрал Hugo.
Перейдем к описанию того, что необходимо сделать для того, чтобы получить такой блог, который сейчас перед вашими глазами.
- [Установка Hugo](#установка-hugo)
  - [Для Linux (Ubuntu/Debian)](#для-linux-ubuntudebian)
- [Создание нового блога](#создание-нового-блога)
- [Создание и редактирование постов](#создание-и-редактирование-постов)
  - [Создание нового поста](#создание-нового-поста)
  - [Параметры front matter](#параметры-front-matter)
  - [Пример полного поста](#пример-полного-поста)
  - [Редактирование существующего поста](#редактирование-существующего-поста)
  - [Полезные команды для работы с постами](#полезные-команды-для-работы-с-постами)
- [Локальный запуск](#локальный-запуск)
  - [Дополнительные опции запуска](#дополнительные-опции-запуска)
- [Настройка GitHub Pages](#настройка-github-pages)
  - [1. Создание репозитория на GitHub](#1-создание-репозитория-на-github)
  - [2. Настройка GitHub Pages](#2-настройка-github-pages)
  - [3. Настройка workflow](#3-настройка-workflow)
  - [4. Настройка .gitignore](#4-настройка-gitignore)
- [Публикация изменений](#публикация-изменений)
  - [Первая публикация](#первая-публикация)
  - [Публикация новых постов и изменений](#публикация-новых-постов-и-изменений)
- [Полезные команды](#полезные-команды)
- [Дополнительные ресурсы](#дополнительные-ресурсы)

## Установка Hugo

### Для Linux (Ubuntu/Debian)

1. **Скачайте последнюю версию Hugo Extended** (важно: нужна именно Extended версия для поддержки темы PaperMod):

```bash
# Узнайте последнюю версию на https://github.com/gohugoio/hugo/releases
# Например, для версии 0.146.0:
wget wget https://github.com/gohugoio/hugo/releases/download/v0.148.0/hugo_extended_0.148.0_linux-amd64.deb

```

2. **Установите пакет**:

```bash
sudo dpkg -i hugo_extended_0.148.0_linux-amd64.deb
```

3. **Проверьте установку**:

```bash
hugo version
```

Должно вывести:
```text
hugo v0.148.0+extended linux/amd64 BuildDate=...
```


## Создание нового блога

1. **Создайте директорию для проекта**:

```bash
mkdir -p ~/projects/myblog
cd ~/projects/myblog
```

2. **Инициализируйте новый сайт Hugo**:

```bash
hugo new site . --force
```

3. **Добавьте тему PaperMod как git submodule**:

```bash
git init
git submodule add -b main https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
```

4. **Создайте файл конфигурации `hugo.toml`**:

```toml
baseURL = 'https://yourusername.github.io/myblog/'
languageCode = "ru-ru"
title = "Заголовок Вашего блога"
theme = "PaperMod"

[params]
  author = "ваше_имя"
  description = "Описание Вашего блога"
  defaultTheme = "auto"  # light/dark/auto

[markup.highlight]
  noClasses = false
```

**Важно**: Замените `yourusername` на ваш GitHub username и `myblog` на название вашего репозитория.

5. **Создайте первую директорию для постов**:

```bash
mkdir -p content/posts
```

6. **Создайте первый пост** (см. раздел [Создание постов](#создание-и-редактирование-постов))

## Создание и редактирование постов

### Создание нового поста

1. **Создайте новый файл в директории `content/posts/`**:

```bash
hugo new posts/nazvanie-vashego-posta.md
```

Или создайте файл вручную:

```bash
nano content/posts/nazvanie-vashego-posta.md
```

2. **Структура файла поста**:

```markdown
---
title: "Заголовок вашего поста"
date: 2025-12-06T10:00:00+03:00
draft: false
---

Ваш контент здесь. Вы можете использовать **Markdown** синтаксис.

## Заголовок второго уровня

- Список
- Элементов

**Жирный текст**, *курсив*, `код`.

```go
// Пример кода
func main() {
    fmt.Println("Hello, World!")
}
```


### Параметры front matter

- `title` - заголовок поста
- `date` - дата публикации (формат: `2025-12-06T10:00:00+03:00`)
- `draft` - черновик (`true`/`false`). Если `true`, пост не будет показан на сайте
- `tags` - теги (опционально): `tags: ["go", "hugo", "блог"]`
- `categories` - категории (опционально): `categories: ["разработка"]`

### Пример полного поста

```markdown
---
title: "Почему я завёл этот блог"
date: 2025-12-06T10:00:00+03:00
draft: false
tags: ["блог", "размышления"]
categories: ["личное"]
---

Всем привет! 👋

Это мой первый пост в личном блоге.

## Подзаголовок

Текст с **жирным** и *курсивом*.

- Список
- Элементов

```go
func example() {
    // код
}
```

### Редактирование существующего поста

1. **Откройте файл поста**:

```bash
nano content/posts/moy-pervyj-post.md
```

Или используйте любой текстовый редактор (VS Code, vim, gedit и т.д.)

2. **Внесите изменения и сохраните**

3. **Проверьте результат локально** (см. раздел [Локальный запуск](#локальный-запуск))

### Полезные команды для работы с постами

```bash
# Создать новый пост с шаблоном
hugo new posts/nazvanie-posta.md

# Создать пост в черновике (draft: true)
hugo new posts/chernovik.md --buildDrafts

# Показать все посты (включая черновики)
hugo list drafts
```

##  Локальный запуск

1. **Запустите локальный сервер разработки**:

```bash
cd ~/projects/myblog
hugo server -D
```

Флаг `-D` включает черновики (посты с `draft: true`).

2. **Откройте браузер** и перейдите по адресу:

```text
http://localhost:1313
```

3. **Автоматическая перезагрузка**: Hugo автоматически перезагружает страницу при изменении файлов.

4. **Остановка сервера**: Нажмите `Ctrl+C` в терминале.

### Дополнительные опции запуска

```bash
# Запуск на другом порту
hugo server -D -p 8080

# Запуск с привязкой к внешнему IP (для доступа с других устройств)
hugo server -D --bind 0.0.0.0

# Запуск с минификацией (как в production)
hugo server -D --minify
```

##  Настройка GitHub Pages

### 1. Создание репозитория на GitHub

1. Создайте новый репозиторий на GitHub (например, `myblog`)
2. **Важно**: Название репозитория должно совпадать с путем в `baseURL` в `hugo.toml`

### 2. Настройка GitHub Pages

1. Перейдите в **Settings** → **Pages** вашего репозитоапараметррия
2. В разделе **Source** выберите **GitHub Actions**

### 3. Настройка workflow

Workflow файл уже должен быть создан в `.github/workflows/deploy.yml`. Проверьте, что он содержит:

```yaml
name: Deploy Blog to GitHub Pages

on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true
          fetch-depth: 0

      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: '0.146.0'
          extended: true

      - name: Build
        run: hugo --minify --baseURL ${{ steps.pages.outputs.base_url }}

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 4. Настройка .gitignore

Убедитесь, что в `.gitignore` есть:

```text
/public
/resources
.hugo_build.lock
```

## Публикация изменений

### Первая публикация

1. **Инициализируйте git репозиторий** (если еще не сделано):

```bash
cd ~/projects/myblog
git init
```

2. **Добавьте удаленный репозиторий**:

```bash
git remote add origin https://github.com/yourusername/myblog.git
```

3. **Добавьте все файлы**:

```bash
git add .
```

4. **Создайте первый коммит**:

```bash
git commit -m "Initial commit: Hugo blog setup"
```

5. **Запушьте в main ветку**:

```bash
git branch -M main
git push -u origin main
```

### Публикация новых постов и изменений

1. **Создайте или отредактируйте пост** (см. раздел [Создание постов](#создание-и-редактирование-постов))

2. **Проверьте локально**:

```bash
hugo server -D
```

3. **Убедитесь, что `draft: false`** в файле поста

4. **Закоммитьте и запушьте изменения**:

```bash
git add .
git commit -m "Добавлен новый пост: название поста"
git push
```

5. **GitHub Actions автоматически соберет и задеплоит сайт**

6. **Проверьте статус деплоя**:
   - Перейдите в **Actions** вкладку вашего репозитория на GitHub
   - Дождитесь завершения workflow (обычно 1-2 минуты)

7. **Сайт будет доступен** по адресу: `https://yourusername.github.io/myblog/`

##  Полезные команды

```bash
# Сборка сайта для production
hugo --minify

# Сборка с включением черновиков
hugo -D --minify

# Показать статистику сайта
hugo --templateMetrics

# Очистить кэш и пересобрать
hugo --cleanDestinationDir

# Показать все посты
hugo list all
```

## Дополнительные ресурсы

- [Документация Hugo](https://gohugo.io/documentation/)
- [Документация темы PaperMod](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [Markdown синтаксис](https://www.markdownguide.org/)
- [GitHub Pages документация](https://docs.github.com/en/pages)

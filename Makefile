.PHONY: help server server-drafts build build-drafts new-post clean deploy submodule-update check

# Переменные
HUGO_VERSION := 0.146.0
POSTS_DIR := content/posts

# Цвета для вывода
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

help: ## Показать справку по командам
	@echo "$(GREEN)Доступные команды:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(NC) %s\n", $$1, $$2}'

server: ## Запустить локальный сервер разработки (без черновиков)
	@echo "$(GREEN)Запуск Hugo сервера на http://localhost:1313$(NC)"
	hugo server

server-drafts: ## Запустить локальный сервер с черновиками
	@echo "$(GREEN)Запуск Hugo сервера с черновиками на http://localhost:1313$(NC)"
	hugo server -D

server-bind: ## Запустить сервер с доступом из сети (0.0.0.0)
	@echo "$(GREEN)Запуск Hugo сервера на 0.0.0.0:1313$(NC)"
	hugo server --bind 0.0.0.0 -D

build: ## Собрать сайт для production (без черновиков)
	@echo "$(GREEN)Сборка сайта...$(NC)"
	hugo --minify
	@echo "$(GREEN)Сборка завершена! Результат в директории public/$(NC)"

build-drafts: ## Собрать сайт с черновиками
	@echo "$(GREEN)Сборка сайта с черновиками...$(NC)"
	hugo -D --minify
	@echo "$(GREEN)Сборка завершена! Результат в директории public/$(NC)"

new-post: ## Создать новый пост (использование: make new-post POST=название-поста)
	@if [ -z "$(POST)" ]; then \
		echo "$(YELLOW)Ошибка: укажите название поста$(NC)"; \
		echo "Использование: make new-post POST=название-поста"; \
		exit 1; \
	fi
	@echo "$(GREEN)Создание нового поста: $(POST)$(NC)"
	hugo new posts/$(POST).md
	@echo "$(GREEN)Пост создан: content/posts/$(POST).md$(NC)"
	@echo "$(YELLOW)Не забудьте изменить draft: false перед публикацией!$(NC)"

clean: ## Очистить сгенерированные файлы
	@echo "$(GREEN)Очистка директории public/...$(NC)"
	rm -rf public/
	@echo "$(GREEN)Очистка завершена!$(NC)"

clean-all: clean ## Очистить все (включая кэш и ресурсы)
	@echo "$(GREEN)Очистка всех временных файлов...$(NC)"
	rm -rf resources/
	rm -f .hugo_build.lock
	@echo "$(GREEN)Полная очистка завершена!$(NC)"

deploy: build ## Собрать и задеплоить на GitHub Pages
	@echo "$(GREEN)Подготовка к деплою...$(NC)"
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "$(YELLOW)Нет изменений для коммита$(NC)"; \
	else \
		echo "$(GREEN)Обнаружены изменения. Не забудьте закоммитить и запушить:$(NC)"; \
		echo "  git add ."; \
		echo "  git commit -m 'Ваше сообщение'"; \
		echo "  git push"; \
	fi
	@echo "$(GREEN)После git push GitHub Actions автоматически задеплоит сайт$(NC)"

submodule-update: ## Обновить git submodules (тему PaperMod)
	@echo "$(GREEN)Обновление git submodules...$(NC)"
	git submodule update --init --recursive
	@echo "$(GREEN)Submodules обновлены!$(NC)"

submodule-update-remote: ## Обновить тему PaperMod до последней версии
	@echo "$(GREEN)Обновление темы PaperMod до последней версии...$(NC)"
	git submodule update --remote --merge themes/PaperMod
	@echo "$(GREEN)Тема обновлена!$(NC)"

check: ## Проверить конфигурацию Hugo
	@echo "$(GREEN)Проверка конфигурации Hugo...$(NC)"
	hugo config
	@echo "$(GREEN)Проверка завершена!$(NC)"

stats: ## Показать статистику сайта
	@echo "$(GREEN)Статистика сайта:$(NC)"
	hugo --templateMetrics

list-posts: ## Показать все посты
	@echo "$(GREEN)Список всех постов:$(NC)"
	@find $(POSTS_DIR) -name "*.md" -type f | sort

list-drafts: ## Показать все черновики
	@echo "$(GREEN)Список черновиков:$(NC)"
	hugo list drafts

validate: ## Проверить валидность контента
	@echo "$(GREEN)Проверка валидности контента...$(NC)"
	hugo --quiet
	@echo "$(GREEN)Проверка завершена!$(NC)"

preview: build ## Предпросмотр собранного сайта (требует Python)
	@echo "$(GREEN)Запуск предпросмотра на http://localhost:8000$(NC)"
	@cd public && python3 -m http.server 8000 || python -m SimpleHTTPServer 8000

install-hugo: ## Показать инструкцию по установке Hugo
	@echo "$(GREEN)Инструкция по установке Hugo Extended:$(NC)"
	@echo ""
	@echo "Для Linux (Ubuntu/Debian):"
	@echo "  wget https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_linux-amd64.deb"
	@echo "  sudo dpkg -i hugo_extended_$(HUGO_VERSION)_linux-amd64.deb"
	@echo ""
	@echo "Проверка установки:"
	@echo "  hugo version"

# Команда по умолчанию
.DEFAULT_GOAL := help


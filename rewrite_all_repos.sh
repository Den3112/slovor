#!/bin/bash

################################################################################
# Скрипт для переписывания Git истории во всех репозиториях Den3112
# Заменяет старый email на GitHub noreply email
# Создает бэкапы перед переписыванием
################################################################################

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Параметры для замены
OLD_EMAIL="denis.kushnirenko@pathtoproject.com"
CORRECT_NAME="Den3112"
CORRECT_EMAIL="43961326+Den3112@users.noreply.github.com"
GITHUB_USER="Den3112"

# Счетчики
TOTAL=0
SUCCESS=0
SKIPPED=0
FAILED=0

# Функция для вывода заголовка
print_header() {
    echo -e "${BLUE}===============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}===============================================================================${NC}"
}

# Функция для вывода успеха
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Функция для вывода ошибки
print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Функция для вывода предупреждения
print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Функция для вывода информации
print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Функция для обработки одного репозитория
process_repo() {
    local repo_name=$1
    local repo_url="https://github.com/${GITHUB_USER}/${repo_name}.git"
    
    echo ""
    print_info "Обработка репозитория: $repo_name"
    
    # Клонировать или обновить
    if [ -d "$repo_name" ]; then
        print_info "Репозиторий уже существует, обновляю..."
        cd "$repo_name"
        git fetch origin 2>/dev/null || {
            print_error "Не удалось обновить $repo_name"
            cd ..
            ((FAILED++))
            return 1
        }
    else
        print_info "Клонирую репозиторий..."
        git clone "$repo_url" 2>/dev/null || {
            print_error "Не удалось клонировать $repo_name"
            ((FAILED++))
            return 1
        }
        cd "$repo_name"
    fi
    
    # Проверить, есть ли коммиты с старым email
    local has_old_email=$(git log --all --pretty=format:"%ae" | grep -c "$OLD_EMAIL" 2>/dev/null || echo 0)
    
    if [ "$has_old_email" -eq 0 ]; then
        print_warning "Нет коммитов с старым email - пропускаю"
        cd ..
        ((SKIPPED++))
        return 0
    fi
    
    print_info "Найдено $has_old_email коммитов с старым email"
    
    # Создать бэкап
    print_info "Создаю бэкап..."
    git branch backup-before-rewrite 2>/dev/null || true
    git push origin backup-before-rewrite 2>/dev/null || {
        print_warning "Не удалось запушить бэкап (может быть, уже существует)"
    }
    
    # Переписать историю
    print_info "Переписываю историю..."
    git filter-branch --env-filter "
OLD_EMAIL='$OLD_EMAIL'
CORRECT_NAME='$CORRECT_NAME'
CORRECT_EMAIL='$CORRECT_EMAIL'
if [ \"\$GIT_COMMITTER_EMAIL\" = \"\$OLD_EMAIL\" ]; then
export GIT_COMMITTER_NAME=\"\$CORRECT_NAME\"
export GIT_COMMITTER_EMAIL=\"\$CORRECT_EMAIL\"
fi
if [ \"\$GIT_AUTHOR_EMAIL\" = \"\$OLD_EMAIL\" ]; then
export GIT_AUTHOR_NAME=\"\$CORRECT_NAME\"
export GIT_AUTHOR_EMAIL=\"\$CORRECT_EMAIL\"
fi
" --tag-name-filter cat -- --branches --tags 2>/dev/null || {
        print_error "Ошибка при переписывании истории"
        cd ..
        ((FAILED++))
        return 1
    }
    
    # Очистить рефлог
    print_info "Очищаю рефлог..."
    git reflog expire --expire-unreachable=now --all 2>/dev/null
    git gc --aggressive --prune=now 2>/dev/null
    
    # Проверить результат
    print_info "Проверяю результат..."
    local result=$(git log --all --pretty=format:"%an <%ae>" | sort | uniq)
    
    if echo "$result" | grep -q "$CORRECT_EMAIL" && ! echo "$result" | grep -q "$OLD_EMAIL"; then
        print_success "История переписана успешно"
    else
        print_error "Ошибка при проверке результата"
        cd ..
        ((FAILED++))
        return 1
    fi
    
    # Запушить на GitHub
    print_info "Запушиваю на GitHub..."
    git push --force --all origin 2>/dev/null || {
        print_error "Ошибка при push --force --all"
        cd ..
        ((FAILED++))
        return 1
    }
    
    git push --force --tags origin 2>/dev/null || {
        print_error "Ошибка при push --force --tags"
        cd ..
        ((FAILED++))
        return 1
    }
    
    print_success "$repo_name завершен"
    cd ..
    ((SUCCESS++))
    return 0
}

# Основная программа
main() {
    print_header "Переписывание Git истории во всех репозиториях Den3112"
    
    echo ""
    print_info "Параметры:"
    echo "  Старый email: $OLD_EMAIL"
    echo "  Новое имя: $CORRECT_NAME"
    echo "  Новый email: $CORRECT_EMAIL"
    echo ""
    
    # Проверить, установлен ли git
    if ! command -v git &> /dev/null; then
        print_error "Git не установлен"
        exit 1
    fi
    
    # Получить список репозиториев
    print_info "Получаю список репозиториев..."
    
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) не установлен"
        echo ""
        echo "Установка GitHub CLI:"
        echo "  Windows (Chocolatey): choco install gh"
        echo "  Windows (Scoop): scoop install gh"
        echo "  macOS (Homebrew): brew install gh"
        echo "  Linux (Debian/Ubuntu): sudo apt install gh"
        echo "  Linux (Fedora): sudo dnf install gh"
        echo ""
        echo "После установки выполни: gh auth login"
        exit 1
    fi
    
    # Получить список репозиториев
    local repos=$(gh repo list "$GITHUB_USER" --limit 100 --json name --jq '.[].name' 2>/dev/null)
    
    if [ -z "$repos" ]; then
        print_error "Не удалось получить список репозиториев"
        exit 1
    fi
    
    # Подсчитать количество репозиториев
    local repo_count=$(echo "$repos" | wc -l)
    print_info "Найдено $repo_count репозиториев"
    echo ""
    
    # Запросить подтверждение
    echo -e "${YELLOW}Внимание! Это переписывает Git историю во всех репозиториях!${NC}"
    echo -e "${YELLOW}Это НЕОБРАТИМО и потребует git push --force!${NC}"
    echo ""
    read -p "Продолжить? (y/n) " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Отменено пользователем"
        exit 0
    fi
    
    # Создать рабочую директорию
    local work_dir="rewrite_work_$(date +%s)"
    mkdir -p "$work_dir"
    cd "$work_dir"
    
    print_info "Рабочая директория: $(pwd)"
    echo ""
    
    # Обработать каждый репозиторий
    ((TOTAL=0))
    while IFS= read -r repo; do
        if [ -n "$repo" ]; then
            ((TOTAL++))
            process_repo "$repo"
        fi
    done <<< "$repos"
    
    # Вернуться в исходную директорию
    cd ..
    
    # Вывести итоги
    echo ""
    print_header "Итоги переписывания"
    
    echo "Всего репозиториев:      $TOTAL"
    echo -e "Успешно обработано:     ${GREEN}$SUCCESS${NC}"
    echo -e "Пропущено:              ${YELLOW}$SKIPPED${NC}"
    echo -e "Ошибок:                 ${RED}$FAILED${NC}"
    
    echo ""
    print_info "Рабочая директория: $work_dir"
    print_info "Все репозитории находятся в: $(pwd)/$work_dir"
    
    echo ""
    if [ $FAILED -eq 0 ]; then
        print_success "Переписывание завершено успешно!"
    else
        print_error "Переписывание завершено с ошибками"
        exit 1
    fi
}

# Запустить основную программу
main "$@"

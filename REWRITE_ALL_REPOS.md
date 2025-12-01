# План переписывания истории во всех репозиториях

**Дата:** 30 ноября 2025  
**Статус:** slovor-frontend ✅ ЗАВЕРШЕНО  
**Следующий шаг:** Применить к остальным репозиториям

---

## 📋 Шаг 1: Получить список всех репозиториев

### Способ 1: Через GitHub API (рекомендуется)

```bash
# Требует GitHub Token
curl -H "Authorization: token YOUR_GITHUB_TOKEN" \
  https://api.github.com/user/repos?per_page=100 | jq '.[].name'
```

**Как получить GitHub Token:**

1. Перейди на https://github.com/settings/tokens
2. Нажми "Generate new token"
3. Выбери scopes: `repo`, `admin:repo_hook`
4. Скопируй токен

### Способ 2: Вручную на GitHub

1. Откройте https://github.com/Den3112?tab=repositories
2. Скопируйте названия всех репозиториев

---

## 🔄 Шаг 2: Для каждого репозитория выполни

### 2.1 Клонировать репозиторий

```bash
git clone https://github.com/Den3112/REPO_NAME.git
cd REPO_NAME
```

### 2.2 Создать бэкап

```bash
git branch backup-before-rewrite
git push origin backup-before-rewrite
```

### 2.3 Переписать историю

```bash
git filter-branch --env-filter '
OLD_EMAIL="denis.kushnirenko@pathtoproject.com"
CORRECT_NAME="Den3112"
CORRECT_EMAIL="43961326+Den3112@users.noreply.github.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]; then
export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]; then
export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

### 2.4 Очистить рефлог

```bash
git reflog expire --expire-unreachable=now --all
git gc --aggressive --prune=now
```

### 2.5 Проверить результат

```bash
git log --all --pretty=format:"%an <%ae>" | sort | uniq
```

**Должно показать только:**

```
Den3112 <43961326+Den3112@users.noreply.github.com>
```

### 2.6 Запушить на GitHub

```bash
git push --force --all origin
git push --force --tags origin
```

---

## 🤖 Шаг 3: Автоматизация (bash скрипт)

### Создать файл rewrite_all.sh

```bash
#!/bin/bash

# Список репозиториев для переписывания
REPOS=(
    "slovor-frontend"
    "slovor-backend"
    "slovor-mobile"
    # Добавь остальные репозитории
)

# Параметры для замены
OLD_EMAIL="denis.kushnirenko@pathtoproject.com"
CORRECT_NAME="Den3112"
CORRECT_EMAIL="43961326+Den3112@users.noreply.github.com"

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Начало переписывания истории всех репозиториев ===${NC}"
echo ""

for repo in "${REPOS[@]}"; do
    echo -e "${YELLOW}Обработка: $repo${NC}"

    # Клонировать
    if [ -d "$repo" ]; then
        echo "  Репозиторий уже существует, обновляю..."
        cd "$repo"
        git fetch origin
    else
        echo "  Клонирую репозиторий..."
        git clone "https://github.com/Den3112/$repo.git"
        cd "$repo"
    fi

    # Создать бэкап
    echo "  Создаю бэкап..."
    git branch backup-before-rewrite 2>/dev/null || true
    git push origin backup-before-rewrite 2>/dev/null || true

    # Переписать историю
    echo "  Переписываю историю..."
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
" --tag-name-filter cat -- --branches --tags 2>/dev/null || true

    # Очистить рефлог
    echo "  Очищаю рефлог..."
    git reflog expire --expire-unreachable=now --all
    git gc --aggressive --prune=now

    # Проверить результат
    echo "  Проверяю результат..."
    RESULT=$(git log --all --pretty=format:"%an <%ae>" | sort | uniq)
    if [[ "$RESULT" == *"$CORRECT_EMAIL"* ]] && [[ "$RESULT" != *"$OLD_EMAIL"* ]]; then
        echo -e "  ${GREEN}✓ История переписана успешно${NC}"
    else
        echo -e "  ${RED}✗ Ошибка при переписывании${NC}"
        cd ..
        continue
    fi

    # Запушить
    echo "  Запушиваю на GitHub..."
    git push --force --all origin
    git push --force --tags origin

    echo -e "  ${GREEN}✓ $repo завершен${NC}"
    echo ""

    cd ..
done

echo -e "${GREEN}=== Переписывание завершено ===${NC}"
```

### Использование скрипта

```bash
# Сделать скрипт исполняемым
chmod +x rewrite_all.sh

# Запустить
./rewrite_all.sh
```

---

## 📊 Шаг 4: Проверка результатов

### Для каждого репозитория проверить:

```bash
# Проверить авторов
git log --all --pretty=format:"%an <%ae>" | sort | uniq

# Проверить, что нет старого email
git log --all --pretty=format:"%an <%ae>" | grep "pathtoproject"

# Проверить количество коммитов
git log --all --oneline | wc -l

# Проверить, что бэкап создан
git branch -a | grep backup
```

---

## ⚠️ Важные замечания

### Риски:

- 🔴 **ОПАСНО:** git push --force удалит старую историю
- 🔴 **ОПАСНО:** Сломает ссылки на старые коммиты
- 🔴 **ОПАСНО:** Конфликтует с локальными репо других разработчиков
- 🔴 **ОПАСНО:** Невозможно отменить без бэкапа

### Безопасность:

- ✅ Всегда создавай бэкап перед переписыванием
- ✅ Проверяй результат перед git push --force
- ✅ Уведоми команду перед force push
- ✅ Сохрани бэкап ветки на GitHub

### Требования:

- ✅ Git 2.9+
- ✅ Доступ к GitHub (для push --force)
- ✅ Время (переписывание может занять время)

---

## 📋 Чек-лист для каждого репозитория

- [ ] Клонирован репозиторий
- [ ] Создан бэкап (backup-before-rewrite)
- [ ] Бэкап запушен на GitHub
- [ ] Выполнен git filter-branch
- [ ] Очищен рефлог (git gc)
- [ ] Проверен результат (только Den3112)
- [ ] Выполнен git push --force
- [ ] Проверена история на GitHub

---

## 🎯 Статус переписывания

| Репозиторий     | Статус       | Дата       | Бэкап                    |
| --------------- | ------------ | ---------- | ------------------------ |
| slovor-frontend | ✅ ЗАВЕРШЕНО | 30.11.2025 | ✅ backup-before-rewrite |
| slovor-backend  | ⏳ ОЖИДАНИЕ  | -          | -                        |
| slovor-mobile   | ⏳ ОЖИДАНИЕ  | -          | -                        |
| (остальные)     | ⏳ ОЖИДАНИЕ  | -          | -                        |

---

## 📞 Контакты и ресурсы

- **GitHub профиль:** https://github.com/Den3112
- **GitHub Settings:** https://github.com/settings/tokens
- **Git Filter Branch Docs:** https://git-scm.com/docs/git-filter-branch
- **Git Filter Repo:** https://github.com/newren/git-filter-repo

---

## 📝 Примечания

### Для slovor-frontend:

- ✅ История переписана
- ✅ Все коммиты с новым автором Den3112
- ✅ Все упоминания pathtoproject удалены
- ✅ Запушено на GitHub с force flag
- ✅ Бэкап доступен в ветке backup-before-rewrite

### Для остальных репозиториев:

- Используй этот план
- Следуй чек-листу
- Проверяй результат перед push
- Обновляй таблицу статуса

---

**Последнее обновление:** 30 ноября 2025  
**Автор:** Den3112  
**Версия:** 1.0

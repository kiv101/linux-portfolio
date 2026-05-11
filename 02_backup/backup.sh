#!/bin/bash

# ========================================
# backup.sh - Резервное копирование папок
# ========================================

# Настройки (меняй под себя)
SOURCE_DIR="$HOME/portfolio/01_scripts"   # что бэкапим
BACKUP_DIR="$HOME/backups"                # куда кладём
DATE=$(date +"%Y-%m-%d_%H-%M-%S")         # метка времени
BACKUP_NAME="backup_scripts_$DATE.tar.gz" # имя архива

# Создаём папку для бэкапов, если её нет
mkdir -p "$BACKUP_DIR"

# Делаем архив (сжатую копию исходной папки)
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR" 2>/dev/null

# Проверяем, получилось ли
if [ $? -eq 0 ]; then
    # Узнаём размер архива
    SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
    echo "✅ Бэкап успешно создан!"
    echo "   📁 Путь: $BACKUP_DIR/$BACKUP_NAME"
    echo "   💾 Размер: $SIZE"
    
    # Показываем список всех бэкапов в папке
    echo ""
    echo "📋 Все бэкапы в папке $BACKUP_DIR:"
    ls -lh "$BACKUP_DIR" | grep "backup_scripts"
else
    echo "❌ Ошибка: бэкап не создан"
    exit 1
fi

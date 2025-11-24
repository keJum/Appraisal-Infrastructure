# Инфраструктура
Проект для разворачивания тестовых заданий в локальной, тестовой среде и продовой.

# Проект Appraisal Service
Стек:
- PHP 8.4
- MySQL 8
- Symfony 7.3

# Разворачивание
1. В папке data/Appraisal-Service `$mv .env.example .env`
2. В папке www/site/apps `$git clone {site} Appraisal-Service`
3. Добавить права на исполнение файлу "service.sh", для этого в корне проекта `$chmod +x ./service.sh`
4. В корне проекта выполнить `$./service.sh rebuild Appraisal-Service`
5. Перейти по адрессу localhost:8080
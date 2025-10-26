### Hexlet tests and linter status:
[![Actions Status](https://github.com/Staffelhof/devops-for-developers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Staffelhof/devops-for-developers-project-77/actions)

### Описание

Проект демонстрирует автоматизацию полного цикла развертывания инфраструктуры и приложений в облачной среде Yandex Cloud.
Инфраструктурные компоненты создаются через Terraform, а установка и настройка программного обеспечения выполняются с помощью Ansible.
Для отслеживания работоспособности системы используется система мониторинга DataDog.

**Основные элементы инфраструктуры:**

- Две виртуальные машины на базе Ubuntu 22.04 LTS
- Балансировщик трафика для распределения нагрузки
- Управляемый кластер базы данных PostgreSQL

### Начало работы

#### 1. Получение исходного кода

```bash
git clone https://github.com/Staffelhof/devops-for-developers-project-77.git
cd devops-for-developers-project-77
```

#### 2. Подготовка облачной платформы

- Пройдите регистрацию в Yandex Cloud
- Создайте сервисный аккаунт и рабочий каталог, получите авторизационный токен
- Подготовьте файл с конфиденциальными настройками terraform/template.secret.auto.tfvars`:

   ```bash
   cp terraform/template.secret.auto.tfvars terraform/secret.auto.tfvars
   ```

- Заполните параметры облака в файле terraform/secret.auto.tfvars в переменных yc_*
- Настройте удаленное хранилище для сохранения состояния инфраструктуры
- Создайте конфигурацию бэкенда:

   ```bash
   cp terraform/template.secret.backend.tfvars terraform/secret.backend.tfvars
   ```
- Внесите данные облачного хранилища в  `terraform/secret.backend.tfvars`

### Установка необходимых инструментов

#### 1. Terraform

[https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

#### 2. Подготовка окружения Ansible

```bash
sudo apt update
sudo apt install -y ansible python3-pip
pip3 install docker ansible-vault
make a-install-deps
```

#### 3. Дополнительная настройка

- Заполните недостающие конфиденциальные параметры в `terraform/secret.auto.tfvars`

### Создание облачной инфраструктуры

Подготовьте рабочую директорию Terraform к работе и запустите создание облачной инфраструкты
  ```bash
  make terraform-init
  ```
  ```bash
  make terraform-apply
  ```

### Установка приложения

```bash
make deploy
```

#### :link: [Ссылка](https://staffelhof.ru) на задеплоенное приложение
# Gitlab Runner - Terraform configuration
Конфигурация инфраструктуры автомасштабируемого Gitlab раннера в GCP.

## Описание инфраструктуры
Вся инфраструктура разварачивается в отдельной [сети network](./network.tf).
В сети открыты следующие порты для INGRESS трафика:

| Порт      | Тип | Target        | Source |
|-----------|-----|---------------|--------|
|SSH 22     | TCP | Тэг: `ssh` | Range: `0.0.0.0/0` |
|Docker 2376| TCP | Тэг: `docker` | Тэг: `docker-machine` |

В сети выделена [подсеть subnetwork](./network.tf).
В данной подсети создается [инстанс main_runner_host](./main.tf).
Инстанс обладает выделенным статическим адресом [main_runner_external_static](./network.tf).

## Запуск

### Требования
 * Требуется созданный Google Cloud Storage для хранения стейта terraform. Описывается в [backend.tf](backend.tf)

### Обязательные переменные
 * `project_id` - ID проекта в GCP
 * `main_runner_ssh_key` - публичный ключ для SSH соединения с хостами


## Terraform Outputs
 * `main_runner_ip` - IP адрес созданного Gitlab Runner инстанса.

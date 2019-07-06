# Pavel Puchok - Otus DevOps - Final Project

## Gitlab CI/CD
Используется SaaS версия GitLab.

### Pipeline Stages

#### build-prerequisites
На этапе `build-prerequisites` собираются Docker образы, необходимые для использования в процессе пайплайна. Образы тэггируются названием ветки в которой происходит сборка. Данные образы требуются только в процессе работы пайплайна, поэтому версионирование тэгов не требуется.

Образы которые собираются:
 * [ansible docker image](/gitlab/dockerfiles/ansible)
 * [terraform docker image](/gitlab/dockerfiles/terraform)


API Gateway + Log collecting (Elasticsearch\Vector\Kibana) + Monitoring (Prometheus\Grafana)



# Как запускать
После написания nginx.conf для запуска выполните команду
```
docker-compose up --build
```

# ENV
## Elasticsearch
EK_NEWUSER_NAME - Логин для доступа в Kibana
EK_NEWUSER_PWD  - Пароль для доступа в Kibana
KIBANA_EXT_PORT - Внешний порт для интерейса Kibana


## Grafana
GRAFANA_ADMIN_USER - Логин для доступа в Grafana
GRAFANA_ADMIN_PASSWORD - Пароль для доступа в Grafana
GRAFANA_EXT_PORT - Внешний порт для интерейса Grafana

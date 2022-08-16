
# Домашнее задание к занятию "11.02 Микросервисы: принципы"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: API Gateway 

<details>
    <summary style="font-size:18px">Задание:</summary>


Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- Маршрутизация запросов к нужному сервису на основе конфигурации
- Возможность проверки аутентификационной информации в запросах
- Обеспечение терминации HTTPS

Обоснуйте свой выбор.

</details>


<details>
    <summary style="font-size:18px">Ответ:</summary>

Product\Func            | https | auth  | DeclConf  | FCPM      | FTPM      |
---                     |:---:  |:---:  |:---:      |:---:      |:---:      |
KrakenD                 |+      |       | +         |           |           |
Yandex API Gateway      | +     | +     | +         | 1M        | >10Gb/h   |
Azure API Management    | +     | +     | +         |1M         | -         |
Amazon API Gateway      | +     | +     | +         |1M         | -         |
Oracle API Gateway      | +     | +     | +         | 30d trial | 30d trial |
Google API Gateway      | +     | +     | +         | 2M        | -         |
SberCloud API Gateway   | +     | +     | +         | -         | -         |
Kong API Gateway        | +     | +     | +         |1M         |unlim      |
Tyk API Gateway         | +     | +     | +         | 250k      | 2.5Gb     |
SelfCreated (nginx)     | +     | +     | +         |unlim      |unlim      |

*FCPM - Free API Calls per month  
*FTPM - Free Throughput per month
*AG - API Gateway

Выбор того или иного решения API gateway будет обусловлен требованиями проекта и опытом работы команды с продуктом. Для начальных проектом можно воспользоваться готовыми облачными решениями с бесплатным функционалом, когда требуется быстрый запуск продукта и минимальные затраты на его использование. Построение собственного решения AG имеет смысл, когда затраты на использование готового продукта будут превышать затраты на разработку и сопровождение собственного решения AG.


</details>


---

## Задача 2: Брокер сообщений

<details>
    <summary style="font-size:18px">Задача:</summary>


Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- Поддержка кластеризации для обеспечения надежности
- Хранение сообщений на диске в процессе доставки
- Высокая скорость работы
- Поддержка различных форматов сообщений
- Разделение прав доступа к различным потокам сообщений
- Простота эксплуатации

Обоснуйте свой выбор.
</details>

<details>
    <summary style="font-size:18px">Ответ:</summary>

Func\Product            | Kafka | RabbitMQ  | Redis  |
---                     |---    |---        |---    |
Кластеризация           |+|+|+|
Хранение на диске       |+|+|-|
Скорость работы         |+|+-|+|
Разнообразие форматов   |+|+|+|
Разделение прав         |+|+|-|
Простота эксплуатации   |+|+|+|

RabbitMQ:  
Сообщения доставляются и методом point-to-point, и методом pub-sub. Поддерживается сложная логика маршрутизации.
При высокой нагрузке возможны некоторые проблемы с производительностью.
Pull-модели доставки сообщений.

Kafka:  
Разработан для обработки данных при высокой пропускной способности и с малой задержкой. Распределенная потоковая платформа Kafka имитирует сервис публикации и подписки (publish-subscribe service). Она обеспечивает постоянное хранение данных и потоков записей, что позволяет обмениваться качественными сообщениями.
Push-модели доставки сообщений.

Redis:  
Высокопроизводительное хранилище данных в памяти, которое можно использовать для хранения ключей, либо как брокер сообщений. Еще одна особенность заключается в том, что Redis не обладает персистентностью.
Push-модели доставки сообщений.

Выбор:  
Выбор решения зависит от целей использования и требований проекта. Например: Redis почти идеально подходит для обмена кратковременными сообщениями, когда не требуется персистентность.Kafka распределенная очередь с высокой пропускной способностью подходит в тех случаях, где требуется персистентность. RabbitMQ брокер со множеством функций и возможностей, поддерживающих сложную маршрутизацию, способен обеспечивать маршрутизацию сообщений при незначительном трафике.


</details>


---

## Задача 3: API Gateway * (необязательная)

<details>
    <summary style="font-size:18px">Задача:</summary>


### Есть три сервиса:

**minio**
- Хранит загруженные файлы в бакете images
- S3 протокол

**uploader**
- Принимает файл, если он картинка сжимает и загружает его в minio
- POST /v1/upload

**security**
- Регистрация пользователя POST /v1/user
- Получение информации о пользователе GET /v1/user
- Логин пользователя POST /v1/token
- Проверка токена GET /v1/token/validation

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/user

**POST /v1/token**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/token

**GET /v1/user**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис security GET /v1/user

**POST /v1/upload**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис uploader POST /v1/upload

**GET /v1/user/{image}**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис minio  GET /images/{image}

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизаци
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

</details>

<details>
    <summary style="font-size:18px">Ответ:</summary>

Проект по дополнительному заданию расположен в [additional](additional/)


    ```
        events {
        worker_connections 1024;
    }

    http {
        
        upstream security {
            server security:3000;
        }
        upstream uploader {
            server uploader:3000;
        }
        upstream storage {
            server storage:9000;
        }

        server {
            listen 80;

            location /register {
                rewrite ^/register(.*)$ /v1/register$1 break;
                proxy_pass http://security/;
            }
            location /token {
                rewrite ^/token(.*)$ /v1/token$1 break;
                proxy_pass http://security/;
            }
            location /user {
                rewrite ^/user(.*)$ /v1/user$1 break;
                proxy_pass http://security/;
            }

            location /auth {
                rewrite ^/auth(.*)$ /v1/token/validation$1 break;
                proxy_pass http://security/;
            }

            location /test {
                auth_request /auth;
                rewrite ^/test(.*)$ /v1/user$1 break;
                proxy_pass http://security/;
                error_page 401 403 @unauthorized;
            }

            location /upload {
                auth_request /auth;
                rewrite ^/upload(.*)$ /v1/upload$1 break;
                proxy_pass http://uploader/;
                error_page 401 403 @unauthorized;
            }

            location /images {
                auth_request /auth;
                rewrite ^/images(.*)$ /data$1 break;
                proxy_pass http://storage/;
                error_page 401 403 @unauthorized;
            }

            location @unauthorized {
                return 401 "unauthorized";
            }
        }
    }
    ```
</details>




---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

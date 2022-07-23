# Домашнее задание к занятию "10.02. Системы мониторинга"

## Обязательные задания

1. Опишите основные плюсы и минусы pull и push систем мониторинга.

    ### Ответ:
    <details>
      <summary style="font-size:14px">Развернуть</summary>
  
        #### PULL
        Плюсы:
        - Идентификация обьекта/легкость контроля поднинности данных (сервер опрашивает обьекты по созданному списку)
        - Более легкая возможность интеграции TLS для защиты трафика
        - Возможность запросить данные по собствнной инициативе вне каких либо графиков.

        Минусы:
        - Необходимо обеспечить безопасность открытого порта приложения уязвимого для DDoS-атак и утечки данных.
        
        #### PUSH
        Плюсы:
        - Возможность использования протокола UDP при отсутсвии необходимости гарантированной доставки данных
        - Возможность нстройки несколько адресатов доставки метрик
        - Возможность гибкой настройки периодичности/агрегации данных
        Минусы:
        - Сложность поиска причины почему объект не передает метрики
        - Вероятность ситуации когда два сервера будут метрики с одними идентификационными данными
      </details>
      

2. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?

    - Prometheus 
    - TICK
    - Zabbix
    - VictoriaMetrics
    - Nagios

    ### Ответ:
    - Prometheus - pull (возможность использования push через Pushgateway)
    - TICK - push модель
    - Zabbix - гибридная(push/pull) модель
    - VictoriaMetrics - гибридная(push/pull) модель
    - Nagios - pull модель

3. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк, 
используя технологии docker и docker-compose.

  В виде решения на это упражнение приведите выводы команд с вашего компьютера (виртуальной машины):

      - curl http://localhost:8086/ping
      - curl http://localhost:8888
      - curl http://localhost:9092/kapacitor/v1/ping

  А также скриншот веб-интерфейса ПО chronograf (`http://localhost:8888`). 

  P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим `Z`, например
  `./data:/var/lib:Z`

### Ответ:

<details>
  <summary style="font-size:14px">Посмотреть вывод</summary>
  
  ```bash
    [vagrant@tick1 sandbox]$ curl http://localhost:8086/ping -v
    * About to connect() to localhost port 8086 (#0)
    *   Trying ::1...
    * Connected to localhost (::1) port 8086 (#0)
    > GET /ping HTTP/1.1
    > User-Agent: curl/7.29.0
    > Host: localhost:8086
    > Accept: */*
    > 
    < HTTP/1.1 204 No Content
    < Content-Type: application/json
    < Request-Id: ff7a0df5-08f2-11ed-8156-0242ac120002
    < X-Influxdb-Build: OSS
    < X-Influxdb-Version: 1.8.10
    < X-Request-Id: ff7a0df5-08f2-11ed-8156-0242ac120002
    < Date: Thu, 21 Jul 2022 12:45:27 GMT
    < 
    * Connection #0 to host localhost left intact

    [vagrant@tick1 sandbox]$ curl http://localhost:8888 -v
    * About to connect() to localhost port 8888 (#0)
    *   Trying ::1...
    * Connected to localhost (::1) port 8888 (#0)
    > GET / HTTP/1.1
    > User-Agent: curl/7.29.0
    > Host: localhost:8888
    > Accept: */*
    > 
    < HTTP/1.1 200 OK
    < Accept-Ranges: bytes
    < Cache-Control: public, max-age=3600
    < Content-Length: 336
    < Content-Security-Policy: script-src 'self'; object-src 'self'
    < Content-Type: text/html; charset=utf-8
    < Etag: "3362220244"
    < Last-Modified: Tue, 22 Mar 2022 20:02:44 GMT
    < Vary: Accept-Encoding
    < X-Chronograf-Version: 1.9.4
    < X-Content-Type-Options: nosniff
    < X-Frame-Options: SAMEORIGIN
    < X-Xss-Protection: 1; mode=block
    < Date: Thu, 21 Jul 2022 12:47:33 GMT
    < 
    * Connection #0 to host localhost left intact
    <!DOCTYPE html><html><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.fa749080.ico"><link rel="stylesheet" href="/src.9cea3e4e.css"></head><body> <div id="react-root" data-basepath=""></div> <script src="/src.a969287c.js"></script> </body></html>

    [vagrant@tick1 sandbox]$ curl http://localhost:9092/kapacitor/v1/ping -v
    * About to connect() to localhost port 9092 (#0)
    *   Trying ::1...
    * Connected to localhost (::1) port 9092 (#0)
    > GET /kapacitor/v1/ping HTTP/1.1
    > User-Agent: curl/7.29.0
    > Host: localhost:9092
    > Accept: */*
    > 
    < HTTP/1.1 204 No Content
    < Content-Type: application/json; charset=utf-8
    < Request-Id: 661e86af-08f3-11ed-8187-000000000000
    < X-Kapacitor-Version: 1.6.4
    < Date: Thu, 21 Jul 2022 12:48:20 GMT
    < 
    * Connection #0 to host localhost left intact
  ```
</details>

<details>
  <summary style="font-size:14px">Скриншот</summary>
  
  ![изображение](https://user-images.githubusercontent.com/93001155/180388324-f8a75938-9e91-444a-8393-4639c6887f9a.png)
</details>


4. Перейдите в веб-интерфейс Chronograf (`http://localhost:8888`) и откройте вкладку `Data explorer`.

    - Нажмите на кнопку `Add a query`
    - Изучите вывод интерфейса и выберите БД `telegraf.autogen`
    - В `measurments` выберите mem->host->telegraf_container_id , а в `fields` выберите used_percent. 
    Внизу появится график утилизации оперативной памяти в контейнере telegraf.
    - Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису. 
    Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.

Для выполнения задания приведите скриншот с отображением метрик утилизации места на диске 
(disk->host->telegraf_container_id) из веб-интерфейса.

### Ответ:
<details>
  <summary style="font-size:14px">Скриншот</summary>

  ![изображение](https://user-images.githubusercontent.com/93001155/180410155-71fa03db-8226-4e7d-ba13-95938258be50.png)
</details>

5. Изучите список [telegraf inputs](https://github.com/influxdata/telegraf/tree/master/plugins/inputs). 
Добавьте в конфигурацию telegraf следующий плагин - [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker):
```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
```

Дополнительно вам может потребоваться донастройка контейнера telegraf в `docker-compose.yml` дополнительного volume и 
режима privileged:
```
  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
```

После настройке перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список `measurments` в 
веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

Факультативно можете изучить какие метрики собирает telegraf после выполнения данного задания.

### Ответ:
<details>
  <summary style="font-size:14px">Скриншот</summary>

  ![изображение](https://user-images.githubusercontent.com/93001155/180593951-bafd50a8-c8f0-485d-a338-27059076aea1.png)

</details>


## Дополнительное задание (со звездочкой*) - необязательно к выполнению

В веб-интерфейсе откройте вкладку `Dashboards`. Попробуйте создать свой dashboard с отображением:

    - утилизации ЦПУ
    - количества использованного RAM
    - утилизации пространства на дисках
    - количество поднятых контейнеров
    - аптайм
    - ...
    - фантазируйте)
    
    ---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---


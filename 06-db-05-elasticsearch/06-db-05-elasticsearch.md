06-db-05-elasticsearch.md

# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

### Ответ:
```
# cat db_es/Dockerfile
FROM centos:7

WORKDIR /opt

RUN groupadd -g 1000 elasticsearch && \
    adduser --uid 1000 --gid 1000 --home /opt/elasticsearch-8.1.1/ elasticsearch && \
    usermod -aG root elasticsearch && \
    yum install wget -y &&\
    wget --no-check-certificate -O /opt/elasticsearch-8.1.1-linux-x86_64.tar.gz https://fossies.org/linux/www/elasticsearch-8.1.1-linux-x86_64.tar.gz &&\
    tar -xzf  /opt/elasticsearch-8.1.1-linux-x86_64.tar.gz &&\
    rm -f elasticsearch-8.1.1-linux-x86_64.tar.gz &&\

    chown -R elasticsearch:elasticsearch /opt/elasticsearch-8.1.1/ &&\
    /opt/elasticsearch-8.1.1/bin/elasticsearch-users useradd elastic_admin -p 123456 -r superuser &&\
    mkdir /var/lib/elasticsearch &&\
    mkdir /var/lib/elasticsearch/data &&\
    mkdir /var/lib/elasticsearch/log &&\
    chown -R elasticsearch:elasticsearch /var/lib/elasticsearch &&\
    echo "path.data: /var/lib/elasticsearch/data" >> /opt/elasticsearch-8.1.1/config/elasticsearch.yml &&\
    echo "path.logs: /var/lib/elasticsearch/log"  >> /opt/elasticsearch-8.1.1/config/elasticsearch.yml &&\
    echo "node.name: netology_test"  >> /opt/elasticsearch-8.1.1/config/elasticsearch.yml



ENV PATH /opt/elasticsearch-8.1.1/bin:$PATH

ENTRYPOINT ["/opt/elasticsearch-8.1.1/bin/elasticsearch"]

USER elasticsearch:root


# cat docker-compose.yaml
version: '2.1'

networks:
  monitoring:
    driver: bridge

services:

 db_es:
         #    restart: always
  volumes:
   - ./db_es/backup:/backup

  build: db_es/

  ports:
    - 9200:9200



# curl -k -u elastic_admin https://localhost:9200
Enter host password for user 'elastic_admin':
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "xBt7Qz4KQmOY1YDwlkzcaw",
  "version" : {
    "number" : "8.1.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "d0925dd6f22e07b935750420a3155db6e5c58381",
    "build_date" : "2022-03-17T22:01:32.658689558Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}

### Образ не стал пушить на hub.docker в связи с ограничениями. Если будет необходимо то можно воспользоваться VPN.

```



## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.


### Ответ:
```

# curl -k -u elastic_admin -X PUT "https://localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "index": {
       "number_of_replicas": 0 ,
       "number_of_shards": 1
     }
   }
 }
 '
Enter host password for user 'elastic_admin':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-1"
}

# curl -k -u elastic_admin -X PUT "https://localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "index": {
       "number_of_replicas": 1 ,
       "number_of_shards": 2
     }
   }
 }
 '
Enter host password for user 'elastic_admin':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-2"
}

# curl -k -u elastic_admin -X PUT "https://localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "index": {
       "number_of_replicas": 2 ,
       "number_of_shards": 4
     }
   }
 }
 '
Enter host password for user 'elastic_admin':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-3"
}

### Список индексов:

# curl -k -u elastic_admin 'https://localhost:9200/_cat/indices?v&pretty'
Enter host password for user 'elastic_admin':
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 BcBm1DJcS6iZj0QD22WUWw   1   0          0            0       225b           225b
yellow open   ind-3 E4IQcx7PTxuRZIIBEJf_Fg   4   2          0            0       900b           900b
yellow open   ind-2 t6zyU7eiT2yr7NiB2neC9g   2   1          0            0       450b           450b

# curl -k -u elastic_admin 'https://localhost:9200/_cluster/health?pretty'
Enter host password for user 'elastic_admin':
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```
Статусы индексов yellow говорят о невозможности обеспечения условий создания индексов. Т.е. при создании мы указали о необходимости использования реплик по определенным индексам, но СУБД не может обеспечить выполнение данного условия в связи с отсутствием в кластере экземпляров на которых можно было бы создать эти реплики.

Статус кластера формируется на основании статуса индексов. Т.е. если есть хотя бы один индекс со статусом yellow, то статус кластера будет аналогичным.

```

# curl -k -u elastic_admin -XDELETE 'https://localhost:9200/ind-1'
Enter host password for user 'elastic_admin':
{"acknowledged":true}

# curl -k -u elastic_admin -XDELETE 'https://localhost:9200/ind-2'
Enter host password for user 'elastic_admin':
{"acknowledged":true}

# curl -k -u elastic_admin -XDELETE 'https://localhost:9200/ind-3'
Enter host password for user 'elastic_admin':
{"acknowledged":true}

# curl -k -u elastic_admin 'https://localhost:9200/_cat/indices?v&pretty'
Enter host password for user 'elastic_admin':
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size




```



## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

### Ответ:
```
# curl -k -u elastic_admin -X PUT "localhost:9200/_snapshot/my_repository?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "snapshots"
  }
}
'

# curl -k -u elastic_admin -X PUT "https://127.0.0.1:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
 {
  "type": "fs",
   "settings": {
     "location": "snapshots"
   }
 }
 '
Enter host password for user 'elastic_admin':
{
  "acknowledged" : true
}

# curl -k -u elastic_admin -X GET "https://localhost:9200/_snapshot?pretty"
Enter host password for user 'elastic_admin':
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "location" : "snapshots"
    }
  }
}

# curl -k -u elastic_admin -X PUT "https://localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "index": {
       "number_of_replicas": 0 ,
       "number_of_shards": 1
     }
   }
 }
 '
Enter host password for user 'elastic_admin':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test"
}


### Список индексов:

# curl -k -u elastic_admin 'https://localhost:9200/_cat/indices?v&pretty'
Enter host password for user 'elastic_admin':
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  jfn9NsPFS7qguvhDUW6xHg   1   0          0            0       225b           225b


# curl -k -u elastic_admin -X PUT "https://127.0.0.1:9200/_snapshot/netology_backup/%3Cmy_snapshot_%7Bnow%2Fd%7D%3E?pretty"
Enter host password for user 'elastic_admin':
{
  "accepted" : true
}


[elasticsearch@afa2406ad4c5 elasticsearch-8.1.1]$ ls snapshots/
index-0  index.latest  indices  meta-0zrzumM-SbSsLtdPeJVewA.dat  snap-0zrzumM-SbSsLtdPeJVewA.dat  snapshots

# curl -k -u elastic_admin -XDELETE 'https://localhost:9200/test'
Enter host password for user 'elastic_admin':
{"acknowledged":true}

# curl -k -u elastic_admin -X PUT "https://localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
 {
   "settings": {
     "index": {
       "number_of_replicas": 0 ,
       "number_of_shards": 1
     }
   }
 }
 '
Enter host password for user 'elastic_admin':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}

# curl -k -u elastic_admin 'https://localhost:9200/_cat/indices?v&pretty'
Enter host password for user 'elastic_admin':
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 E_4He0QNQMe0G9Ef0mjl1w   1   0          0            0       225b           225b



# curl -k -u elastic_admin -X POST "https://localhost:9200/_snapshot/netology_backup/my_snapshot_2022.03.31/_restore?pretty"
Enter host password for user 'elastic_admin':
{
  "accepted" : true
}


# curl -k -u elastic_admin 'https://localhost:9200/_cat/indices?v&pretty'
Enter host password for user 'elastic_admin':
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 E_4He0QNQMe0G9Ef0mjl1w   1   0          0            0       225b           225b
green  open   test   zNsAtO7TR9u60yHmR73kUA   1   0          0            0       225b           225b

```




---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

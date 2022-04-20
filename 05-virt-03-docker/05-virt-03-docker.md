05-virt-03-docker.md
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

Ответ:
```
https://hub.docker.com/r/nb3l77eo/nginx_changed_index.html


# mkdir 05-virt-03-docker
# cd 05-virt-03-docker/
#

# cat > index.html
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>^Z
[1]+  Stopped                 cat > index.html

# cat > Dockerfile
FROM nginx

COPY index.html /usr/share/nginx/html
^Z
[2]+  Stopped                 cat > Dockerfile



# docker build -t nb3l77eo/nginx_changed_index.html:0.0.1 .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx
latest: Pulling from library/nginx
5eb5b503b376: Pull complete
1ae07ab881bd: Pull complete
78091884b7be: Pull complete
091c283c6a66: Pull complete
55de5851019b: Pull complete
b559bad762be: Pull complete
Digest: sha256:2834dc507516af02784808c5f48b7cbe38b8ed5d0f4837f16e78d00deb7e7767
Status: Downloaded newer image for nginx:latest
 ---> c316d5a335a5
Step 2/2 : COPY index.html /usr/share/nginx/html
 ---> e02f9053058d
Successfully built e02f9053058d
Successfully tagged nb3l77eo/nginx_changed_index.html:0.0.1

# docker run --name nginx_test -d -p 8080:80 nb3l77eo/nginx_changed_index.html:0.0.1
d67573d55de33351f2924909613e77f780b003bc5352cc8f60d8225d99f77b17

# curl 127.0.0.1:8080
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>



# docker pull nb3l77eo/nginx_changed_index.html:0.0.1

```



## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.


Ответ:
```
- Высоконагруженное монолитное java веб-приложение; - если нет разделения на сервисы и подразумевается что рабочий экземпляр может быть только один, то в таком случае виртуализация.
- Nodejs веб-приложение; - docker - разработка, тестирование, прод, балансировка, микросервисы
- Мобильное приложение c версиями для Android и iOS; - docker - разработка, тестирование, прод, балансировка, микросервисы
- Шина данных на базе Apache Kafka; - docker - распределенная кластерная система
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana; - виртуальыне машины - не плюсов от использования docker. СУБД там точно не нужна. 
- MongoDB, как основное хранилище данных для java-приложения; - виртуальная машина - файлы данных СУБД к контейнере не нужны, а монтировать директорию не хорошо.
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry. - виртуальные машины - нет микросервисов и есть СУБД.


```




## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.


Ответ:
```
# cd /data
# docker pull ubuntu
Using default tag: latest
latest: Pulling from library/ubuntu
08c01a0ec47e: Pull complete
Digest: sha256:669e010b58baf5beb2836b253c1fd5768333f0d1dbcb834f7c07a4dc93f474be
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest

# docker pull centos
Using default tag: latest
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest

# docker run -v /data:/data --name ubuntu1 -dit ubuntu
fa2c0db280213e3d4ce458230ee4bebd2599510a4cc63617ddfcbaaa7bca1342

# docker run -v /data:/data --name centos1 -dit centos
c6f338cf870acdf6ba32a90009535fbe4fef4702552f1ab23f706577497c3d8d

# docker container ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
967e9d65b7f4   centos    "/bin/bash"   10 seconds ago   Up 9 seconds              centos1
74a5c3599ba4   ubuntu    "bash"        20 seconds ago   Up 16 seconds             ubuntu1

# echo "from_host" > /data/from_host

# docker exec centos1 echo "from_centos1" > /data/from_centos1

# docker exec ubuntu1 cat /data/from_centos1
from_centos1

# docker exec ubuntu1 cat /data/from_host
from_host


```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

Ответ:
```
https://hub.docker.com/r/nb3l77eo/ansible
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

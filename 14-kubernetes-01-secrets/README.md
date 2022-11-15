# Домашнее задание к занятию "14.1 Создание и использование секретов"

## Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

<details>
    <summary style="font-size:15px">Описание:</summary>


Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать секрет?

```
openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```

### Как просмотреть список секретов?

```
kubectl get secrets
kubectl get secret
```

### Как просмотреть секрет?

```
kubectl get secret domain-cert
kubectl describe secret domain-cert
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get secret domain-cert -o yaml
kubectl get secret domain-cert -o json
```

### Как выгрузить секрет и сохранить его в файл?

```
kubectl get secrets -o json > secrets.json
kubectl get secret domain-cert -o yaml > domain-cert.yml
```

### Как удалить секрет?

```
kubectl delete secret domain-cert
```

### Как загрузить секрет из файла?

```
kubectl apply -f domain-cert.yml
```

## Задача 2 (*): Работа с секретами внутри модуля

Выберите любимый образ контейнера, подключите секреты и проверьте их доступность
как в виде переменных окружения, так и в виде примонтированного тома.

</details>


## Решение:

<details>
    <summary style="font-size:15px">Описание:</summary>

![изображение](https://user-images.githubusercontent.com/93001155/201919046-03d7c3d3-8dd6-4173-b2d2-e6e8f1d20de5.png)
![изображение](https://user-images.githubusercontent.com/93001155/201919236-69161b9e-4be4-40cb-a822-66cab20a2d98.png)

![изображение](https://user-images.githubusercontent.com/93001155/201919084-b8030cd9-5770-4330-ba69-cd6556c6d116.png)
![изображение](https://user-images.githubusercontent.com/93001155/201919104-c52030b3-5fbd-4b8c-853a-7319f20a367e.png)
![изображение](https://user-images.githubusercontent.com/93001155/201919144-aa904bc8-3cf9-4703-bc4d-bb667e6c3c90.png)
![изображение](https://user-images.githubusercontent.com/93001155/201919167-2c2aa5c9-51f4-4022-a04c-078b91949093.png)



</details>

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (deployments, pods, secrets) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---

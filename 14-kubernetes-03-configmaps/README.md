# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

<details>
    <summary style="font-size:15px">Описание:</summary>

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать карту конфигураций?

```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```

### Как просмотреть список карт конфигураций?

```
kubectl get configmaps
kubectl get configmap
```

### Как просмотреть карту конфигурации?

```
kubectl get configmap nginx-config
kubectl describe configmap domain
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```

### Как выгрузить карту конфигурации и сохранить его в файл?

```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```

### Как удалить карту конфигурации?

```
kubectl delete configmap nginx-config
```

### Как загрузить карту конфигурации из файла?

```
kubectl apply -f nginx-config.yml
```
</details>

<details>
    <summary style="font-size:15px">Решение:</summary>

Создаем карты конфигураций:

```bash
[vagrant@mgmt-node 14.3]$ kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created
[vagrant@mgmt-node 14.3]$ kubectl create configmap domain --from-literal=name=netology.ru
configmap/domain created
```

Проверяем список созданных карт конфигураций:

```bash
[vagrant@mgmt-node 14.3]$ kubectl get configmaps 
NAME               DATA   AGE
domain             1      3m
kube-root-ca.crt   1      105m
nginx-config       1      3m7s
```

Просмотрим содержимое карты конфигурации:

```bash
[vagrant@mgmt-node 14.3]$ kubectl get configmaps nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-12-10T11:03:36Z"
  name: nginx-config
  namespace: default
  resourceVersion: "10006"
  uid: d6b18356-7d5a-4d7f-8b9b-813fb6a220b6
  
[vagrant@mgmt-node 14.3]$ kubectl get configmaps domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2022-12-10T11:03:43Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "10016",
        "uid": "a0eaabda-5f08-4a7d-a138-94ebb84ecc8a"
    }
}
```

Выгрузим карту конфигурации в файл:

```bash
[vagrant@mgmt-node 14.3]$ kubectl get configmaps nginx-config -o yaml > export/nginx-config.yml
[vagrant@mgmt-node 14.3]$ kubectl get configmaps -o json > export/cf.json
[vagrant@mgmt-node 14.3]$ ls export/
cf.json  nginx-config.yml
```

Удалим карты конфигурации:

```bash
[vagrant@mgmt-node 14.3]$ kubectl delete configmaps nginx-config 
configmap "nginx-config" deleted
[vagrant@mgmt-node 14.3]$ kubectl get configmaps 
NAME               DATA   AGE
domain             1      13m
kube-root-ca.crt   1      116m
```

Загрузим карту конфигурации из фала-манифеста:

```bash
[vagrant@mgmt-node 14.3]$ kubectl apply -f export/nginx-config.yml 
configmap/nginx-config created
[vagrant@mgmt-node 14.3]$ kubectl get configmaps 
NAME               DATA   AGE
domain             1      14m
kube-root-ca.crt   1      117m
nginx-config       1      8s
```


</details>
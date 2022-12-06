# Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"
Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.

## Задание 1: подготовить тестовый конфиг для запуска приложения

<details>
    <summary style="font-size:15px">Описание:</summary>

Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

</details>

<details>
    <summary style="font-size:15px">Решение:</summary>

Применяем манифесты. Доступны в [Stage](./Stage)

```bash
[vagrant@mgmt-node Stage]$ kubectl apply -f .
deployment.apps/app-front-back created
statefulset.apps/postgresql-db created
persistentvolume/pv-postgres-w1 created
persistentvolumeclaim/local-volume-postgres created
storageclass.storage.k8s.io/local-storage-postgres created
```

Удостоверимся в создании StorageClass
```bash
[vagrant@mgmt-node Stage]$ kubectl get sc
NAME                     PROVISIONER                    RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-storage-postgres   kubernetes.io/no-provisioner   Delete          WaitForFirstConsumer   false                  42s
```
Удостоверимся в создании persistentvolumes
```bash
[vagrant@mgmt-node Stage]$ kubectl get pv
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                           STORAGECLASS             REASON   AGE
pv-postgres-w1   512Mi      RWO            Retain           Bound    default/local-volume-postgres   local-storage-postgres            88s
```
Удостоверимся в создании persistentvolumeclaims
```bash
[vagrant@mgmt-node Stage]$ kubectl get pvc
NAME                    STATUS   VOLUME           CAPACITY   ACCESS MODES   STORAGECLASS             AGE
local-volume-postgres   Bound    pv-postgres-w1   512Mi      RWO            local-storage-postgres   93s
```
Проверим statefulsets
```bash
[vagrant@mgmt-node Stage]$ kubectl get statefulsets.apps 
NAME            READY   AGE
postgresql-db   1/1     105s
```
Проверим deployments
```bash
[vagrant@mgmt-node Stage]$ kubectl get deployments.apps 
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
app-front-back   1/1     1            1           2m
```
Проверим поды
```bash
[vagrant@mgmt-node Stage]$ kubectl get pod
NAME                              READY   STATUS    RESTARTS   AGE
app-front-back-546745bc65-5xd4g   2/2     Running   0          2m6s
postgresql-db-0                   1/1     Running   0          2m6s
```


</details>


## Задание 2: подготовить конфиг для production окружения




<details>
    <summary style="font-size:15px">Описание:</summary>

Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

</details>

<details>
    <summary style="font-size:15px">Решение:</summary>

Применяем манифесты. Доступны в [Production](./Production)
```bash
[vagrant@mgmt-node Stage]$ cd ../Production/

[vagrant@mgmt-node Production]$ kubectl apply -f .
deployment.apps/app-backend created
service/backend-svc created
deployment.apps/app-frontend created
statefulset.apps/postgresql-db created
service/db-postgres-svc created
persistentvolume/pv-postgres-w1 created
persistentvolumeclaim/local-volume-postgres created
storageclass.storage.k8s.io/local-storage-postgres created
```
Удостоверимся в создании StorageClass
```bash
[vagrant@mgmt-node Production]$ kubectl get sc
NAME                     PROVISIONER                    RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-storage-postgres   kubernetes.io/no-provisioner   Delete          WaitForFirstConsumer   false                  20s
```
Удостоверимся в создании persistentvolumes
```bash
[vagrant@mgmt-node Production]$ kubectl get pv
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                           STORAGECLASS             REASON   AGE
pv-postgres-w1   512Mi      RWO            Retain           Bound    default/local-volume-postgres   local-storage-postgres            25s
```
Удостоверимся в создании persistentvolumeclaims
```bash
[vagrant@mgmt-node Production]$ kubectl get pvc
NAME                    STATUS   VOLUME           CAPACITY   ACCESS MODES   STORAGECLASS             AGE
local-volume-postgres   Bound    pv-postgres-w1   512Mi      RWO            local-storage-postgres   27s
```
Удостоверимся в создании statefulsets
```bash
[vagrant@mgmt-node Production]$ kubectl get statefulsets.apps 
NAME            READY   AGE
postgresql-db   1/1     34s
```
Удостоверимся в создании statefulsets
```bash
[vagrant@mgmt-node Production]$ kubectl get deployments.apps 
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
app-backend    1/1     1            1           40s
app-frontend   1/1     1            1           40s
```
Проверим Services
```bash
[vagrant@mgmt-node Production]$ kubectl get svc
NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
backend-svc       ClusterIP   10.233.27.84   <none>        8080/TCP   13m
db-postgres-svc   ClusterIP   10.233.4.103   <none>        5432/TCP   13m
kubernetes        ClusterIP   10.233.0.1     <none>        443/TCP    2d4h
```

Проверим поды
```bash
[vagrant@mgmt-node Production]$ kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
app-backend-74878f469-rw5dp     1/1     Running   0          44s
app-frontend-76b9678bf6-r57th   1/1     Running   0          44s
postgresql-db-0                 1/1     Running   0          44s
```
Удостоверимся в создании записи env и проверим доступность сервиса dns
```bash
[vagrant@mgmt-node Production]$ kubectl exec -it app-backend-74878f469-rw5dp /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
bash-5.1# env | grep db-address
db-address=db-postgres-svc.default.svc.cluster.local
bash-5.1# ping db-postgres-svc.default.svc.cluster.local
PING db-postgres-svc.default.svc.cluster.local (10.233.4.103) 56(84) bytes of data.
64 bytes from db-postgres-svc.default.svc.cluster.local (10.233.4.103): icmp_seq=1 ttl=64 time=0.036 ms
64 bytes from db-postgres-svc.default.svc.cluster.local (10.233.4.103): icmp_seq=2 ttl=64 time=0.072 ms
64 bytes from db-postgres-svc.default.svc.cluster.local (10.233.4.103): icmp_seq=3 ttl=64 time=0.071 ms
^C
--- db-postgres-svc.default.svc.cluster.local ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2001ms
rtt min/avg/max/mdev = 0.036/0.059/0.072/0.016 ms
```
</details>

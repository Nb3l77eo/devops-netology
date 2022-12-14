# Домашнее задание к занятию "14.5 SecurityContext, NetworkPolicies"

## Задача 1: Рассмотрите пример 14.5/example-security-context.yml

<details>
    <summary style="font-size:15px">Описание:</summary>


Создайте модуль

```
kubectl apply -f 14.5/example-security-context.yml
```

Проверьте установленные настройки внутри контейнера

```
kubectl logs security-context-demo
uid=1000 gid=3000 groups=3000
```
</details>

<details>
    <summary style="font-size:15px">Решение:</summary>


```bash
[vagrant@mgmt-node 14.5]$ kubectl get pod
No resources found in default namespace.

[vagrant@mgmt-node 14.5]$ kubectl apply -f example-security-context.yml 
pod/security-context-demo created

[vagrant@mgmt-node 14.5]$ kubectl get pod
NAME                    READY   STATUS              RESTARTS   AGE
security-context-demo   0/1     ContainerCreating   0          2s

[vagrant@mgmt-node 14.5]$ kubectl logs security-context-demo 
uid=1000 gid=3000 groups=3000
```

</details>

## Задача 2 (*): Рассмотрите пример 14.5/example-network-policy.yml

<details>
    <summary style="font-size:15px">Описание:</summary>


Создайте два модуля. Для первого модуля разрешите доступ к внешнему миру
и ко второму контейнеру. Для второго модуля разрешите связь только с
первым контейнером. Проверьте корректность настроек.

</details>

<details>
    <summary style="font-size:15px">Решение:</summary>


Необходимо применить манифесты из папки [additional](./additional)


Смотрим IP подов:

```bash
[vagrant@mgmt-node 14.5_add]$ kubectl get pod -o=wide
NAME                      READY   STATUS    RESTARTS   AGE   IP               NODE     NOMINATED NODE   READINESS GATES
modul1-7c9fbf8848-tm2w6   1/1     Running   0          22s   10.233.103.149   k8s-w1   <none>           <none>
modul2-588b68d67d-t2k5s   1/1     Running   0          22s   10.233.103.150   k8s-w1   <none>           <none>
modul3-868599b678-7wkrg   1/1     Running   0          22s   10.233.103.151   k8s-w1   <none>           <none>
```

Проверим отсуствие достпа с модуля 3 до до модулей 2 и 1:

```bash
[vagrant@mgmt-node 14.5_add]$ kubectl exec -it modul3-868599b678-7wkrg /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.

bash-5.1# ping mail.ru
PING mail.ru (94.100.180.201) 56(84) bytes of data.
64 bytes from mail.ru (94.100.180.201): icmp_seq=1 ttl=57 time=53.2 ms
^C
--- mail.ru ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 53.165/53.165/53.165/0.000 ms

bash-5.1# ping 10.233.103.149
PING 10.233.103.149 (10.233.103.149) 56(84) bytes of data.
^C
--- 10.233.103.149 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 1999ms

bash-5.1# ping 10.233.103.150
PING 10.233.103.150 (10.233.103.150) 56(84) bytes of data.
^C
--- 10.233.103.150 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 1999ms
```


Проверим наличие доступа у модуля 2 только к модулю 1:

```bash
[vagrant@mgmt-node 14.5_add]$ kubectl exec -it modul2-588b68d67d-t2k5s /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.

bash-5.1# ping 10.233.103.151
PING 10.233.103.151 (10.233.103.151) 56(84) bytes of data.
^C
--- 10.233.103.151 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1000ms

bash-5.1# ping mail.ru
^C
bash-5.1# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
^C
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 1999ms

bash-5.1# ping 10.233.103.149
PING 10.233.103.149 (10.233.103.149) 56(84) bytes of data.
64 bytes from 10.233.103.149: icmp_seq=1 ttl=63 time=0.091 ms
64 bytes from 10.233.103.149: icmp_seq=2 ttl=63 time=0.074 ms
^C
--- 10.233.103.149 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 999ms
rtt min/avg/max/mdev = 0.074/0.082/0.091/0.008 ms

```


Проверим наличие доступа у модуля 1 к внешней сети и модулю 2:

```bash
[vagrant@mgmt-node 14.5_add]$ kubectl exec -it modul1-7c9fbf8848-tm2w6 /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
bash-5.1# ping mail.ru
PING mail.ru (94.100.180.201) 56(84) bytes of data.
64 bytes from mail.ru (94.100.180.201): icmp_seq=1 ttl=57 time=52.8 ms
^C
--- mail.ru ping statistics ---
2 packets transmitted, 1 received, 50% packet loss, time 1001ms
rtt min/avg/max/mdev = 52.820/52.820/52.820/0.000 ms
bash-5.1# ping 10.233.103.150
PING 10.233.103.150 (10.233.103.150) 56(84) bytes of data.
64 bytes from 10.233.103.150: icmp_seq=1 ttl=63 time=0.096 ms
64 bytes from 10.233.103.150: icmp_seq=2 ttl=63 time=0.129 ms
^C
--- 10.233.103.150 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 999ms
rtt min/avg/max/mdev = 0.096/0.112/0.129/0.016 ms
bash-5.1# ping 10.233.103.151
PING 10.233.103.151 (10.233.103.151) 56(84) bytes of data.
^C
--- 10.233.103.151 ping statistics ---
4 packets transmitted, 0 received, 100% packet loss, time 3002ms
```


</details>

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, statefulset, service) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---

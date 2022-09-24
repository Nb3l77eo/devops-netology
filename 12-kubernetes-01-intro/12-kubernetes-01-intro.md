# Домашнее задание к занятию "12.1 Компоненты Kubernetes"

Вы DevOps инженер в крупной компании с большим парком сервисов. Ваша задача — разворачивать эти продукты в корпоративном кластере. 

## Задача 1: Установить Minikube

<details>
    <summary style="font-size:15px">Описание:</summary>

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине Minikube.

### Как поставить на AWS:
- создать EC2 виртуальную машину (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type) с типом **t3.small**. Для работы потребуется настроить Security Group для доступа по ssh. Не забудьте указать keypair, он потребуется для подключения.
- подключитесь к серверу по ssh (ssh ubuntu@<ipv4_public_ip> -i <keypair>.pem)
- установите миникуб и докер следующими командами:
  - curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  - chmod +x ./kubectl
  - sudo mv ./kubectl /usr/local/bin/kubectl
  - sudo apt-get update && sudo apt-get install docker.io conntrack -y
  - curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
- проверить версию можно командой minikube version
- переключаемся на root и запускаем миникуб: minikube start --vm-driver=none
- после запуска стоит проверить статус: minikube status
- запущенные служебные компоненты можно увидеть командой: kubectl get pods --namespace=kube-system

### Для сброса кластера стоит удалить кластер и создать заново:
- minikube delete
- minikube start --vm-driver=none

Возможно, для повторного запуска потребуется выполнить команду: sudo sysctl fs.protected_regular=0

Инструкция по установке Minikube - [ссылка](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

**Важно**: t3.small не входит во free tier, следите за бюджетом аккаунта и удаляйте виртуалку.

</details>



<details>
    <summary style="font-size:15px">Ответ:</summary>

```bash
# minikube start --vm-driver=none
😄  minikube v1.26.1 on Ubuntu 22.04
✨  Using the none driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🤹  Running on localhost (CPUs=3, Memory=7949MB, Disk=18258MB) ...
ℹ️  OS release is Ubuntu 22.04.1 LTS
🐳  Preparing Kubernetes v1.24.3 on Docker 20.10.12 ...
    ▪ kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
    > kubectl.sha256:  64 B / 64 B [-------------------------] 100.00% ? p/s 0s
    > kubeadm.sha256:  64 B / 64 B [-------------------------] 100.00% ? p/s 0s
    > kubelet.sha256:  64 B / 64 B [-------------------------] 100.00% ? p/s 0s
    > kubectl:  43.59 MiB / 43.59 MiB [------------] 100.00% 13.56 MiB p/s 3.4s
    > kubeadm:  42.32 MiB / 42.32 MiB [------------] 100.00% 12.09 MiB p/s 3.7s
    > kubelet:  110.64 MiB / 110.64 MiB [----------] 100.00% 28.37 MiB p/s 4.1s
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🤹  Configuring local host environment ...

❗  The 'none' driver is designed for experts who need to integrate with an existing VM
💡  Most users should use the newer 'docker' driver instead, which does not require root!
📘  For more information, see: https://minikube.sigs.k8s.io/docs/reference/drivers/none/

❗  kubectl and minikube configuration will be stored in /root
❗  To use kubectl or minikube commands as your own user, you may need to relocate them. For example, to overwrite your own settings, run:

    ▪ sudo mv /root/.kube /root/.minikube $HOME
    ▪ sudo chown -R $USER $HOME/.kube $HOME/.minikube

💡  This can also be done automatically by setting the env var CHANGE_MINIKUBE_NONE_USER=true
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default


# minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

# kubectl get pods --namespace=kube-system
NAME                               READY   STATUS    RESTARTS      AGE
coredns-6d4b75cb6d-5d2nf           1/1     Running   0             31s
etcd-minikube                      1/1     Running   0             44s
kube-apiserver-minikube            1/1     Running   0             44s
kube-controller-manager-minikube   1/1     Running   0             44s
kube-proxy-sn6pd                   1/1     Running   0             31s
kube-scheduler-minikube            1/1     Running   0             44s
storage-provisioner                1/1     Running   2 (30s ago)   43s

```

</details>


## Задача 2: Запуск Hello World

<details>
    <summary style="font-size:15px">Описание:</summary>

После установки Minikube требуется его проверить. Для этого подойдет стандартное приложение hello world. А для доступа к нему потребуется ingress.

- развернуть через Minikube тестовое приложение по [туториалу](https://kubernetes.io/ru/docs/tutorials/hello-minikube/#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0-minikube)
- установить аддоны ingress и dashboard

</details>



<details>
    <summary style="font-size:15px">Ответ:</summary>

```bash
$ kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
deployment.apps/hello-node created

$ kubectl get deployments
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   1/1     1            1           36s

$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6d5f754cc9-7bw4k   1/1     Running   0          47s

$ minikube addons enable ingress
💡  ingress is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image k8s.gcr.io/ingress-nginx/controller:v1.2.1
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
🔎  Verifying ingress addon...
🌟  The 'ingress' addon is enabled

$ minikube addons enable dashboard
💡  dashboard is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image kubernetesui/dashboard:v2.6.0
    ▪ Using image kubernetesui/metrics-scraper:v1.0.8
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


🌟  The 'dashboard' addon is enabled


```


</details>



## Задача 3: Установить kubectl

<details>
    <summary style="font-size:15px">Описание:</summary>

Подготовить рабочую машину для управления корпоративным кластером. Установить клиентское приложение kubectl.
- подключиться к minikube 
- проверить работу приложения из задания 2, запустив port-forward до кластера


</details>


<details>
    <summary style="font-size:15px">Ответ:</summary>

Для настройки kubectl необходимо использовать файл конфигурации:

```yaml
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority: /home/user/.minikube/ca.crt
        extensions:
        - extension:
            last-update: Fri, 16 Sep 2022 06:23:10 UTC
            provider: minikube.sigs.k8s.io
            version: v1.26.1
        name: cluster_info
        server: https://192.168.49.2:8443
    name: minikube
    contexts:
    - context:
        cluster: minikube
        extensions:
        - extension:
            last-update: Fri, 16 Sep 2022 06:23:10 UTC
            provider: minikube.sigs.k8s.io
            version: v1.26.1
        name: context_info
        namespace: default
        user: minikube
    name: minikube
    current-context: minikube
    kind: Config
    preferences: {}
    users:
    - name: minikube
    user:
        client-certificate: /home/user/.minikube/profiles/minikube/client.crt
        client-key: /home/user/.minikube/profiles/minikube/client.key
```


```bash
$ kubectl expose deployment hello-node --type=LoadBalancer --port=8080
service/hello-node exposed

$ kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
hello-node   LoadBalancer   10.110.234.82   <pending>     8080:32050/TCP   8s
kubernetes   ClusterIP      10.96.0.1       <none>        443/TCP          8d

$ minikube service hello-node
|-----------|------------|-------------|---------------------------|
| NAMESPACE |    NAME    | TARGET PORT |            URL            |
|-----------|------------|-------------|---------------------------|
| default   | hello-node |        8080 | http://192.168.49.2:32050 |
|-----------|------------|-------------|---------------------------|
🎉  Opening service default/hello-node in default browser...
👉  http://192.168.49.2:32050



$ wget http://192.168.49.2:32050/index.html
2022-09-24 06:55:19 (1.84 MB/s) - ‘index.html’ saved [361]

$ cat index.html 
CLIENT VALUES:
client_address=172.17.0.1
command=GET
real path=/index.html
query=nil
request_version=1.1
request_uri=http://192.168.49.2:8080/index.html

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
accept-encoding=identity
connection=Keep-Alive
host=192.168.49.2:32050
user-agent=Wget/1.21.2
BODY:

```

</details>



## Задача 4 (*): собрать через ansible (необязательное)

<details>
    <summary style="font-size:15px">Описание:</summary>

Профессионалы не делают одну и ту же задачу два раза. Давайте закрепим полученные навыки, автоматизировав выполнение заданий  ansible-скриптами. При выполнении задания обратите внимание на доступные модули для k8s под ansible.
 - собрать роль для установки minikube на aws сервисе (с установкой ingress)
 - собрать роль для запуска в кластере hello world
  
  ---


</details>



<details>


</details>


### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

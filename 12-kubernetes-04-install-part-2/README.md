# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

# Ответ

<details>
    <summary style="font-size:15px">Описание:</summary>

    Для создания инфраструктуры в YC использовался [terraform](terraform/) 

    ```bash
    $ terraform apply -auto-approve

    $ ansible-playbook -i inventory/12.4/inventory.ini cluster.yml -b -v

    $ ssh 158.160.42.153
    [vagrant@k8s-master1 ~]$ 

    [vagrant@k8s-master1 ~]$ mkdir -p $HOME/.kube


    [vagrant@k8s-master1 ~]$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config


    [vagrant@k8s-master1 ~]$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

    [vagrant@k8s-master1 ~]$ kubectl version
    WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
    Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.4", GitCommit:"872a965c6c6526caa949f0c6ac028ef7aff3fb78", GitTreeState:"clean", BuildDate:"2022-11-09T13:36:36Z", GoVersion:"go1.19.3", Compiler:"gc", Platform:"linux/amd64"}
    Kustomize Version: v4.5.7
    Server Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.4", GitCommit:"872a965c6c6526caa949f0c6ac028ef7aff3fb78", GitTreeState:"clean", BuildDate:"2022-11-09T13:29:58Z", GoVersion:"go1.19.3", Compiler:"gc", Platform:"linux/amd64"}


    [vagrant@k8s-master1 ~]$ kubectl get nodes
    NAME          STATUS   ROLES           AGE   VERSION
    k8s-master1   Ready    control-plane   14m   v1.25.4
    k8s-worker1   Ready    <none>          12m   v1.25.4
    k8s-worker2   Ready    <none>          12m   v1.25.4
    k8s-worker3   Ready    <none>          12m   v1.25.4
    k8s-worker4   Ready    <none>          12m   v1.25.4

    [vagrant@k8s-master1 ~]$ kubectl create deploy nginx --image=nginx:latest --replicas=2
    deployment.apps/nginx created

    [vagrant@k8s-master1 ~]$ kubectl get po -o wide
    NAME                     READY   STATUS    RESTARTS   AGE   IP               NODE          NOMINATED NODE   READINESS GATES
    nginx-6d666844f6-65qjd   1/1     Running   0          12s   10.233.113.129   k8s-worker3   <none>           <none>
    nginx-6d666844f6-757fh   1/1     Running   0          12s   10.233.92.129    k8s-worker1   <none>           <none>
    ```


</details>



---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

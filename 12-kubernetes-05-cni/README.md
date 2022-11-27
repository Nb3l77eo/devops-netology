# Домашнее задание к занятию "12.5 Сетевые решения CNI"
После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
## Задание 1: установить в кластер CNI плагин Calico

<details>
    <summary style="font-size:15px">Описание:</summary>

Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

</details>

### Ответ:

<details>
    <summary style="font-size:15px">flannel:</summary>


Развернули кластер:

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl get nodes 
NAME          STATUS   ROLES           AGE   VERSION
k8s-cp0       Ready    control-plane   70m   v1.25.4
k8s-worker0   Ready    <none>          69m   v1.25.4
```

Убедились в том, что CNI - flannel (наличие kube-flannel-XXXXXX):

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl get pods -n kube-system
NAME                              READY   STATUS    RESTARTS   AGE
coredns-588bb58b94-h96zk          1/1     Running   0          67m
coredns-588bb58b94-mlh47          1/1     Running   0          67m
dns-autoscaler-5b9959d7fc-tp872   1/1     Running   0          67m
kube-apiserver-k8s-cp0            1/1     Running   1          70m
kube-controller-manager-k8s-cp0   1/1     Running   1          70m
kube-flannel-qrhcb                1/1     Running   0          68m
kube-flannel-slvtd                1/1     Running   0          68m
kube-proxy-c7bz5                  1/1     Running   0          69m
kube-proxy-g7bzp                  1/1     Running   0          69m
kube-scheduler-k8s-cp0            1/1     Running   1          70m
nginx-proxy-k8s-worker0           1/1     Running   0          68m
nodelocaldns-9fl7w                1/1     Running   0          67m
nodelocaldns-mvbdp                1/1     Running   0          67m
```

Деплоим манифесты:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl apply -f main/
deployment.apps/frontend created
service/frontend created
deployment.apps/backend created
service/backend created
deployment.apps/cache created
service/cache created

vagrant@vagrant:~/homework/12.x/12.5$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
backend-7565d57698-57qlr    1/1     Running   0          10m
cache-7d8f7d7c48-jdq5w      1/1     Running   0          10m
frontend-7c55448646-jdkkf   1/1     Running   0          10m
```

Убеждаемся в отсутствии ограничений:

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl exec frontend-7c55448646-jdkkf -- curl -s -m 2 cache
Praqma Network MultiTool (with NGINX) - cache-7d8f7d7c48-jdq5w - 10.233.65.5

vagrant@vagrant:~/homework/12.x/12.5$ kubectl exec frontend-7c55448646-jdkkf -- curl -s -m 2 backend
Praqma Network MultiTool (with NGINX) - backend-7565d57698-57qlr - 10.233.65.4

vagrant@vagrant:~/homework/12.x/12.5$ kubectl exec frontend-7c55448646-jdkkf -- curl -s -m 2 frontend
Praqma Network MultiTool (with NGINX) - frontend-7c55448646-jdkkf - 10.233.65.3
```

Проверка отсутствия networkpolicies

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl get networkpolicies
No resources found in default namespace.
```

Применяем networkpolicies:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl apply -f network-policy/00-default.yaml 
networkpolicy.networking.k8s.io/default-deny-ingress created

vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl get networkpolicies
NAME                   POD-SELECTOR   AGE
default-deny-ingress   <none>         78s
```

Проверяем работает ли networkpolicies для flannel и 1беждаемся в том, что networkpolicies для flannel не действуют:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-jdkkf -- curl -s -m 2 cache
Praqma Network MultiTool (with NGINX) - cache-7d8f7d7c48-jdq5w - 10.233.65.5

vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-jdkkf -- curl -s -m 2 cache
Praqma Network MultiTool (with NGINX) - cache-7d8f7d7c48-jdq5w - 10.233.65.5

vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-jdkkf -- curl -s -m 2 backend
Praqma Network MultiTool (with NGINX) - backend-7565d57698-57qlr - 10.233.65.4
```




</details>


<details>
    <summary style="font-size:15px">calico:</summary>


Развернули кластер:

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl get nodes 
NAME          STATUS   ROLES           AGE     VERSION
k8s-cp0       Ready    control-plane   3h16m   v1.25.4
k8s-worker0   Ready    <none>          3h14m   v1.25.4
```

Убедились в том, что CNI - calico (наличие calico-node-XXXXXX):

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl get pods -n kube-system
NAME                                      READY   STATUS    RESTARTS        AGE
calico-kube-controllers-d6484b75c-kdq85   1/1     Running   0               3h15m
calico-node-kmk4v                         1/1     Running   0               3h16m
calico-node-vpgmb                         1/1     Running   0               3h16m
coredns-588bb58b94-l27h8                  1/1     Running   0               3h14m
coredns-588bb58b94-pk2c4                  1/1     Running   0               3h13m
dns-autoscaler-5b9959d7fc-tln8x           1/1     Running   0               3h13m
kube-apiserver-k8s-cp0                    1/1     Running   1               3h18m
kube-controller-manager-k8s-cp0           1/1     Running   1               3h18m
kube-proxy-55hz6                          1/1     Running   0               3h17m
kube-proxy-d8d5w                          1/1     Running   0               3h17m
kube-scheduler-k8s-cp0                    1/1     Running   2 (3h18m ago)   3h18m
nginx-proxy-k8s-worker0                   1/1     Running   0               3h16m
nodelocaldns-hf6q7                        1/1     Running   0               3h13m
nodelocaldns-m5v7f                        1/1     Running   0               3h13m
```

Деплоим манифесты:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl apply -f main/
deployment.apps/frontend created
service/frontend created
deployment.apps/backend created
service/backend created
deployment.apps/cache created
service/cache created


vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
backend-7565d57698-fjgqp    1/1     Running   0          19s
cache-7d8f7d7c48-6mcdw      1/1     Running   0          18s
frontend-7c55448646-zjncf   1/1     Running   0          19s
```

Убеждаемся в отсутствии ограничений:

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 backend
Praqma Network MultiTool (with NGINX) - backend-7565d57698-fjgqp - 10.233.92.133
vagrant@vagrant:~/homework/12.x/12.5$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 cache
Praqma Network MultiTool (with NGINX) - cache-7d8f7d7c48-6mcdw - 10.233.92.132
vagrant@vagrant:~/homework/12.x/12.5$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 frontend
Praqma Network MultiTool (with NGINX) - frontend-7c55448646-zjncf - 10.233.92.131
```

Проверка отсутствия networkpolicies

```bash
vagrant@vagrant:~/homework/12.x/12.5$ kubectl get networkpolicies
No resources found in default namespace.
```

Применяем networkpolicies ограничивающую входящий трафик для подов:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl apply -f network-policy/00-default.yaml 
networkpolicy.networking.k8s.io/default-deny-ingress created

vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl get networkpolicies
NAME                   POD-SELECTOR   AGE
default-deny-ingress   <none>         78s
```

Проверяем работает ли networkpolicies для calico и убеждаемся в том, что запрет входящего трафика работает:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 cache
command terminated with exit code 28
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 backend
command terminated with exit code 28
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 frontend
command terminated with exit code 28
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec backend-7565d57698-fjgqp -- curl -s -m 2 cache
command terminated with exit code 28
```

Применяем политику разрешающую входящий трафик только от frontend к backend, проверяем:

```bash
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl apply -f network-policy/20-backend.yaml 
networkpolicy.networking.k8s.io/backend created
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl get networkpolicies
NAME                   POD-SELECTOR   AGE
backend                app=backend    4m57s
default-deny-ingress   <none>         73m
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec frontend-7c55448646-zjncf -- curl -s -m 2 backend
Praqma Network MultiTool (with NGINX) - backend-7565d57698-fjgqp - 10.233.92.196
vagrant@vagrant:~/homework/12.x/kubernetes-for-beginners/16-networking/20-network-policy/manifests$ kubectl exec cache-7d8f7d7c48-6mcdw -- curl -s -m 2 backend
command terminated with exit code 28
```

Вывод: мы на практике удостоверились в том, что calico работает с networkpolicy и получили опыт работы с описанием и применением самих политик.



</details>


## Задание 2: изучить, что запущено по умолчанию

<details>
    <summary style="font-size:15px">Описание:</summary>

Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

</details>

### Ответ:


<details>
    <summary style="font-size:15px">Решение:</summary>

```bash
vagrant@vagrant:~$ sudo rm /usr/local/bin/calicoctl 

vagrant@vagrant:~$ curl -L https://github.com/projectcalico/calico/releases/download/v3.23.3/calicoctl-linux-amd64 -o calicoctl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 56.5M  100 56.5M    0     0  5992k      0  0:00:09  0:00:09 --:--:-- 4124k

vagrant@vagrant:~$ chmod +x ./calicoctl

vagrant@vagrant:~$ sudo mv calicoctl /usr/local/bin/

vagrant@vagrant:~$ export KUBECONFIG=~/.kube/config

vagrant@vagrant:~$ export DATASTORE_TYPE=kubernetes

vagrant@vagrant:~$ calicoctl get nodes
NAME          
k8s-cp0       
k8s-worker0  

vagrant@vagrant:~$ calicoctl get ipPool
NAME           CIDR             SELECTOR   
default-pool   10.233.64.0/18   all() 

vagrant@vagrant:~$ calicoctl get profile
NAME                                                 
projectcalico-default-allow                          
kns.default                                          
kns.kube-node-lease                                  
kns.kube-public                                      
kns.kube-system                                      
ksa.default.default                                  
ksa.kube-node-lease.default                          
ksa.kube-public.default                              
ksa.kube-system.attachdetach-controller              
ksa.kube-system.bootstrap-signer                     
ksa.kube-system.calico-kube-controllers              
ksa.kube-system.calico-node                          
ksa.kube-system.certificate-controller               
ksa.kube-system.clusterrole-aggregation-controller   
ksa.kube-system.coredns                              
ksa.kube-system.cronjob-controller                   
ksa.kube-system.daemon-set-controller                
ksa.kube-system.default                              
ksa.kube-system.deployment-controller                
ksa.kube-system.disruption-controller                
ksa.kube-system.dns-autoscaler                       
ksa.kube-system.endpoint-controller                  
ksa.kube-system.endpointslice-controller             
ksa.kube-system.endpointslicemirroring-controller    
ksa.kube-system.ephemeral-volume-controller          
ksa.kube-system.expand-controller                    
ksa.kube-system.generic-garbage-collector            
ksa.kube-system.horizontal-pod-autoscaler            
ksa.kube-system.job-controller                       
ksa.kube-system.kube-proxy                           
ksa.kube-system.namespace-controller                 
ksa.kube-system.node-controller                      
ksa.kube-system.nodelocaldns                         
ksa.kube-system.persistent-volume-binder             
ksa.kube-system.pod-garbage-collector                
ksa.kube-system.pv-protection-controller             
ksa.kube-system.pvc-protection-controller            
ksa.kube-system.replicaset-controller                
ksa.kube-system.replication-controller               
ksa.kube-system.resourcequota-controller             
ksa.kube-system.root-ca-cert-publisher               
ksa.kube-system.service-account-controller           
ksa.kube-system.service-controller                   
ksa.kube-system.statefulset-controller               
ksa.kube-system.token-cleaner                        
ksa.kube-system.ttl-after-finished-controller        
ksa.kube-system.ttl-controller  

```

</details>

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
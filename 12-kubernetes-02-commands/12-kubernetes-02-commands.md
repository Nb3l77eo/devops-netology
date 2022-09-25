# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте

<details>
    <summary style="font-size:15px">Описание:</summary>

Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods
</details>
<details>
    <summary style="font-size:15px">Ответ:</summary>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: hnode
  name: hnode
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hnode
  template:
    metadata:
      labels:
        app: hnode
    spec:
      containers:
        - image: nginx:latest
          ports:
            - containerPort: 8080
              name: web
              protocol: TCP
          name: hnode
```

```bash
$ kubectl apply -f first_deploy.yml 
deployment.apps/hnode created

$ kubectl get deployments.apps 
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
hnode   2/2     2            2           23s

$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
hnode-69bbf574c8-5cvj6   1/1     Running   0          39s
hnode-69bbf574c8-vnqcw   1/1     Running   0          39s


```


</details>

## Задание 2: Просмотр логов для разработки

<details>
    <summary style="font-size:15px">Описание:</summary>

Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)
</details>
<details>
    <summary style="font-size:15px">Ответ:</summary>

```bash

$ openssl genrsa -out user_dev.key 2048

$ openssl req -new -key user_dev.key -out user_dev.csr -subj '/CN=user_dev/O=group_dev'

$ openssl x509 -req -in user_dev.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out user_dev.crt -days 500
Certificate request self-signature ok
subject=CN = user_dev, O = group_dev

$ kubectl config set-credentials user_dev --client-certificate=user_dev.crt --client-key=user_dev.key
User "user_dev" set.

$ kubectl config set-context user_dev-context --cluster=minikube --user=user_dev
Context "user_dev-context" created.

$ kubectl config view
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
- context:
    cluster: minikube
    user: user_dev
  name: user_dev-context
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /home/user/.minikube/profiles/minikube/client.crt
    client-key: /home/user/.minikube/profiles/minikube/client.key
- name: user_dev
  user:
    client-certificate: /home/user/12.x/12.2/cert/user_dev.crt
    client-key: /home/user/12.x/12.2/cert/user_dev.key

$ kubectl config use-context user_dev-context 
Switched to context "user_dev-context".

$ kubectl config current-context 
user_dev-context

$ kubectl create namespace nstest
Error from server (Forbidden): namespaces is forbidden: User "user_dev" cannot create resource "namespaces" in API group "" at the cluster scope

$ kubectl config use-context minikube 
Switched to context "minikube".

$ kubectl apply -f ../role.yaml 
role.rbac.authorization.k8s.io/pod-reader created

$ kubectl apply -f ../role-binding.yaml 
rolebinding.rbac.authorization.k8s.io/read-pods created

$ kubectl get role
NAME         CREATED AT
pod-reader   2022-09-25T12:27:13Z

$ kubectl get rolebindings.rbac.authorization.k8s.io 
NAME        ROLE              AGE
read-pods   Role/pod-reader   62s

$ kubectl config use-context user_dev-context 
Switched to context "user_dev-context".

$ kubectl create namespace nstest
Error from server (Forbidden): namespaces is forbidden: User "user_dev" cannot create resource "namespaces" in API group "" at the cluster scope

$ kubectl logs hnode-69bbf574c8-5cvj6 
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/09/25 06:52:40 [notice] 1#1: using the "epoll" event method
2022/09/25 06:52:40 [notice] 1#1: nginx/1.23.1
2022/09/25 06:52:40 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/09/25 06:52:40 [notice] 1#1: OS: Linux 5.15.0-47-generic
2022/09/25 06:52:40 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/09/25 06:52:40 [notice] 1#1: start worker processes
2022/09/25 06:52:40 [notice] 1#1: start worker process 30
2022/09/25 06:52:40 [notice] 1#1: start worker process 31
2022/09/25 06:52:40 [notice] 1#1: start worker process 32

$ kubectl describe pods hnode-69bbf574c8-5
Name:             hnode-69bbf574c8-5cvj6
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Sun, 25 Sep 2022 06:52:34 +0000
Labels:           app=hnode
                  pod-template-hash=69bbf574c8
Annotations:      <none>
Status:           Running
IP:               172.17.0.7
IPs:
  IP:           172.17.0.7
Controlled By:  ReplicaSet/hnode-69bbf574c8
Containers:
  hnode:
    Container ID:   docker://2290847659c9f88ca8c0d6547c6809e58b97c618bdf91c0c59acfce8887aa54c
    Image:          nginx:latest
    Image ID:       docker-pullable://nginx@sha256:0b970013351304af46f322da1263516b188318682b2ab1091862497591189ff1
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 25 Sep 2022 06:52:40 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4trp4 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4trp4:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>

```

```yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods", "pods/log"]
  verbs: ["logs", "describe", "list", "get"]
```

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: user_dev # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # must match the name of the Role
  apiGroup: rbac.authorization.k8s.io
```



</details>

## Задание 3: Изменение количества реплик 

<details>
    <summary style="font-size:15px">Описание:</summary>

Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

</details>
<details>
    <summary style="font-size:15px">Ответ:</summary>

```bash
$ kubectl get deployments.apps 
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
hnode   2/2     2            2           6h15m

$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
hnode-69bbf574c8-5cvj6   1/1     Running   0          6h16m
hnode-69bbf574c8-vnqcw   1/1     Running   0          6h16m

$ kubectl scale deployment hnode --replicas=5
deployment.apps/hnode scaled

$ kubectl get deployments.apps 
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
hnode   5/5     5            5           6h16m

$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
hnode-69bbf574c8-5cvj6   1/1     Running   0          6h16m
hnode-69bbf574c8-6sld4   1/1     Running   0          23s
hnode-69bbf574c8-885c5   1/1     Running   0          23s
hnode-69bbf574c8-hssxx   1/1     Running   0          23s
hnode-69bbf574c8-vnqcw   1/1     Running   0          6h16m


```

</details>

---


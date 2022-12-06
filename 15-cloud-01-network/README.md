# Домашнее задание к занятию "15.1. Организация сети"

Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако и дополнительной части в AWS по желанию. Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. 

Перед началом работ следует настроить доступ до облачных ресурсов из Terraform используя материалы прошлых лекций и [ДЗ](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax ). А также заранее выбрать регион (в случае AWS) и зону.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

<details>
    <summary style="font-size:15px">Описание:</summary>
1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)
---
</details>

<details>
    <summary style="font-size:15px">Решение:</summary>

Terraform манифесты: [terraform](./terraform)

```bash
vagrant@vagrant:~/homework/15.x/15.1/terraform$ terraform apply  -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

...

yandex_compute_instance.privNodes[0]: Creation complete after 39s [id=fhmisc2onubcaimjif9k]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

Use_this_IP_to_connect = [
  "51.250.2.8",
]
```

![изображение](https://user-images.githubusercontent.com/93001155/205937317-bfa22e95-8bac-4d32-8a86-6e7f647539f1.png)


```bash
vagrant@vagrant:~/homework/15.x/15.1/terraform$ ssh -J 51.250.2.8 192.168.20.20
Warning: Permanently added '192.168.20.20' (ECDSA) to the list of known hosts.
[vagrant@pri-pri1 ~]$ ping mail.ru
PING mail.ru (217.69.139.202) 56(84) bytes of data.
64 bytes from mail.ru (217.69.139.202): icmp_seq=1 ttl=56 time=58.0 ms
64 bytes from mail.ru (217.69.139.202): icmp_seq=2 ttl=56 time=54.1 ms
64 bytes from mail.ru (217.69.139.202): icmp_seq=3 ttl=56 time=52.9 ms
64 bytes from mail.ru (217.69.139.202): icmp_seq=4 ttl=56 time=54.9 ms
64 bytes from mail.ru (217.69.139.202): icmp_seq=5 ttl=56 time=60.7 ms
^C
--- mail.ru ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4005ms
rtt min/avg/max/mdev = 52.964/56.163/60.709/2.838 ms
```


</details>

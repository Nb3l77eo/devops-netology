# Домашнее задание к занятию 15.2 "Вычислительные мощности. Балансировщики нагрузки".
Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако, и дополнительной части в AWS (можно выполнить по желанию). Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. Перед началом работ следует настроить доступ до облачных ресурсов из Terraform, используя материалы прошлых лекций и ДЗ.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)
<details>
    <summary style="font-size:15px">Описание:</summary>

1. Создать bucket Object Storage и разместить там файл с картинкой:
- Создать bucket в Object Storage с произвольным именем (например, _имя_студента_дата_);
- Положить в bucket файл с картинкой;
- Сделать файл доступным из Интернет.
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и web-страничкой, содержащей ссылку на картинку из bucket:
- Создать Instance Group с 3 ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`;
- Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata);
- Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из bucket;
- Настроить проверку состояния ВМ.
3. Подключить группу к сетевому балансировщику:
- Создать сетевой балансировщик;
- Проверить работоспособность, удалив одну или несколько ВМ.
4. *Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Документация
- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group)
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer)
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer)
---

</details>

<details>
    <summary style="font-size:15px">Решение:</summary>


Разворачиваем инфраструктуру манифестами из папки [terraform](./terraform)

```bash

vagrant@vagrant:~/homework/15.x/15.2/terraform$ terraform init

vagrant@vagrant:~/homework/15.x/15.2/terraform$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  
...

Apply complete! Resources: 21 added, 0 changed, 0 destroyed.

Outputs:

Application_load_balancer_external_IP = "62.84.118.130"
Manage_node = "84.201.128.132"
Network_load_balancer_external_IP = tolist([
  "158.160.45.12",
])

```



</details>


<details>
    <summary style="font-size:15px">Скриншоты:</summary>

![изображение](https://user-images.githubusercontent.com/93001155/206725745-a3bb36e7-1c75-4b20-955c-be9ba696fcde.png)

![изображение](https://user-images.githubusercontent.com/93001155/206725759-9745cad9-7daf-4461-87e3-164f4c1a136c.png)

![изображение](https://user-images.githubusercontent.com/93001155/206725784-39ef46db-affe-480e-a83e-571276541dda.png)

![изображение](https://user-images.githubusercontent.com/93001155/206725817-e8e2fcbb-7ea6-40a1-9aae-898811d2f153.png)

![изображение](https://user-images.githubusercontent.com/93001155/206725866-fd2af0b4-9970-4ce8-bda4-0aa3dec8d33b.png)

![изображение](https://user-images.githubusercontent.com/93001155/206725890-7cd8cf98-61e7-4eb3-b080-f1736ef8a494.png)


</details>

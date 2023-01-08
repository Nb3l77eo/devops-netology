# Домашнее задание к занятию 15.3 "Безопасность в облачных провайдерах"
Используя конфигурации, выполненные в рамках предыдущих домашних заданиях, нужно добавить возможность шифрования бакета.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

<details>
    <summary style="font-size:15px">Описание:</summary>

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:
- Создать ключ в KMS,
- С помощью ключа зашифровать содержимое бакета, созданного ранее.
2. (Выполняется НЕ в terraform) *Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS
- Создать сертификат,
- Создать статическую страницу в Object Storage и применить сертификат HTTPS,
- В качестве результата предоставить скриншот на страницу с сертификатом в заголовке ("замочек").

Документация
- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate)
- [Object storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket)
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key)

</details>


<details>
    <summary style="font-size:15px">Решение:</summary>

1. Terraform манифесты с использованием шифрования бакета при помощи KMS доступны в папке [terraform_kms](./terraform_kms)

2. Снимки подтверждающие выполнение второй части задания:

![изображение](https://user-images.githubusercontent.com/93001155/208243477-9ad87f82-1daf-4623-a4ed-1b9c0aa47d38.png)

![изображение](https://user-images.githubusercontent.com/93001155/208243506-2bb96426-b62d-4cf0-b785-dfa2cb7ea6c8.png)

![изображение](https://user-images.githubusercontent.com/93001155/208243530-80db93c5-b141-4a96-80c0-31bd2b3453fa.png)

![изображение](https://user-images.githubusercontent.com/93001155/208243580-13627467-2a63-4d75-9085-c8d5b68b5a92.png)





</details>



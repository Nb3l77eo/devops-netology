### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Невозможно использовать оператор "+" для разных типов данных.  |
| Как получить для переменной `c` значение 12?  | c=str(a)+b  |
| Как получить для переменной `c` значение 3?  | c=a+int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/pygit", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()

path_cmd = []
path_cmd.append(bash_command[0])
path_cmd.append("pwd")
full_path = os.popen(' && '.join(path_cmd)).read()
full_path = full_path.replace('\n', '')
#print(full_path)

is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        prepare_result = prepare_result.replace(' ', '')
        print(full_path,"/", prepare_result, sep="")
        #break
```

### Вывод скрипта при запуске при тестировании:
```
~$ ./script.py
/home/vagrant/pygit/1.txt
/home/vagrant/pygit/3.txt
/home/vagrant/pygit/5.txt
/home/vagrant/pygit/q/q.txt
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
from os import path
import sys

try:
    arg1 = sys.argv[1]
    if arg1[-1] != "/":
        arg1 = arg1 + "/"
    repo_path = arg1
except IndexError:
    repo_path = os.getcwd()
    repo_path = repo_path.replace('\n', '')
    if repo_path[-1] != "/":
       repo_path = repo_path + "/"
    print("Не задан путь репозитория. Проверка репозитория по расположению скрипта.", repo_path)

if int(path.isdir(repo_path)) == 0:
  print("Ошибка доступа к директории")
  exit()

bash_command = ["cd " + repo_path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()

is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        prepare_result = prepare_result.replace(' ', '')
        print(repo_path, prepare_result, sep="")

```

### Вывод скрипта при запуске при тестировании:
```
$ ./arg.py
Не задан путь репозитория. Проверка репозитория по расположению скрипта. /home/vagrant/pygit/
/home/vagrant/pygit/1.txt
/home/vagrant/pygit/3.txt
/home/vagrant/pygit/5.txt
/home/vagrant/pygit/q/q.txt

$ ./arg.py /home/vagrant/pygit
/home/vagrant/pygit/1.txt
/home/vagrant/pygit/3.txt
/home/vagrant/pygit/5.txt
/home/vagrant/pygit/q/q.txt

$ ./arg.py /wrong_dir
Ошибка доступа к директории

$ ./arg.py /home/vagrant
fatal: not a git repository (or any of the parent directories): .git

```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time

ns = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}

while True:
    for k, v in ns.items():
        ip = socket.gethostbyname(k)
        if ip != v:
            if v == '':
                print(k, '-', ip)
                ns[k] = ip
            else:
                print('[ERROR]', k, 'IP mismatch:', v, ip)
                ns[k] = ip
    time.sleep(3)
```

### Вывод скрипта при запуске при тестировании:
```
$ ./dns.py
drive.google.com - 74.125.131.194
mail.google.com - 64.233.163.17
google.com - 173.194.221.138
[ERROR] mail.google.com IP mismatch: 64.233.163.17 64.233.163.18
[ERROR] mail.google.com IP mismatch: 64.233.163.18 64.233.163.83
[ERROR] drive.google.com IP mismatch: 74.125.131.194 108.177.14.194
[ERROR] google.com IP mismatch: 173.194.221.138 173.194.221.100
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```
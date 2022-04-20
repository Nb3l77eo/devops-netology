06-db-02-sql.md

# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

### Ответ:

```
version: '2.1'

networks:
  monitoring:
    driver: bridge


services:


  db:
    image: postgres:12.10
    restart: always
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/backup
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: example

```


## Задача 2

В БД из задачи 1:

    создайте пользователя test-admin-user и БД test_db
    в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
    предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
    создайте пользователя test-simple-user
    предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:

    id (serial primary key)
    наименование (string)
    цена (integer)

Таблица clients:

    id (serial primary key)
    фамилия (string)
    страна проживания (string, index)
    заказ (foreign key orders)

Приведите:

    итоговый список БД после выполнения пунктов выше,
    описание таблиц (describe)
    SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
    список пользователей с правами над таблицами test_db


### Ответ:
```
# psql -h 127.0.0.1 -d postgres -U postgres

postgres=# create database test_db;
CREATE DATABASE
postgres=# create user "test-admin-user" with encrypted password 'example';
CREATE ROLE
test_db=# create table orders ( id serial primary key, наименование text, цена int );
CREATE TABLE
test_db=# create table clients ( id serial primary key, фамилия text, "страна проживания" text , "заказ" int, FOREIGN KEY ("заказ") REFERENCES orders(id));
CREATE TABLE
test_db=# create index country on clients ( "страна проживания" );
CREATE INDEX
test_db=# grant ALL on TABLE orders TO "test-admin-user" ;
GRANT
test_db=# grant ALL on TABLE clients TO "test-admin-user" ;
GRANT
test_db=# create user "test-simple-user" with encrypted password 'example';
CREATE ROLE
test_db=# grant SELECT,UPDATE,INSERT,DELETE on TABLE orders TO "test-simple-user" ;
GRANT
test_db=# grant SELECT,UPDATE,INSERT,DELETE on TABLE clients TO "test-simple-user" ;
GRANT


postgres=# \l
                                     List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |       Access privileges
-----------+----------+----------+------------+------------+--------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
           |          |          |            |            | postgres=CTc/postgres         +
           |          |          |            |            | "test-admin-user"=CTc/postgres
(4 rows)


test_db=# \d orders
                               Table "public.orders"
    Column    |  Type   | Collation | Nullable |              Default
--------------+---------+-----------+----------+------------------------------------
 id           | integer |           | not null | nextval('orders_id_seq'::regclass)
 наименование | text    |           |          |
 цена         | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)

test_db=# \d clients
                                  Table "public.clients"
      Column       |  Type   | Collation | Nullable |               Default
-------------------+---------+-----------+----------+-------------------------------------
 id                | integer |           | not null | nextval('clients_id_seq'::regclass)
 фамилия           | text    |           |          |
 страна проживания | text    |           |          |
 заказ             | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country" btree ("страна проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)


test_db=# select grantee, privilege_type from information_schema.role_table_grants where table_name='orders';
     grantee      | privilege_type
------------------+----------------
 postgres         | INSERT
 postgres         | SELECT
 postgres         | UPDATE
 postgres         | DELETE
 postgres         | TRUNCATE
 postgres         | REFERENCES
 postgres         | TRIGGER
 test-admin-user  | INSERT
 test-admin-user  | SELECT
 test-admin-user  | UPDATE
 test-admin-user  | DELETE
 test-admin-user  | TRUNCATE
 test-admin-user  | REFERENCES
 test-admin-user  | TRIGGER
 test-simple-user | INSERT
 test-simple-user | SELECT
 test-simple-user | UPDATE
 test-simple-user | DELETE
(18 rows)


test_db=# select grantee, privilege_type from information_schema.role_table_grants where table_name='clients';
     grantee      | privilege_type
------------------+----------------
 postgres         | INSERT
 postgres         | SELECT
 postgres         | UPDATE
 postgres         | DELETE
 postgres         | TRUNCATE
 postgres         | REFERENCES
 postgres         | TRIGGER
 test-admin-user  | INSERT
 test-admin-user  | SELECT
 test-admin-user  | UPDATE
 test-admin-user  | DELETE
 test-admin-user  | TRUNCATE
 test-admin-user  | REFERENCES
 test-admin-user  | TRIGGER
 test-simple-user | INSERT
 test-simple-user | SELECT
 test-simple-user | UPDATE
 test-simple-user | DELETE
(18 rows)
```



## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

### Ответ:
```
test_db=# insert into orders ("наименование","цена") values
test_db-# ('Шоколад', 10),
test_db-# ('Принтер', 3000),
test_db-# ('Книга', 500),
test_db-# ('Монитор', 7000),
test_db-# ('Гитара', 4000);
INSERT 0 5

test_db=# insert into clients ("фамилия","страна проживания") values
test_db-# ('Иванов Иван Иванович', 'USA'),
test_db-# ('Петров Петр Петрович', 'Canada'),
test_db-# ('Иоганн Себастьян Бах', 'Japan'),
test_db-# ('Ронни Джеймс Дио', 'Russia'),
test_db-# ('Ritchie Blackmore', 'Russia');
INSERT 0 5

test_db=# select count(*) from clients;
 count
-------
     5
(1 row)

test_db=# select count(*) from orders;
 count
-------
     5
(1 row)

```




## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

### Ответ:
```
test_db=# update clients set orders=3 where id=1;
UPDATE 1
test_db=# update clients set orders=4 where id=2;
UPDATE 1
test_db=# update clients set orders=5 where id=3;
UPDATE 1
test_db=#

test_db=# select "фамилия" from clients where "заказ" is not null;
       фамилия
----------------------
 Иванов Иван Иванович
 Петров Петр Петрович
 Иоганн Себастьян Бах
(3 rows)

```


## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.


### Ответ:
```
test_db=# explain select "фамилия" from clients where "заказ" is not null;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=32)
   Filter: ("заказ" IS NOT NULL)
(2 rows)

Числа, перечисленные в скобках (слева направо), имеют следующий смысл:

- Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных, например для сортирующего узла это время сортировки.

- Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки. На практике родительский узел может досрочно прекратить чтение строк дочернего (см. приведённый ниже пример с LIMIT).

- Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.

- Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).

В выводе EXPLAIN показано, что условие WHERE применено как «фильтр» к узлу плана Seq Scan (Последовательное сканирование). Это означает, что узел плана проверяет это условие для каждого просканированного им узла и выводит только те строки, которые удовлетворяют ему. Предложение WHERE повлияло на оценку числа выходных строк. Однако при сканировании потребуется прочитать все  строки.
```

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

### Ответ:
```
# pg_dumpall -h 127.0.0.1 -U postgres > backup/db_all

Останавливаем докер, очищаем папку с файлами СУБД. Запускаем докер, подключаемся к базе и видим отсутствие наших пользователей и базы. Восстанавливаем:

# psql -h 127.0.0.1 -U postgres -f backup/db_all
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

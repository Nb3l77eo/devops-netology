06-db-04-postgresql.md

# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Ответ:
```
# cat docker-compose.yaml
version: '2.1'

networks:
  monitoring:
    driver: bridge


services:


  db:
    image: postgres:13.6
    restart: always
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/backup
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: example

# psql -h 127.0.0.1 -d postgres -U postgres
Password for user postgres:
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
Type "help" for help.


postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \c postgres
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
You are now connected to database "postgres" as user "postgres".


test_db=# create table test_tbl (id int, name text);
CREATE TABLE
test_db=# \d
          List of relations
 Schema |   Name   | Type  |  Owner
--------+----------+-------+----------
 public | test_tbl | table | postgres
(1 row)


test_db=# \d test_tbl
              Table "public.test_tbl"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           |          |
 name   | text    |           |          |


test_db=# \q

```


## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

### Ответ:
```
# psql -h 127.0.0.1 -d postgres -U postgres
Password for user postgres:
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
Type "help" for help.

postgres=# create database test_database;
CREATE DATABASE


# psql -h 127.0.0.1 -d test_database -U postgres  < test_data/test_dump.sql
Password for user postgres:
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE

postgres=# \c test_database
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6 (Debian 13.6-1.pgdg110+1))
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
You are now connected to database "test_database" as user "postgres".
test_database=# \d
              List of relations
 Schema |     Name      |   Type   |  Owner
--------+---------------+----------+----------
 public | orders        | table    | postgres
 public | orders_id_seq | sequence | postgres
(2 rows)


test_database=# select tablename,avg_width from  pg_stats where tablename='orders' order by avg_width desc limit 1;
 tablename | avg_width
-----------+-----------
 orders    |        16
(1 row)


```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Ответ:

```
begin;
-- Переименовываем текущую таблицу с данными.
ALTER TABLE orders RENAME to orders_old;
ALTER SEQUENCE orders_id_seq RENAME to orders_id_seq_old;
ALTER INDEX orders_pkey RENAME TO orders_pkey_old;

CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
);

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);

-- Создание необходимых шардов
CREATE TABLE orders_gt499 (
CHECK ( price > 499)
) INHERITS  ( orders);

CREATE TABLE orders_le499 (
CHECK ( price <= 499)
) INHERITS  ( orders);

-- Поскольку дополнительных условий к задаче нет, то воспользуемся более простым вариантом перенаправления в шадры с помощью правил.

CREATE RULE orders_gt499 AS
ON INSERT TO orders WHERE
    ( price > 499 )
DO INSTEAD
    INSERT INTO orders_gt499 VALUES (NEW.*);

CREATE RULE orders_le499 AS
ON INSERT TO orders WHERE
    ( price <= 499 )
DO INSTEAD
    INSERT INTO orders_le499 VALUES (NEW.*);

-- Перенос данных
insert into orders (id,title,price) select id,title,price from orders_old order by id;

-- далее можно удалить ненужные объекты
drop table orders_old;
commit;
```

```
Возможно реализовать автоматическое разбиение данных по шардам с помощью функций и триггеров с автоматическим созданий шардов. Важным условием данного функционала является понимание/определение условий шардирования. 
```



## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?


### Ответ:
```
Ограничение уникальных значение задается через UNIQUE. В секционированных таблицах для установки уникальности необходимо включать в определение ограничения столбец по которому происходит секционирование.

```

### Ответ-Доработка:
```
--Получение РК
# pg_dump -h 127.0.0.1 -U postgres -d test_database > /backup/test_db.bak

--Для необходимости соблюдения уникальности по title в таблице orders и ее шардах необходимо создавать со следующими параметрами:

CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0,
    CONSTRAINT orders_id_title_pkey PRIMARY KEY(id, title)
);

CREATE TABLE orders_gt499 (
CONSTRAINT "orders_gt499_id_title_pkey" PRIMARY KEY(id, title),
CONSTRAINT constraint_orders_gt499 CHECK ( price > 499)
) INHERITS  ( orders);

CREATE TABLE orders_le499 (
CONSTRAINT "orders_le499_id_title_pkey" PRIMARY KEY(id, title),
CONSTRAINT constraint_orders_le499 CHECK ( price <= 499)
) INHERITS  ( orders);

```



---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

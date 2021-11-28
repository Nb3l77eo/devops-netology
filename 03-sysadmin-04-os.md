# Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

1. На лекции мы познакомились с [node_exporter](https://github.com/prometheus/node_exporter/releases). В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой [unit-файл](https://www.freedesktop.org/software/systemd/man/systemd.service.html) для node_exporter:

    * поместите его в автозагрузку,
    * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`),
    * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.


	```
	Ответ:
	$ sudo groupadd --system nexporter
	$ sudo useradd --system -g nexporter -s /bin/false nexporter
	$ wget https://github.com/prometheus/node_exporter/releases/download/v1.3.0/node_exporter-1.3.0.linux-amd64.tar.gz -O - | tar -xzv -C /tmp
	$ sudo cp /tmp/node_exporter-1.3.0.linux-amd64/node_exporter /usr/local/bin/
	$ sudo chown -R nexporter:nexporter /usr/local/bin/node_exporter
	$ sudo cat > node_exporter.service
	[Unit]
	Description=Node Exporter
	After=network.target

	[Service]
	Type=simple
	Restart=always
	User=nexporter
	Group=nexporter
	ExecStart=/usr/local/bin/node_exporter $EXTRA_OPTS

	[Install]
	WantedBy=multi-user.target
	$ sudo cp node_exporter.service /etc/systemd/system
	$ sudo systemctl daemon-reload
	$ sudo systemctl start node_exporter.service
	$ sudo systemctl enable node_exporter.service
	$ sudo systemctl status node_exporter.service
	● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2021-11-26 21:31:39 UTC; 33s ago
	
	
	
	
	```


1. Ознакомьтесь с опциями node_exporter и выводом `/metrics` по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

	```
	Ответ:
	node_cpu_seconds_total
	node_memory_MemFree
	node_memory_Cached
	node_memory_Buffers
	node_memory_MemTotal
	node_filesystem_avail_bytes
	node_network_receive_bytes_total
	
	```


1. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). После успешной установки:
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`,
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```

    После успешной перезагрузки в браузере *на своем ПК* (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.
	

	```
	Ответ:
	Ознакомился
	
	```


1. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

	```
	Ответ:
	[    0.000000] kernel: Hypervisor detected: KVM 
	
	```

1. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?

	```
	Ответ:
	fs.nr_open - ограничение количества открытых дескрипторов для процесса
	$ sysctl fs.nr_open
	fs.nr_open = 1048576
	$ ulimit -aH | grep open - жесткое ограничение
	open files                      (-n) 1048576
	$ ulimit -aS | grep open - мягкое ограничение, может быть изменено пользователем, но не более чем жесткое
	open files                      (-n) 1024
	$ sysctl fs.file-max
	fs.file-max = 9223372036854775807 - ограничение максимального количества открытых дескрипторов в системе
	
	```

1. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.

	```
	Ответ:
	Терминал1:
	$ sudo -i
	# unshare -f --pid --mount-proc sleep 1h
	
	
	Терминал2:
	$ sudo -i
	# ps axu | grep sleep
	root        1255  0.0  0.0   8080   592 pts/0    S+   20:49   0:00 unshare -f --pid --mount-proc sleep 1h
	root        1256  0.0  0.0   8076   596 pts/0    S+   20:49   0:00 sleep 1h
	# nsenter -t 1256 -p -r ps axu
	USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
	root           1  0.0  0.0   8076   596 pts/0    S+   20:49   0:00 sleep 1h
	root           2  0.0  0.3  11492  3252 pts/1    R+   20:50   0:00 ps axu
	
	
	```

1. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

	```
	Ответ:
	Ограничение на максимальное количество процессов. При его достижении ранее успешно созданные форки не могут выполнить свое дублирование, поэтому действие прекращается через некоторое время.
	$ ulimit -u
	3571
	Для изменения необходимо в файл /etc/security/limits.conf добавить следующее:
	soft nproc 65535
	hard nproc 65535
	
	
	```

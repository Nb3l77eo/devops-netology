# Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. Какой системный вызов делает команда `cd`? В прошлом ДЗ мы выяснили, что `cd` не является самостоятельной  программой, это `shell builtin`, поэтому запустить `strace` непосредственно на `cd` не получится. Тем не менее, вы можете запустить `strace` на `/bin/bash -c 'cd /tmp'`. В этом случае вы увидите полный список системных вызовов, которые делает сам `bash` при старте. Вам нужно найти тот единственный, который относится именно к `cd`. Обратите внимание, что `strace` выдаёт результат своей работы в поток stderr, а не в stdout.
	
	```
	Ответ:
	chdir
	```
	
1. Попробуйте использовать команду `file` на объекты разных типов на файловой системе. Например:
    ```bash
    vagrant@netology1:~$ file /dev/tty
    /dev/tty: character special (5/0)
    vagrant@netology1:~$ file /dev/sda
    /dev/sda: block special (8/0)
    vagrant@netology1:~$ file /bin/bash
    /bin/bash: ELF 64-bit LSB shared object, x86-64
    ```
    Используя `strace` выясните, где находится база данных `file` на основании которой она делает свои догадки.
	
	
	```
	Ответ:
	/usr/lib/locale/locale-archive
	/usr/share/misc/magic.mgc
	```
	
	
1. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
	```
	Ответ:
	$ > filename
	$ echo -n > filename
	```


1. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
	
	```
	Ответ:
	Зомби не занимают памяти, но блокируют записи в таблице процессов, размер которой ограничен для каждого пользователя и системы в целом.
	```

1. В iovisor BCC есть утилита `opensnoop`:
    ```bash
    root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
    ```
    На какие файлы вы увидели вызовы группы `open` за первую секунду работы утилиты? Воспользуйтесь пакетом `bpfcc-tools` для Ubuntu 20.04. Дополнительные [сведения по установке](https://github.com/iovisor/bcc/blob/master/INSTALL.md).
	
	
	```
	Ответ:
	$ sudo opensnoop-bpfcc
	PID    COMM               FD ERR PATH
	784    vminfo              4   0 /var/run/utmp
	586    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
	586    dbus-daemon        17   0 /usr/share/dbus-1/system-services
	586    dbus-daemon        -1   2 /lib/dbus-1/system-services
	586    dbus-daemon        17   0 /var/lib/snapd/dbus-1/system-services/
	394    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
	394    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
	602    irqbalance          6   0 /proc/interrupts
	602    irqbalance          6   0 /proc/stat	
	```
	
1. Какой системный вызов использует `uname -a`? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в `/proc`, где можно узнать версию ядра и релиз ОС.

	```
	Ответ:
	Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
	```

1. Чем отличается последовательность команд через `;` и через `&&` в bash? Например:
    ```bash
    root@netology1:~# test -d /tmp/some_dir; echo Hi
    Hi
    root@netology1:~# test -d /tmp/some_dir && echo Hi
    root@netology1:~#
    ```
    Есть ли смысл использовать в bash `&&`, если применить `set -e`?
	
	```
	Ответ:
	; - команды выполняются по порядку не зависимо от кода завершения
	&& - логическое "и". Следующая команда выполняется только при коде входа 0 предыдущей.
	"set -e" - завершает работу оболочки если команда вернула не нулевой код выхода.
	"set -e" не будет работать внутри until, while с if,&&,|| и если к статусу выхода команды применяется отрицание с помощью оператора !
		
	```
	
	
1. Из каких опций состоит режим bash `set -euxo pipefail` и почему его хорошо было бы использовать в сценариях?

	```
	Ответ:
	-e - выход из оболочки если код выполнения команды не равен 0
	-u - проверка на определение переменных, в ином случае: unbound variable
	-x - вывод запускаемой команды в терминал 
	-o pipeline - возвращает код выхода отличный от нуля в самой правой команде от pipeline, если хотя бы одна команда вернула код выхода отличный от нуля до нее
	
	Данные опции удобно использовать в сценариях, т.к. они упрощают его отладку/проверку.
	
	```


1. Используя `-o stat` для `ps`, определите, какой наиболее часто встречающийся статус у процессов в системе. В `man ps` ознакомьтесь (`/PROCESS STATE CODES`) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

	```
	Ответ:
	$ ps axo stat --no-headers | sort | uniq -c
      8 I
     40 I<
      1 R+
     26 S
      4 S+
      1 Sl
      1 SLsl
      2 SN
      1 S<s
     16 Ss
      1 Ss+
      4 Ssl

	Большая часть процессов в статусе interruptible sleep (waiting for an event to complete) - спящие.
	```

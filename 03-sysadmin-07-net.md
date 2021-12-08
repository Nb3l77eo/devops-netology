# Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2" 03-sysadmin-07-net.md

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

	```
	Ответ:
	windows:
	ipconfig /all
	
	linux:
	$ ip -c -br link
	$ ip a
	$ ls /sys/class/net
	$ cat /proc/net/dev
	```

2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

	```
	Ответ:
	Протокол обмена информацией между соседями - LLDP
	
	# lldpctl	
	
	```

3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

	```
	Ответ:
	VLAN -  IEEE 802.1Q
	
	Для настройки vlan в linux возможно использовать vconfig.
	
	# /sbin/vconfig add eth0 2
	# /sbin/ifconfig eth0.2 10.10.10.х netmask 255.255.255.0 up
	
	Для сохранения настроек после перезагрузки необходимо добавить её в файл /etc/network/interfaces
	auto vlan2
	iface vlan2 inet static
			address 10.10.10.0
			netmask 255.255.255.0
			vlan_raw_device eth0
	
	
	```

4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

	```
	Ответ:
	
	Статическое агрегирование:

		Преимущества:
			Не вносит дополнительную задержку при поднятии агрегированного канала или изменении его настроек
			Вариант, который рекомендует использовать Cisco 
		Недостатки:
			Нет согласования настроек с удаленной стороной. Ошибки в настройке могут привести к образованию петель 

	Агрегирование с помощью LACP:

		Преимущества:
			Согласование настроек с удаленной стороной позволяет избежать ошибок и петель в сети.
			Поддержка standby-интерфейсов позволяет агрегировать до 16ти портов, 8 из которых будут активными, а остальные в режиме standby 
		Недостатки:
			Вносит дополнительную задержку при поднятии агрегированного канала или изменении его настроек 

	
	
	#
	# LACP bonded mode - and the bond is provisioned as a TRUNK (NOT an ACCESS port)
	# Required for bonding:
	#aptitude install vlan ifenslave
	# echo "8021q" >> /etc/modules
	# 
	#cat /etc/modprobe.d/bonding.conf 
	#alias bond0 bonding
	#options bonding mode=4  miimon=100 downdelay=200 updelay=200
	#


	###### Bonded 10Gig setup - LACP Aggregation #######
	## View status in:    /proc/net/bonding


	auto bond0
	iface bond0 inet manual
			bond-slaves eno1 eno2
	# bond-mode 4 = 802.3ad AKA LACP
			bond-mode 4
			bond-miimon 100
			bond-downdelay 200
			bond-updelay 200
			bond-lacp-rate 1
			bond-xmit-hash-policy layer2+3
			up ifconfig bond0 0.0.0.0 up

	### trunked interface (configured as an 802.3ad AKA LACP bond on upstream switch)
	# split out vlan 123 and vlan 456 from this bond on seperate interfaces

	auto bond0.123
	iface bond0.123 inet static

			address 10.123.0.3
			netmask 255.255.255.0
			mtu 1500
			gateway 10.123.0.1
			vlan-raw-device bond0
			post-up ifconfig bond0.123 mtu 1500


	# note this VLAN has a different MTU value
	auto bond0.456
	iface bond0.456 inet static

			address 192.168.456.4
			netmask 255.255.255.0
			mtu 9000
			vlan-raw-device bond0
			post-up ifconfig vlan456 mtu 9000
			post-up ifconfig eno1 mtu 9000 && ifconfig eno2 mtu 9000 && ifconfig bond0 mtu 9000 && ifconfig bond0.456 9000

	# Note: upstream bond and member interfaces must have MTU9000, then lower level VLANS can use MTU1500 or MTU9000
	
	```

5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

	```
	Ответ:
	В сети с /29 маской 8 ip адресов.
	
	Из /24 сети можно выделить 32 сети с маской /29.
	
	10.10.10.40/29
	10.10.10.136/29
	
	
	```

6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

	```
	Ответ:
	100.64.0.0/10 - Свободная подсеть
	
	100.64.0.64/26 - Можно использовать.
	
	# ipcalc 100.64.0.64/26
	Address:   100.64.0.64          01100100.01000000.00000000.01 000000
	Netmask:   255.255.255.192 = 26 11111111.11111111.11111111.11 000000
	Wildcard:  0.0.0.63             00000000.00000000.00000000.00 111111
	=>
	Network:   100.64.0.64/26       01100100.01000000.00000000.01 000000
	HostMin:   100.64.0.65          01100100.01000000.00000000.01 000001
	HostMax:   100.64.0.126         01100100.01000000.00000000.01 111110
	Broadcast: 100.64.0.127         01100100.01000000.00000000.01 111111
	Hosts/Net: 62                    Class A

	
	
	```

7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

	```
	Ответ:
	
	windows:
	D:\HashiCorp\Vagrant\bin>arp -a

	Интерфейс: 192.168.0.2 --- 0x9
	  адрес в Интернете      Физический адрес      Тип
	  192.168.0.1           60-ce-86-81-a9-20     динамический
	  192.168.0.10          08-00-27-de-7d-b5     динамический
	  192.168.0.255         ff-ff-ff-ff-ff-ff     статический
	  224.0.0.2             01-00-5e-00-00-02     статический
	  224.0.0.22            01-00-5e-00-00-16     статический
	  224.0.0.251           01-00-5e-00-00-fb     статический
	  224.0.0.252           01-00-5e-00-00-fc     статический
	  239.255.255.250       01-00-5e-7f-ff-fa     статический
	  255.255.255.255       ff-ff-ff-ff-ff-ff     статический
	
	D:\HashiCorp\Vagrant\bin>arp -d 192.168.0.10
	
	D:\HashiCorp\Vagrant\bin>arp -a

	Интерфейс: 192.168.0.2 --- 0x9
	  адрес в Интернете      Физический адрес      Тип
	  192.168.0.1           60-ce-86-81-a9-20     динамический
	  192.168.0.255         ff-ff-ff-ff-ff-ff     статический
	  224.0.0.2             01-00-5e-00-00-02     статический
	  224.0.0.22            01-00-5e-00-00-16     статический
	  224.0.0.251           01-00-5e-00-00-fb     статический
	  224.0.0.252           01-00-5e-00-00-fc     статический
	  239.255.255.250       01-00-5e-7f-ff-fa     статический
	  255.255.255.255       ff-ff-ff-ff-ff-ff     статический

	D:\HashiCorp\Vagrant\bin>arp -d *

	D:\HashiCorp\Vagrant\bin>arp -a

	Интерфейс: 192.168.0.2 --- 0x9
	  адрес в Интернете      Физический адрес      Тип
	  192.168.0.1           60-ce-86-81-a9-20     динамический
	  224.0.0.2             01-00-5e-00-00-02     статический
	  224.0.0.22            01-00-5e-00-00-16     статический
	
	
	
	
	
	linux:
	# arp
	Address                  HWtype  HWaddress           Flags Mask            Iface
	192.168.0.2              ether   70:85:c2:92:9f:a6   C                     eth1
	192.168.0.3              ether   f0:b4:29:88:50:d3   C                     eth1
	192.168.0.4                      (incomplete)                              eth1
	192.168.0.1              ether   60:ce:86:81:a9:20   C                     eth1
	192.168.0.38                     (incomplete)                              eth1
	192.168.0.7              ether   00:1a:e8:0d:45:fe   C                     eth1
	192.168.0.8                      (incomplete)                              eth1
	192.168.0.5                      (incomplete)                              eth1

	# arp -d 192.168.0.3

	# arp
	Address                  HWtype  HWaddress           Flags Mask            Iface
	192.168.0.2              ether   70:85:c2:92:9f:a6   C                     eth1
	192.168.0.4                      (incomplete)                              eth1
	192.168.0.1              ether   60:ce:86:81:a9:20   C                     eth1
	192.168.0.38                     (incomplete)                              eth1
	192.168.0.7              ether   00:1a:e8:0d:45:fe   C                     eth1
	192.168.0.8                      (incomplete)                              eth1
	192.168.0.5                      (incomplete)                              eth1

	# ip link set arp off dev eth1; ip link set arp on dev eth1

	# arp
	Address                  HWtype  HWaddress           Flags Mask            Iface
	192.168.0.2              ether   70:85:c2:92:9f:a6   C                     eth1
	192.168.0.1              ether   60:ce:86:81:a9:20   C                     eth1
	### Таблица очистилась, но поскольку ОС отправляет запросы в интернет (шлюз по-умолчанию 192.168.0.1) и к виртуальной машине я подключен через ssh c ip 192.168.0.2, то эти записи в таблице появились практически сразу.
	
	```

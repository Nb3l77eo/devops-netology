# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3" 03-sysadmin-08-net.md

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```

	```
	Ответ:
	route-views>show ip route 5.140.27.184/32
                                      ^
	% Invalid input detected at '^' marker.

	route-views>show ip route 5.140.27.184
	Routing entry for 5.140.0.0/19
	  Known via "bgp 6447", distance 20, metric 0
	  Tag 6939, type external
	  Last update from 64.71.137.241 1w2d ago
	  Routing Descriptor Blocks:
	  * 64.71.137.241, from 64.71.137.241, 1w2d ago
		  Route metric is 0, traffic share count is 1
		  AS Hops 2
		  Route tag 6939
		  MPLS label: none
	
	route-views>show bgp 5.140.27.184
	BGP routing table entry for 5.140.0.0/19, version 1388581588
	Paths: (24 available, best #23, table default)
	  Not advertised to any peer
	  Refresh Epoch 1
	  2497 12389
		202.232.0.2 from 202.232.0.2 (58.138.96.254)
		  Origin IGP, localpref 100, valid, external
		  path 7FE0EBF30030 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  3267 1299 12389
		194.85.40.15 from 194.85.40.15 (185.141.126.1)
		  Origin IGP, metric 0, localpref 100, valid, external
		  path 7FE164740A28 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  20912 3257 3356 12389
		212.66.96.126 from 212.66.96.126 (212.66.96.126)
		  Origin IGP, localpref 100, valid, external
		  Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:650                                                                                                                                                             04
		  path 7FE0FA95A0A8 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 3
	  3303 12389
		217.192.89.50 from 217.192.89.50 (138.187.128.158)
		  Origin IGP, localpref 100, valid, external
		  Community: 3303:1004 3303:1006 3303:1030 3303:3056
		  path 7FE16BF4CD48 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  4901 6079 3356 12389
		162.250.137.254 from 162.250.137.254 (162.250.137.254)
		  Origin IGP, localpref 100, valid, external
		  Community: 65000:10100 65000:10300 65000:10400
		  path 7FE1300DE1B0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  7660 2516 12389
		203.181.248.168 from 203.181.248.168 (203.181.248.168)
		  Origin IGP, localpref 100, valid, external
		  Community: 2516:1050 7660:9003
		  path 7FE1086B0148 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  57866 3356 12389
		37.139.139.17 from 37.139.139.17 (37.139.139.17)
		  Origin IGP, metric 0, localpref 100, valid, external
		  Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
		  path 7FE001F07888 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  7018 3356 12389
		12.0.1.63 from 12.0.1.63 (12.0.1.63)
		  Origin IGP, localpref 100, valid, external
		  Community: 7018:5000 7018:37232
		  path 7FE0208846F8 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  3333 1103 12389
		193.0.0.56 from 193.0.0.56 (193.0.0.56)
		  Origin IGP, localpref 100, valid, external
		  path 7FE0AF3687C0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  49788 12552 12389
		91.218.184.60 from 91.218.184.60 (91.218.184.60)
		  Origin IGP, localpref 100, valid, external
		  Community: 12552:12000 12552:12100 12552:12101 12552:22000
		  Extended Community: 0x43:100:1
		  path 7FE0FE9B5548 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  8283 1299 12389
		94.142.247.3 from 94.142.247.3 (94.142.247.3)
		  Origin IGP, metric 0, localpref 100, valid, external
		  Community: 1299:30000 8283:1 8283:101
		  unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
			value 0000 205B 0000 0000 0000 0001 0000 205B
				  0000 0005 0000 0001
		  path 7FE14BFF9870 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  3356 12389
		4.68.4.46 from 4.68.4.46 (4.69.184.201)
		  Origin IGP, metric 0, localpref 100, valid, external
		  Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
		  path 7FE0BE013408 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  1221 4637 12389
		203.62.252.83 from 203.62.252.83 (203.62.252.83)
		  Origin IGP, localpref 100, valid, external
		  path 7FE0BE122210 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  852 3491 12389
		154.11.12.212 from 154.11.12.212 (96.1.209.43)
		  Origin IGP, metric 0, localpref 100, valid, external
		  path 7FE017AA5AF0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  20130 6939 12389
		140.192.8.16 from 140.192.8.16 (140.192.8.16)
		  Origin IGP, localpref 100, valid, external
		  path 7FE14989E1C0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  701 1273 12389
		137.39.3.55 from 137.39.3.55 (137.39.3.55)
		  Origin IGP, localpref 100, valid, external
		  path 7FE0F88835E0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  3257 1299 12389
		89.149.178.10 from 89.149.178.10 (213.200.83.26)
		  Origin IGP, metric 10, localpref 100, valid, external
		  Community: 3257:8794 3257:30052 3257:50001 3257:54900 3257:54901
		  path 7FE160646A98 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  3549 3356 12389
		208.51.134.254 from 208.51.134.254 (67.16.168.191)
		  Origin IGP, metric 0, localpref 100, valid, external
		  Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 3549:2581 3549:30840
		  path 7FE0D090C4C0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  53767 14315 6453 6453 3356 12389
		162.251.163.2 from 162.251.163.2 (162.251.162.3)
		  Origin IGP, localpref 100, valid, external
		  Community: 14315:5000 53767:5000
		  path 7FE125937D38 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  101 3491 12389
		209.124.176.223 from 209.124.176.223 (209.124.176.223)
		  Origin IGP, localpref 100, valid, external
		  Community: 101:20300 101:22100 3491:400 3491:415 3491:9001 3491:9080 3491:9081 3491:9087 3491:62210 3491:62220
		  path 7FE08D128CB0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  3561 3910 3356 12389
		206.24.210.80 from 206.24.210.80 (206.24.210.80)
		  Origin IGP, localpref 100, valid, external
		  path 7FE0085D0138 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  1351 6939 12389
		132.198.255.253 from 132.198.255.253 (132.198.255.253)
		  Origin IGP, localpref 100, valid, external
		  path 7FE04D1EC9C0 RPKI State not found
		  rx pathid: 0, tx pathid: 0
	  Refresh Epoch 1
	  6939 12389
		64.71.137.241 from 64.71.137.241 (216.218.252.164)
		  Origin IGP, localpref 100, valid, external, best
		  path 7FE146B62B80 RPKI State not found
		  rx pathid: 0, tx pathid: 0x0
	  Refresh Epoch 1
	  19214 3257 3356 12389
		208.74.64.40 from 208.74.64.40 (208.74.64.40)
		  Origin IGP, localpref 100, valid, external
		  Community: 3257:8108 3257:30048 3257:50002 3257:51200 3257:51203
		  path 7FE18006A308 RPKI State not found
		  rx pathid: 0, tx pathid: 0

	```

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

	```
	Ответ:
	#echo "dummy" >> /etc/modules
	#echo "options dummy numdummies=2" > /etc/modprobe.d/dummy.conf
	
	#cat >> /etc/network/interfaces
	
	auto dummy0
	iface dummy0 inet static
	address 10.2.2.2/32
	pre-up ip link add dummy0 type dummy
	post-down ip link del dummy0
	
	# ip a
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
		link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
		inet 127.0.0.1/8 scope host lo
		   valid_lft forever preferred_lft forever
		inet6 ::1/128 scope host
		   valid_lft forever preferred_lft forever
	2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
		link/ether 08:00:27:73:60:cf brd ff:ff:ff:ff:ff:ff
		inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
		   valid_lft 85792sec preferred_lft 85792sec
		inet6 fe80::a00:27ff:fe73:60cf/64 scope link
		   valid_lft forever preferred_lft forever
	3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
		link/ether 08:00:27:de:7d:b5 brd ff:ff:ff:ff:ff:ff
		inet 192.168.0.10/24 brd 192.168.0.255 scope global dynamic eth1
		   valid_lft 13794sec preferred_lft 13794sec
		inet6 2a01:540:a3cb:e000:7019:1ee5:7102:cedd/128 scope global dynamic noprefixroute
		   valid_lft 2994sec preferred_lft 2994sec
		inet6 fe80::a00:27ff:fede:7db5/64 scope link
		   valid_lft forever preferred_lft forever
	4: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
		link/ether 3a:82:35:d8:bd:75 brd ff:ff:ff:ff:ff:ff
		inet 10.2.2.2/32 brd 10.2.2.2 scope global dummy0
		   valid_lft forever preferred_lft forever
		inet6 fe80::3882:35ff:fed8:bd75/64 scope link
		   valid_lft forever preferred_lft forever
	
	# ip route add 192.168.77.0/24 via 192.168.0.254
	# ip route add 10.40.5.0/24 via 10.50.2.254
	# route -n
	Kernel IP routing table
	Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
	0.0.0.0         10.0.2.2        0.0.0.0         UG    100    0        0 eth0
	0.0.0.0         192.168.0.1     0.0.0.0         UG    100    0        0 eth1
	10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
	10.0.2.2        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
	10.40.5.0       10.50.2.254     255.255.255.0   UG    0      0        0 dummy0
	10.50.2.0       0.0.0.0         255.255.255.0   U     0      0        0 dummy0
	192.168.0.0     0.0.0.0         255.255.255.0   U     0      0        0 eth1
	192.168.0.1     0.0.0.0         255.255.255.255 UH    100    0        0 eth1
	192.168.77.0    192.168.0.254   255.255.255.0   UG    0      0        0 eth1
	
	
	```


3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

	```
	Ответ:
	# netstat -atnp
	Active Internet connections (servers and established)
	Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
	tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      562/systemd-resolve
	tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      685/sshd: /usr/sbin
	tcp        0      0 127.0.0.1:8125          0.0.0.0:*               LISTEN      622/netdata
	tcp        0      0 0.0.0.0:19999           0.0.0.0:*               LISTEN      622/netdata
	tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init
	tcp        0    272 192.168.0.10:22         192.168.0.2:60695       ESTABLISHED 5123/sshd: vagrant
	tcp6       0      0 :::22                   :::*                    LISTEN      685/sshd: /usr/sbin
	tcp6       0      0 ::1:8125                :::*                    LISTEN      622/netdata
	tcp6       0      0 :::9100                 :::*                    LISTEN      624/node_exporter
	tcp6       0      0 :::111                  :::*                    LISTEN      1/init

		
	```


4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

	```
	Ответ:
	# netstat -aunp
	Active Internet connections (servers and established)
	Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
	udp        0      0 127.0.0.1:8125          0.0.0.0:*                           622/netdata
	udp        0      0 127.0.0.53:53           0.0.0.0:*                           562/systemd-resolve
	udp        0      0 192.168.0.10:68         0.0.0.0:*                           404/systemd-network
	udp        0      0 0.0.0.0:111             0.0.0.0:*                           1/init
	udp6       0      0 ::1:8125                :::*                                622/netdata
	udp6       0      0 fe80::a00:27ff:fede:546 :::*                                404/systemd-network
	udp6       0      0 :::111                  :::*                                1/init
	
	
	```


5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали. 

	```
	Ответ:
	https://github.com/Nb3l77eo/devops-netology/blob/main/map.jpg
	
	```

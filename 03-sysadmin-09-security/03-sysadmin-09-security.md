# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем" 03-sysadmin-09-security.md

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

	Ответ:
	```
	![изображение](https://user-images.githubusercontent.com/93001155/146677953-e9599880-e3c4-451f-8c0b-e3c830d3bbcb.png)

	```

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

	Ответ:
	```
	![изображение](https://user-images.githubusercontent.com/93001155/146677966-cb4770e3-1c07-47ea-835b-4760ad4a2b7d.png)

	```
	
3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

	Ответ:
	```
	# openssl req -x509 -nodes -newkey rsa:2048 -days 365 -keyout /etc/ssl/private/my_key.key -out /etc/ssl/private/my_cert.crtGenerating a RSA private key
	.....................................+++++
	.........+++++
	writing new private key to '/etc/ssl/private/my_key.key'
	-----
	You are about to be asked to enter information that will be incorporated
	into your certificate request.
	What you are about to enter is what is called a Distinguished Name or a DN.
	There are quite a few fields but you can leave some blank
	For some fields there will be a default value,
	If you enter '.', the field will be left blank.
	-----
	Country Name (2 letter code) [AU]:RU
	State or Province Name (full name) [Some-State]:
	Locality Name (eg, city) []:Moscow
	Organization Name (eg, company) [Internet Widgits Pty Ltd]:Test Comp LTD.
	Organizational Unit Name (eg, section) []:
	Common Name (e.g. server FQDN or YOUR name) []:
	Email Address []:mail@localhost


	# apt install apache2

	### В файле /etc/apache2/sites-available/default-ssl.conf ноебходимо изменить параметры:
	###                 SSLCertificateFile      /etc/ssl/private/my_cert.crt
	###                 SSLCertificateKeyFile /etc/ssl/private/my_key.key



	# a2ensite default-ssl.conf

	# a2enconf ssl-params

	# apache2ctl configtest

	# systemctl restart apache2

	### В случае необходимости доступа только по https настраивается постоянный редирект.
	```
	
4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

	Ответ:
	```
	# git clone --depth 1 https://github.com/drwetter/testssl.sh.git
	# cd testssl.sh
	
	./testssl.sh -U --sneaky https://zaycev.net/

	###########################################################
		testssl.sh       3.1dev from https://testssl.sh/dev/
		(2201a28 2021-12-13 18:24:34 -- )

		  This program is free software. Distribution and
				 modification under GPLv2 permitted.
		  USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

		   Please file bugs @ https://testssl.sh/bugs/

	###########################################################

	 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
	 on vagrant:./bin/openssl.Linux.x86_64
	 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


	 Start 2021-12-18 20:38:46        -->> 176.58.34.241:443 (zaycev.net) <<--

	 Further IP addresses:   2a02:878:2:3::100
	 rDNS (176.58.34.241):   --
	 Service detected:       HTTP


	 Testing vulnerabilities

	 Heartbleed (CVE-2014-0160)                not vulnerable (OK), timed out
	 CCS (CVE-2014-0224)                       not vulnerable (OK)
	 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
	 ROBOT                                     not vulnerable (OK)
	 Secure Renegotiation (RFC 5746)           supported (OK)
	 Secure Client-Initiated Renegotiation     not vulnerable (OK)
	 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
	 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
											   Can be ignored for static pages or if no secrets in the page
	 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
	 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
	 SWEET32 (CVE-2016-2183, CVE-2016-6329)    VULNERABLE, uses 64 bit block ciphers
	 FREAK (CVE-2015-0204)                     not vulnerable (OK)
	 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
											   make sure you don't use this certificate elsewhere with SSLv2 enabled services
											   https://censys.io/ipv4?q=55A0CF3C79F56A55AF4278C2BA4EC3FEC9FCC98231C00E1E924693AD7C545C81 could help you to find out
	 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
	 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES256-SHA AES256-SHA ECDHE-RSA-AES128-SHA AES128-SHA DES-CBC3-SHA
											   VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
	 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
	 Winshock (CVE-2014-6321), experimental    not vulnerable (OK) - CAMELLIA or ECDHE_RSA GCM ciphers found
	 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


	 Done 2021-12-18 20:39:50 [  68s] -->> 176.58.34.241:443 (zaycev.net) <<--

	```
	
5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

	Ответ:
	
	```
	$ ssh-keygen
	Generating public/private rsa key pair.
	Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
	Enter passphrase (empty for no passphrase):
	Enter same passphrase again:
	Your identification has been saved in /home/vagrant/.ssh/id_rsa
	Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
	The key fingerprint is:
	SHA256:7xZRM08H/vYlU1OL5o6t1pvz8eW6KaDRuvmr1qiIS5w vagrant@vagrant
	The key's randomart image is:
	+---[RSA 3072]----+
	|              ...|
	|            +.o +|
	|           . B.+.|
	|          . o .o.|
	|        S. . .o +|
	| . .    ..+ +  +o|
	|  E      *.+.o .o|
	| . . .  =oo.oo.o+|
	|  o.. .o+==o +B+o|
	+----[SHA256]-----+
	
	$ cat ~/.ssh/id_rsa.pub
	ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7mPAuq7GLcZNLpbpzXtUyYoQPEnr1c47EttUv3ehcdydKBuEE9l3Adcjma95ZS4Uhsw7OwTRBgCPfX44ok3EFL73n0dE3cZAiTukpURpHunQvZ8eGY/Pmv47lgqzXnSs8qQNklaZ9HdXN4GpLDvJIzmfzL3+TlsipDvBPdBX4Tggrth2V60SzlkT8ehx7zWMKpolI6HTCNTV04QmIUvFt+Rd3wEcRcBF9Ul/xw5H2e6qY2XWNClR/Wx3yYUy2+16b3OCdHGCqsXW7uXrcUolcc9qioYwTdCUWuit9TJPmDCuDxN2Cc+dEjG35FnbO2DxdWeYbk0VhLmnQypXCTVu9zlJTR/S/hmFa6ZmxheuF+1b1XBJzTyD9+nSkioE5ldNgxcU2qGhjicV4WeXybAXYQkE1DvBK0KdiehjYtCkBjSyBdIs1wMGsi2hLUGMwh18OE8z1GXpb6Aqt9iFxhG9fjMFOUzYb6LLFZqNv4SYmUoX8bQpeI3tJyLLlPnRajBU= vagrant@vagrant
	
	$ cat ~/.ssh/id_rsa.pub | ssh 192.168.0.13 'cat >> ~/.ssh/authorized_keys'
	vagrant@192.168.0.13's password:
	
	$ ssh 192.168.0.13
	Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)

	 * Documentation:  https://help.ubuntu.com
	 * Management:     https://landscape.canonical.com
	 * Support:        https://ubuntu.com/advantage

	  System information as of Sun 19 Dec 2021 08:51:19 AM UTC

	  System load:  0.08              Processes:             113
	  Usage of /:   2.3% of 61.31GB   Users logged in:       1
	  Memory usage: 14%               IPv4 address for eth0: 10.0.2.15
	  Swap usage:   0%                IPv4 address for eth1: 192.168.0.13


	This system is built by the Bento project by Chef Software
	More information can be found at https://github.com/chef/bento
	Last login: Sun Dec 19 08:49:26 2021 from 192.168.0.10
	

	```
	
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

	Ответ:
	```
	# echo "192.168.0.13 vagrant2" >> /etc/hosts

	# cat /etc/hosts
	127.0.0.1       localhost
	127.0.1.1       vagrant.vm      vagrant

	# The following lines are desirable for IPv6 capable hosts
	::1     localhost ip6-localhost ip6-loopback
	ff02::1 ip6-allnodes
	ff02::2 ip6-allrouters
	192.168.0.13 vagrant2


	$ ping vagrant2
	PING vagrant2 (192.168.0.13) 56(84) bytes of data.
	64 bytes from vagrant2 (192.168.0.13): icmp_seq=1 ttl=64 time=0.503 ms

	$ ssh-keygen
	Generating public/private rsa key pair.
	Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): /home/vagrant/.ssh/another_key
	Enter passphrase (empty for no passphrase):
	Enter same passphrase again:
	Your identification has been saved in /home/vagrant/.ssh/another_key
	Your public key has been saved in /home/vagrant/.ssh/another_key.pub
	The key fingerprint is:
	SHA256:V46oubhzBhmrQHb5CBdIqDsOM6Uxa2Uu2KtOh7S7qvI vagrant@vagrant
	The key's randomart image is:
	+---[RSA 3072]----+
	|o..              |
	|.. .             |
	|.   o       .    |
	|++.*.    . +     |
	|+XB o+  S o .    |
	|%o+o+. o .       |
	|+O.+ .o          |
	|o.= ..o.         |
	|O*E o=.          |
	+----[SHA256]-----+

	$ touch ~/.ssh/config

	$ cat >> ~/.ssh/config
	Host vagrant2
			HostName 192.168.0.13
			Port 22
			User vagrant
			IdentityFile /home/vagrant/.ssh/another_key

	$ cat .ssh/another_key.pub | ssh 192.168.0.13 'cat >> ~/.ssh/authorized_keys'
	vagrant@192.168.0.13's password:

	$ ssh vagrant2
	Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)

	 * Documentation:  https://help.ubuntu.com
	 * Management:     https://landscape.canonical.com
	 * Support:        https://ubuntu.com/advantage

	  System information as of Sun 19 Dec 2021 01:31:10 PM UTC

	  System load:  0.02              Processes:             110
	  Usage of /:   2.5% of 61.31GB   Users logged in:       1
	  Memory usage: 20%               IPv4 address for eth0: 10.0.2.15
	  Swap usage:   0%                IPv4 address for eth1: 192.168.0.13


	This system is built by the Bento project by Chef Software
	More information can be found at https://github.com/chef/bento
	Last login: Sun Dec 19 08:51:19 2021 from 192.168.0.10



	
	```
	
7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

	Ответ:
	```
	$ sudo tcpdump -w 0001.pcap -c 100 -i eth1
	tcpdump: listening on eth1, link-type EN10MB (Ethernet), capture size 262144 bytes
	100 packets captured
	103 packets received by filter
	0 packets dropped by kernel


  ![изображение](https://user-images.githubusercontent.com/93001155/146677982-d2f9b443-b8c8-479e-a29c-72cc166f7460.png)



	
	```
	

# Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"  03-sysadmin-06-net

1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
- отправьте HTTP запрос
```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
- В ответе укажите полученный HTTP код, что он означает?

	```
	Ответ:
	root@vagrant:~# telnet stackoverflow.com 80
	Trying 151.101.65.69...
	Connected to stackoverflow.com.
	Escape character is '^]'.
	GET /questions HTTP/1.0
	HOST: stackoverflow.com

	HTTP/1.1 301 Moved Permanently
	cache-control: no-cache, no-store, must-revalidate
	location: https://stackoverflow.com/questions
	x-request-guid: 95039cf6-7c48-4ced-9f18-5a0ebfa6ac73
	feature-policy: microphone 'none'; speaker 'none'
	content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
	Accept-Ranges: bytes
	Date: Sun, 05 Dec 2021 14:09:10 GMT
	Via: 1.1 varnish
	Connection: close
	X-Served-By: cache-fra19163-FRA
	X-Cache: MISS
	X-Cache-Hits: 0
	X-Timer: S1638713350.075517,VS0,VE92
	Vary: Fastly-SSL
	X-DNS-Prefetch-Control: off
	Set-Cookie: prov=4e519058-0500-3056-89db-26884980e693; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

	Connection closed by foreign host.
	
	
	HTTP/1.1 301 Moved Permanently - запрошенный документ был окончательно перенесен на новый URI, указанный в поле Location заголовка.

	
	```



2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку `Network`
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

	```
	Ответ:
	HTTP/1.1 301 Moved Permanently
	Загрузка страницы - 2,69
	Самая долгая обработка - 273мс

	![image] ( https://github.com/Nb3l77eo/devops-netology/blob/main/2021-12-06_01-11-54.png )
	```
  
  

3. Какой IP адрес у вас в интернете?

	```
	$ curl ifconfig.me
	$ wget -O - -q ifconfig.me/ip
	5.140.27.184
	
	```

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`

	```
	Ответ:
	$ whois 5.140.27.184
	...
	% Information related to '5.140.0.0/19AS12389'

	route:          5.140.0.0/19
	descr:          Rostelecom networks
	origin:         AS12389
	mnt-by:         ROSTELECOM-MNT

	...
	
	```

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`

	```
	Ответ:
	# traceroute -An 8.8.8.8
	traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
	 1  192.168.0.1 [*]  1.329 ms  1.256 ms  1.238 ms
	 2  217.20.87.167 [AS20485/AS12389]  37.382 ms  36.757 ms  36.704 ms
	 3  213.59.209.204 [AS12389]  5.200 ms  11.555 ms  10.261 ms
	 4  87.226.181.89 [AS12389]  52.103 ms  51.845 ms 87.226.183.89 [AS12389]  53.004 ms
	 5  5.143.253.105 [AS12389]  55.589 ms  55.582 ms  55.574 ms
	 6  108.170.250.130 [AS15169]  55.565 ms 108.170.250.99 [AS15169]  46.509 ms 108.170.250.34 [AS15169]  46.469 ms
	 7  142.251.49.158 [AS15169]  59.540 ms 142.251.49.24 [AS15169]  61.383 ms 209.85.255.136 [AS15169]  64.393 ms
	 8  72.14.238.168 [AS15169]  62.073 ms 209.85.254.20 [AS15169]  61.302 ms 172.253.65.82 [AS15169]  69.209 ms
	 9  216.239.58.53 [AS15169]  67.869 ms 142.250.210.45 [AS15169]  72.859 ms 142.250.210.47 [AS15169]  73.794 ms
	10  * * *
	11  * * *
	12  * * *
	13  * * *
	14  * * *
	15  * * *
	16  * 8.8.8.8 [AS15169]  64.905 ms *
	
	Перечень автономных сетей: AS12389, AS15169
	
	
	
	# whois -h whois.radb.net AS12389|grep as-name
	as-name:        ROSTELECOM-AS
	# whois -h whois.radb.net AS15169 | grep as-name
	as-name:    Google

	
	```

6. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?

	```
	Ответ:
	![image] ( https://github.com/Nb3l77eo/devops-netology/blob/main/2021-12-06_01-59-29.png )
	
	```

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`

	```
	Ответ:
	# dig NS dns.google +noall +answer
	dns.google.             19775   IN      NS      ns4.zdns.google.
	dns.google.             19775   IN      NS      ns1.zdns.google.
	dns.google.             19775   IN      NS      ns3.zdns.google.
	dns.google.             19775   IN      NS      ns2.zdns.google.
	
	# dig A dns.google +noall +answer
	dns.google.             179     IN      A       8.8.8.8
	dns.google.             179     IN      A       8.8.4.4
	
	
	
	```

8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`

	```
	Ответ:
	# dig -x 8.8.8.8 +noall +answer
	8.8.8.8.in-addr.arpa.   7185    IN      PTR     dns.google.
	
	# dig -x 8.8.4.4 +noall +answer
	4.4.8.8.in-addr.arpa.   20536   IN      PTR     dns.google.
	
	
	```

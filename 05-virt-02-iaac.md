05-virt-02-iaac.md

# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
- Какой из принципов IaaC является основополагающим?

Ответ:
```
- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
1. Автоматизация - значительное ускорение процесса процесса подготовки инфраструктуры и как следствие снижение возможности совершения ошибки при ручном конфигурировании каждого объекта инфраструктуры.
2. Стабильность среды - минизация возможности непреднамеренного создания (или в случае изменении конфигурации) разнородной инфраструктуры. Однородность внесения изменений обеспечивает понимание состояния конфигурации в любой момент времени. 
3. Положительное влияние на процесс разработки. Оперативное изменение/создание инфраструктуры с определенной конфигурацией для нужд тестирования/продуктивной среды/возврату к предыдущей версии.


- Какой из принципов IaaC является основополагающим?
Получение одного и того же результата при выполнении операции - идемпотентность. Т.е. описанная нами конфигурация инфраструктуры будет одинакова при каждом повторном ее создании. 
```

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Ответ:
```
- Чем Ansible выгодно отличается от других систем управление конфигурациями?

1. Простая установка и первоначальная настройка
2. Легкий синтаксис, как следствие низкий порог входа
3. Отсутствие агентов
4. Отсутствие мастер сервера
5. Доступ по SSH


- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

В каждой конкретной реализации инфраструктуры необходимо использовать более подходящий метод. Если инфраструктура сложна, то имеет смысл использовать гибридную модель, но для ее реализации потребуется много времени.

Для использования push мы должны знать все о необходимой инфраструктуре, поэтому с точки зрения автоматизации использование pull более обосновано в сложных инфраструктурах.

```

## Задача 3

Установить на личный компьютер:

- VirtualBox
- Vagrant
- Ansible

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

Ответ:
```
# apt install virtualbox
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required:
  augeas-lenses cpu-checker db-util db5.3-util debootstrap extlinux fonts-droid-fallback fonts-lato fonts-noto-mono fonts-urw-base35 ghostscript gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-x hfsplus
  ibverbs-providers icoutils ieee-data ipxe-qemu ipxe-qemu-256k-compat-efi-roms javascript-common ldmtool libaa1 libafflib0v5 libarchive-tools libaugeas0 libauthen-sasl-perl libavc1394-0 libboost-iostreams1.71.0 libboost-thread1.71.0
  libbrlapi0.7 libcacard0 libcdparanoia0 libconfig9 libdata-dump-perl libdate-manip-perl libdv4 libencode-locale-perl libewf2 libfdt1 libfile-listing-perl libfont-afm-perl libgs9 libgs9-common libgstreamer-plugins-base1.0-0
  libgstreamer-plugins-good1.0-0 libguestfs-hfsplus libguestfs-perl libguestfs-reiserfs libguestfs-tools libguestfs-xfs libguestfs0 libhfsp0 libhivex0 libhtml-form-perl libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl
  libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl libhttp-message-perl libhttp-negotiate-perl libibverbs1 libidn11 libiec61883-0 libijs-0.35 libintl-perl libintl-xs-perl libio-html-perl
  libio-socket-ssl-perl libiscsi7 libjack-jackd2-0 libjansson4 libjbig2dec0 libjs-jquery libldm-1.0-0 liblwp-mediatypes-perl liblwp-protocol-https-perl libmailtools-perl libmp3lame0 libmpg123-0 libnet-http-perl libnet-smtp-ssl-perl
  libnet-ssleay-perl libnetpbm10 libnl-route-3-200 libopenjp2-7 liborc-0.4-0 libpaper-utils libpaper1 libpcsclite1 libpmem1 librados2 libraw1394-11 librbd1 librdmacm1 libruby2.7 libsamplerate0 libshout3 libslirp0 libspeex1
  libspice-server1 libstring-shellquote-perl libsys-virt-perl libtag1v5 libtag1v5-vanilla libtheora0 libtimedate-perl libtry-tiny-perl libtsk13 libtwolame0 liburi-perl libusbredirparser1 libv4l-0 libv4lconvert0 libvirglrenderer1
  libvirt0 libvisual-0.4-0 libvte-2.91-0 libvte-2.91-common libwavpack1 libwin-hivex-perl libwww-perl libwww-robotrules-perl libxml-parser-perl libxml-xpath-perl libxv1 libyajl2 libyara3 lsscsi lzop msr-tools mtools netpbm
  nfs-kernel-server osinfo-db ovmf perl-openssl-defaults poppler-data python3-argcomplete python3-dnspython python3-jmespath python3-kerberos python3-libcloud python3-lockfile python3-netaddr python3-ntlm-auth python3-requests-kerberos
  python3-requests-ntlm python3-selinux python3-winrm python3-xmltodict qemu-block-extra qemu-system-common qemu-system-data qemu-system-gui qemu-system-x86 qemu-utils rake ruby ruby-bcrypt-pbkdf ruby-builder ruby-childprocess
  ruby-concurrent ruby-domain-name ruby-ed25519 ruby-erubis ruby-excon ruby-ffi ruby-fog-core ruby-fog-json ruby-fog-libvirt ruby-fog-xml ruby-formatador ruby-http-cookie ruby-i18n ruby-libvirt ruby-listen ruby-log4r ruby-mime-types
  ruby-mime-types-data ruby-minitest ruby-multi-json ruby-net-scp ruby-net-sftp ruby-net-ssh ruby-net-telnet ruby-netrc ruby-nokogiri ruby-oj ruby-pkg-config ruby-power-assert ruby-rb-inotify ruby-rest-client ruby-sqlite3
  ruby-test-unit ruby-unf ruby-unf-ext ruby-vagrant-cloud ruby-xmlrpc ruby-zip ruby2.7 rubygems-integration scrub seabios sharutils sleuthkit sqlite3 supermin syslinux syslinux-common
Use 'apt autoremove' to remove them.
The following additional packages will be installed:
  virtualbox-qt
Suggested packages:
  vde2 virtualbox-guest-additions-iso
The following NEW packages will be installed:
  virtualbox virtualbox-qt
0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
Need to get 43.2 MB of archives.
After this operation, 172 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://ru.archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 virtualbox amd64 6.1.26-dfsg-3~ubuntu1.20.04.2 [21.5 MB]
Get:2 http://ru.archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 virtualbox-qt amd64 6.1.26-dfsg-3~ubuntu1.20.04.2 [21.7 MB]
Fetched 43.2 MB in 22s (1,934 kB/s)
Selecting previously unselected package virtualbox.
(Reading database ... 107680 files and directories currently installed.)
Preparing to unpack .../virtualbox_6.1.26-dfsg-3~ubuntu1.20.04.2_amd64.deb ...
Unpacking virtualbox (6.1.26-dfsg-3~ubuntu1.20.04.2) ...
Selecting previously unselected package virtualbox-qt.
Preparing to unpack .../virtualbox-qt_6.1.26-dfsg-3~ubuntu1.20.04.2_amd64.deb ...
Unpacking virtualbox-qt (6.1.26-dfsg-3~ubuntu1.20.04.2) ...
Setting up virtualbox (6.1.26-dfsg-3~ubuntu1.20.04.2) ...
Setting up virtualbox-qt (6.1.26-dfsg-3~ubuntu1.20.04.2) ...
Processing triggers for mime-support (3.64ubuntu1) ...
Processing triggers for hicolor-icon-theme (0.17-2) ...
Processing triggers for systemd (245.4-4ubuntu3.15) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for shared-mime-info (1.15-1) ...

# apt install vagrant
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required:
  ieee-data python3-argcomplete python3-dnspython python3-jmespath python3-kerberos python3-libcloud python3-lockfile python3-netaddr python3-ntlm-auth python3-requests-kerberos python3-requests-ntlm python3-selinux python3-winrm
  python3-xmltodict
Use 'apt autoremove' to remove them.
The following additional packages will be installed:
  vagrant-libvirt
The following NEW packages will be installed:
  vagrant vagrant-libvirt
0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
Need to get 493 kB of archives.
After this operation, 3,471 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://ru.archive.ubuntu.com/ubuntu focal-updates/universe amd64 vagrant all 2.2.6+dfsg-2ubuntu3 [425 kB]
Get:2 http://ru.archive.ubuntu.com/ubuntu focal/universe amd64 vagrant-libvirt all 0.0.45-2 [67.4 kB]
Fetched 493 kB in 1s (911 kB/s)
Selecting previously unselected package vagrant.
(Reading database ... 108045 files and directories currently installed.)
Preparing to unpack .../vagrant_2.2.6+dfsg-2ubuntu3_all.deb ...
Unpacking vagrant (2.2.6+dfsg-2ubuntu3) ...
Selecting previously unselected package vagrant-libvirt.
Preparing to unpack .../vagrant-libvirt_0.0.45-2_all.deb ...
Unpacking vagrant-libvirt (0.0.45-2) ...
Setting up vagrant (2.2.6+dfsg-2ubuntu3) ...
Setting up vagrant-libvirt (0.0.45-2) ...
Processing triggers for man-db (2.9.1-1) ...

# apt install ansible
Reading package lists... Done
Building dependency tree
Reading state information... Done
Suggested packages:
  cowsay sshpass
The following NEW packages will be installed:
  ansible
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 5,794 kB of archives.
After this operation, 58.0 MB of additional disk space will be used.
Get:1 http://ru.archive.ubuntu.com/ubuntu focal/universe amd64 ansible all 2.9.6+dfsg-1 [5,794 kB]
Fetched 5,794 kB in 2s (3,687 kB/s)
Selecting previously unselected package ansible.
(Reading database ... 109370 files and directories currently installed.)
Preparing to unpack .../ansible_2.9.6+dfsg-1_all.deb ...
Unpacking ansible (2.9.6+dfsg-1) ...
Setting up ansible (2.9.6+dfsg-1) ...
Processing triggers for man-db (2.9.1-1) ...

# vboxmanage --version
6.1.26_Ubuntur145957

# vagrant --version
Vagrant 2.2.6

# ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]





# vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Box 'bento/ubuntu-20.04' could not be found. Attempting to find and install...
    server1.netology: Box Provider: virtualbox
    server1.netology: Box Version: >= 0
==> server1.netology: Loading metadata for box 'bento/ubuntu-20.04'
    server1.netology: URL: https://vagrantcloud.com/bento/ubuntu-20.04
==> server1.netology: Adding box 'bento/ubuntu-20.04' (v202112.19.0) for provider: virtualbox
    server1.netology: Downloading: https://vagrantcloud.com/bento/boxes/ubuntu-20.04/versions/202112.19.0/providers/virtualbox.box
    server1.netology: Download redirected to host: vagrantcloud-files-production.s3-accelerate.amazonaws.com
==> server1.netology: Successfully added box 'bento/ubuntu-20.04' (v202112.19.0) for 'virtualbox'!
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202112.19.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
Vagrant is currently configured to create VirtualBox synced folders with
the `SharedFoldersEnableSymlinksCreate` option enabled. If the Vagrant
guest is not trusted, you may want to disable this option. For more
information on this option, please refer to the VirtualBox manual:

  https://www.virtualbox.org/manual/ch04.html#sharedfolders

This option can be disabled globally with an environment variable:

  VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

or on a per folder basis within the Vagrantfile:

  config.vm.synced_folder '/host/path', '/guest/path', SharedFoldersEnableSymlinksCreate: false
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: Warning: Remote connection disconnect. Retrying...
    server1.netology:
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology:
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /opt/VMs/vm1/vagrant
==> server1.netology: Running provisioner: ansible...
Vagrant has automatically selected the compatibility mode '2.0'
according to the Ansible version installed (2.9.6).

Alternatively, the compatibility mode can be specified in your Vagrantfile:
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=['git', 'curl'])

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0




```


## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```

# Домашнее задание к занятию "3.5. Файловые системы" devsys10/03-sysadmin-05-fs

1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

	```
	Ответ:
	Разрежённый файл - файл, в котором последовательности нулевых байтов заменены на информацию об этих последовательностях (список дыр).
	
	Принцип понятен. Какова вероятность присутствия блоков с нулями в фалах с реальными данными? Не могу определить сферу применения.
	
	```


1. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

	```
	Ответ:
	Нет для жестких ссылок невозможно настроить разные права и владельцев, т.к. у них одна inode которая и хранит эти данные.
	
	```


1. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```bash
    Vagrant.configure("2") do |config|
      config.vm.box = "bento/ubuntu-20.04"
      config.vm.provider :virtualbox do |vb|
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
      end
    end
    ```

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.
	
	```
	Ответ:
	D:\HashiCorp\Vagrant\bin2>vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Importing base box 'bento/ubuntu-20.04'...
	==> default: Matching MAC address for NAT networking...
	==> default: Checking if box 'bento/ubuntu-20.04' version '202107.28.0' is up to date...
	==> default: Setting the name of the VM: bin2_default_1638209349506_96204
	==> default: Clearing any previously set network interfaces...
	==> default: Preparing network interfaces based on configuration...
		default: Adapter 1: nat
		default: Adapter 2: bridged
	==> default: Forwarding ports...
		default: 22 (guest) => 2222 (host) (adapter 1)
	==> default: Running 'pre-boot' VM customizations...
	==> default: Booting VM...
	==> default: Waiting for machine to boot. This may take a few minutes...
		default: SSH address: 127.0.0.1:2222
		default: SSH username: vagrant
		default: SSH auth method: private key
		default: Warning: Connection aborted. Retrying...
		default:
		default: Vagrant insecure key detected. Vagrant will automatically replace
		default: this with a newly generated keypair for better security.
		default:
		default: Inserting generated public key within guest...
		default: Removing insecure key from the guest if it's present...
		default: Key inserted! Disconnecting and reconnecting using new SSH key...
	==> default: Machine booted and ready!
	==> default: Checking for guest additions in VM...
	==> default: Configuring and enabling network interfaces...
	==> default: Mounting shared folders...
		default: /vagrant => D:/HashiCorp/Vagrant/bin2
		
	vagrant@vagrant:~# lsblk
	NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
	sda                    8:0    0   64G  0 disk
	├─sda1                 8:1    0  512M  0 part /boot/efi
	├─sda2                 8:2    0    1K  0 part
	└─sda5                 8:5    0 63.5G  0 part
	  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
	  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
	sdb                    8:16   0  2.5G  0 disk
	sdc                    8:32   0  2.5G  0 disk
	```
	

1. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

	```
	Ответ:
	# fdisk /dev/sdb
	Command (m for help): n
	Partition type
		p   primary (0 primary, 0 extended, 4 free)
		e   extended (container for logical partitions)
	Select (default p): p
	Partition number (1-4, default 1): 1
	Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G
	Created a new partition 1 of type 'Linux' and of size 2 GiB.
	
	Command (m for help): n
	Partition type
	   p   primary (1 primary, 0 extended, 3 free)
	   e   extended (container for logical partitions)
	Select (default p): p
	Partition number (2-4, default 2): 2
	First sector (4196352-5242879, default 4196352):
	Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):5242879
	Created a new partition 2 of type 'Linux' and of size 511 MiB.

	Command (m for help): p
	Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
	Disk model: VBOX HARDDISK
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0x87ad3763

	Device     Boot   Start     End Sectors  Size Id Type
	/dev/sdb1          2048 4196351 4194304    2G 83 Linux
	/dev/sdb2       4196352 5242879 1046528  511M 83 Linux

	Command (m for help): w
	The partition table has been altered.
	Calling ioctl() to re-read partition table.
	Syncing disks.	
	```

1. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.

	```
	Ответ:
	# sfdisk -d /dev/sdb | sfdisk /dev/sdc
	Checking that no-one is using this disk right now ... OK

	Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
	Disk model: VBOX HARDDISK
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes

	>>> Script header accepted.
	>>> Script header accepted.
	>>> Script header accepted.
	>>> Script header accepted.
	>>> Created a new DOS disklabel with disk identifier 0x87ad3763.
	/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
	/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
	/dev/sdc3: Done.

	New situation:
	Disklabel type: dos
	Disk identifier: 0x87ad3763

	Device     Boot   Start     End Sectors  Size Id Type
	/dev/sdc1          2048 4196351 4194304    2G 83 Linux
	/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

	The partition table has been altered.
	Calling ioctl() to re-read partition table.
	Syncing disks.

	# lsblk
	NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
	sda                    8:0    0   64G  0 disk
	├─sda1                 8:1    0  512M  0 part /boot/efi
	├─sda2                 8:2    0    1K  0 part
	└─sda5                 8:5    0 63.5G  0 part
	  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
	  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
	sdb                    8:16   0  2.5G  0 disk
	├─sdb1                 8:17   0    2G  0 part
	└─sdb2                 8:18   0  511M  0 part
	sdc                    8:32   0  2.5G  0 disk
	├─sdc1                 8:33   0    2G  0 part
	└─sdc2                 8:34   0  511M  0 part
	```

1. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

	```
	Ответ:
	# mdadm --create --verbose /dev/md1 -l 1 -n 2 /dev/sd{b1,c1}
	mdadm: Note: this array has metadata at the start and
		may not be suitable as a boot device.  If you plan to
		store '/boot' on this device please ensure that
		your boot-loader understands md/v1.x metadata, or use
		--metadata=0.90
	mdadm: size set to 2094080K
	Continue creating array? y
	mdadm: Defaulting to version 1.2 metadata
	mdadm: array /dev/md1 started.

	```

1. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

	```
	Ответ:
	# mdadm --create --verbose /dev/md0 -l 0 -n 2 /dev/sd{b2,c2}
	mdadm: chunk size defaults to 512K
	mdadm: Defaulting to version 1.2 metadata
	mdadm: array /dev/md0 started.
	
	```

1. Создайте 2 независимых PV на получившихся md-устройствах.

	```
	Ответ:
	# pvcreate /dev/md0
	Physical volume "/dev/md0" successfully created.
	# pvcreate /dev/md1
	Physical volume "/dev/md1" successfully created.
	
	# pvscan
	  PV /dev/sda5   VG vgvagrant       lvm2 [<63.50 GiB / 0    free]
	  PV /dev/md0                       lvm2 [1018.00 MiB]
	  PV /dev/md1                       lvm2 [<2.00 GiB]
	  Total: 3 [<66.49 GiB] / in use: 1 [<63.50 GiB] / in no VG: 2 [2.99 GiB]
	  
	# pvdisplay
	  --- Physical volume ---
	  PV Name               /dev/sda5
	  VG Name               vgvagrant
	  PV Size               <63.50 GiB / not usable 0
	  Allocatable           yes (but full)
	  PE Size               4.00 MiB
	  Total PE              16255
	  Free PE               0
	  Allocated PE          16255
	  PV UUID               Mx3LcA-uMnN-h9yB-gC2w-qm7w-skx0-OsTz9z

	  "/dev/md0" is a new physical volume of "1018.00 MiB"
	  --- NEW Physical volume ---
	  PV Name               /dev/md0
	  VG Name
	  PV Size               1018.00 MiB
	  Allocatable           NO
	  PE Size               0
	  Total PE              0
	  Free PE               0
	  Allocated PE          0
	  PV UUID               TdLf6K-dwuV-ZN2N-HQef-9G5k-3Ile-1JVkdw

	  "/dev/md1" is a new physical volume of "<2.00 GiB"
	  --- NEW Physical volume ---
	  PV Name               /dev/md1
	  VG Name
	  PV Size               <2.00 GiB
	  Allocatable           NO
	  PE Size               0
	  Total PE              0
	  Free PE               0
	  Allocated PE          0
	  PV UUID               AB8Wj5-cNu1-zoEP-765h-JKl0-LbLs-6uWdIk

	
	```

1. Создайте общую volume-group на этих двух PV.

	```
	Ответ:
	# vgcreate raid_vol_gr1 /dev/md0 /dev/md1
	  Volume group "raid_vol_gr1" successfully created
	# vgscan
	  Found volume group "vgvagrant" using metadata type lvm2
	  Found volume group "raid_vol_gr1" using metadata type lvm2
	# vgdisplay
	  --- Volume group ---
	  VG Name               vgvagrant
	  System ID
	  Format                lvm2
	  Metadata Areas        1
	  Metadata Sequence No  3
	  VG Access             read/write
	  VG Status             resizable
	  MAX LV                0
	  Cur LV                2
	  Open LV               2
	  Max PV                0
	  Cur PV                1
	  Act PV                1
	  VG Size               <63.50 GiB
	  PE Size               4.00 MiB
	  Total PE              16255
	  Alloc PE / Size       16255 / <63.50 GiB
	  Free  PE / Size       0 / 0
	  VG UUID               PaBfZ0-3I0c-iIdl-uXKt-JL4K-f4tT-kzfcyE

	  --- Volume group ---
	  VG Name               raid_vol_gr1
	  System ID
	  Format                lvm2
	  Metadata Areas        2
	  Metadata Sequence No  1
	  VG Access             read/write
	  VG Status             resizable
	  MAX LV                0
	  Cur LV                0
	  Open LV               0
	  Max PV                0
	  Cur PV                2
	  Act PV                2
	  VG Size               <2.99 GiB
	  PE Size               4.00 MiB
	  Total PE              765
	  Alloc PE / Size       0 / 0
	  Free  PE / Size       765 / <2.99 GiB
	  VG UUID               U4b471-e0I5-AJJ2-lNEA-ecG2-xWZX-dimjWd

	
	```

1. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

	```
	Ответ:
	# lvcreate -L 100M -n lv_100M_raid0 raid_vol_gr1 /dev/md0
	Logical volume "lv_100M_raid0" created.
	
	# lvdisplay /dev/raid_vol_gr1/lv_100M_raid0
	  --- Logical volume ---
	  LV Path                /dev/raid_vol_gr1/lv_100M_raid0
	  LV Name                lv_100M_raid0
	  VG Name                raid_vol_gr1
	  LV UUID                0Jrq1O-AyoW-0mfE-CdM3-ZLw7-c1YX-GZTE0E
	  LV Write Access        read/write
	  LV Creation host, time vagrant, 2021-11-30 09:26:44 +0000
	  LV Status              available
	  # open                 0
	  LV Size                100.00 MiB
	  Current LE             25
	  Segments               1
	  Allocation             inherit
	  Read ahead sectors     auto
	  - currently set to     4096
	  Block device           253:2

	
	```

1. Создайте `mkfs.ext4` ФС на получившемся LV.

	```
	Ответ:
	# mkfs.ext4 /dev/raid_vol_gr1/lv_100M_raid0
	mke2fs 1.45.5 (07-Jan-2020)
	Creating filesystem with 25600 4k blocks and 25600 inodes

	Allocating group tables: done
	Writing inode tables: done
	Creating journal (1024 blocks): done
	Writing superblocks and filesystem accounting information: done
	
	```

1. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

	```
	Ответ:
	# mkdir /tmp/new
	# mount /dev/raid_vol_gr1/lv_100M_raid0 /tmp/new/ -w
	
	# df -h
	Filesystem                              Size  Used Avail Use% Mounted on
	udev                                    447M     0  447M   0% /dev
	tmpfs                                    99M  704K   98M   1% /run
	/dev/mapper/vgvagrant-root               62G  1.6G   57G   3% /
	tmpfs                                   491M     0  491M   0% /dev/shm
	tmpfs                                   5.0M     0  5.0M   0% /run/lock
	tmpfs                                   491M     0  491M   0% /sys/fs/cgroup
	/dev/sda1                               511M  4.0K  511M   1% /boot/efi
	vagrant                                 466G  426G   41G  92% /vagrant
	tmpfs                                    99M     0   99M   0% /run/user/1000
	/dev/mapper/raid_vol_gr1-lv_100M_raid0   93M   72K   86M   1% /tmp/new
	
	```

1. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

	```
	Ответ:
	# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
	--2021-11-30 09:45:06--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
	Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
	Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
	HTTP request sent, awaiting response... 200 OK
	Length: 22574425 (22M) [application/octet-stream]
	Saving to: ‘/tmp/new/test.gz’

	/tmp/new/test.gz              100%[==============================================>]  21.53M  1.36MB/s    in 8.1s

	2021-11-30 09:45:15 (2.66 MB/s) - ‘/tmp/new/test.gz’ saved [22574425/22574425]

	
	```

1. Прикрепите вывод `lsblk`.

	```
	Ответ:
	# lsblk
	NAME                             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
	sda                                8:0    0   64G  0 disk
	├─sda1                             8:1    0  512M  0 part  /boot/efi
	├─sda2                             8:2    0    1K  0 part
	└─sda5                             8:5    0 63.5G  0 part
	  ├─vgvagrant-root               253:0    0 62.6G  0 lvm   /
	  └─vgvagrant-swap_1             253:1    0  980M  0 lvm   [SWAP]
	sdb                                8:16   0  2.5G  0 disk
	├─sdb1                             8:17   0    2G  0 part
	│ └─md1                            9:1    0    2G  0 raid1
	└─sdb2                             8:18   0  511M  0 part
	  └─md0                            9:0    0 1018M  0 raid0
		└─raid_vol_gr1-lv_100M_raid0 253:2    0  100M  0 lvm   /tmp/new
	sdc                                8:32   0  2.5G  0 disk
	├─sdc1                             8:33   0    2G  0 part
	│ └─md1                            9:1    0    2G  0 raid1
	└─sdc2                             8:34   0  511M  0 part
	  └─md0                            9:0    0 1018M  0 raid0
		└─raid_vol_gr1-lv_100M_raid0 253:2    0  100M  0 lvm   /tmp/new
	
	```

1. Протестируйте целостность файла:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```
	
	```
	Ответ:
	# gzip -t /tmp/new/test.gz
	# echo $?
	0	
	```
	

1. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

	```
	Ответ:
	# pvmove /dev/md0 /dev/md1
	  /dev/md0: Moved: 20.00%
	  /dev/md0: Moved: 100.00%
	# lsblk
	NAME                             MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
	sda                                8:0    0   64G  0 disk
	├─sda1                             8:1    0  512M  0 part  /boot/efi
	├─sda2                             8:2    0    1K  0 part
	└─sda5                             8:5    0 63.5G  0 part
	  ├─vgvagrant-root               253:0    0 62.6G  0 lvm   /
	  └─vgvagrant-swap_1             253:1    0  980M  0 lvm   [SWAP]
	sdb                                8:16   0  2.5G  0 disk
	├─sdb1                             8:17   0    2G  0 part
	│ └─md1                            9:1    0    2G  0 raid1
	│   └─raid_vol_gr1-lv_100M_raid0 253:2    0  100M  0 lvm   /tmp/new
	└─sdb2                             8:18   0  511M  0 part
	  └─md0                            9:0    0 1018M  0 raid0
	sdc                                8:32   0  2.5G  0 disk
	├─sdc1                             8:33   0    2G  0 part
	│ └─md1                            9:1    0    2G  0 raid1
	│   └─raid_vol_gr1-lv_100M_raid0 253:2    0  100M  0 lvm   /tmp/new
	└─sdc2                             8:34   0  511M  0 part
	  └─md0                            9:0    0 1018M  0 raid0

	
	```

1. Сделайте `--fail` на устройство в вашем RAID1 md.

	```
	Ответ:
	# mdadm /dev/md1 --fail /dev/sdc1
	mdadm: set /dev/sdc1 faulty in /dev/md1
	```

1. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.


	```
	Ответ:
	# dmesg
	[22297.775508] md/raid1:md1: Disk failure on sdc1, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.
	```

1. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

	```
	Ответ:
	# gzip -t /tmp/new/test.gz
	# echo $?
	0
	```

1. Погасите тестовый хост, `vagrant destroy`.

	```
	Ответ:
	E:\HashiCorp\Vagrant\bin2>vagrant destroy
		default: Are you sure you want to destroy the 'default' VM? [y/N] y
	==> default: Forcing shutdown of VM...
	==> default: Destroying VM and associated drives...
	```

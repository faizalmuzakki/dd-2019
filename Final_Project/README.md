# Final Project Distributed Database 2019
> 5116100120 - Faizal Khilmi Muzakki

### Instruksi
Dimohon untuk menyiapkan dokumentasi di GitHub yang berisi:
1. [Arsitektur BDT Relasional](#arsitektur-bdt-relasional)
2. [Arsitektur BDT Non Relasional](#arsitektur-bdt-non-relasional)
3. [Deskripsi aplikasi](#deskripsi-aplikasi)

### Arsitektur BDT Relasional
![relational](img/relational.png)

IP|Hostname|Role
--|--|--
192.168.33.11|manager|NDB Manager, Service Node
192.168.33.12|clusterdb1|Service Node, Data Node
192.168.33.13|clusterdb2|Data Node
192.168.33.14|proxysql|ProxySQL

Dokumentasi instalasi mysql cluster: [Link](../ETS)

### Arsitektur BDT Non Relasional
![non-relational](img/non-relational.png)

IP|Hostname|Role
--|--|--
192.168.33.14|proxysql|Initial Redis Master
192.168.33.15|redis1|Initial Redis Slave
192.168.33.16|redis2|Initial Redis Slave

Dokumentasi instalasi Redis: [Link](../Redis)

### Deskripsi aplikasi
https://github.com/faizalmuzakki/laravel-blog forked from https://github.com/milon/laravel-blog
> A simple blog for demonstration purpose with Laravel Framework.

- Blog simple berbasis laravel dengan menggunakan MySQL Cluster sebagai RDBMS dan Redis Cluster sebagai sistem _caching_
(_session_)

### Referensi
- https://medium.com/@amila922/redis-sentinel-high-availability-everything-you-need-to-know-from-dev-to-prod-complete-guide-deb198e70ea6
- https://www.digitalocean.com/community/tutorials/how-to-create-a-multi-node-mysql-cluster-on-ubuntu-18-04
- https://www.digitalocean.com/community/tutorials/how-to-use-proxysql-as-a-load-balancer-for-mysql-on-ubuntu-16-04#step-8-%E2%80%94-verifying-the-proxysql-configuration
- https://laracasts.com/discuss/channels/laravel/redis-sentinel-in-laravel-nodesetname-back-off-strategym-mastersetc-config

# Distributed Database - 2019
## 0511164000120 - Faizal Khilmi Muzakki

## Jump To
1. [Tugas 1](#tugas-1---implementasi-mysql-cluster)
2. [Tugas 2](#tugas-2---implementasi-partisi)

## Tugas 1 - Implementasi MySQL Cluster

###### Database: http://www.mysqltutorial.org/mysql-sample-database.aspx

#### Artitektur
IP|Hostname|Task
--|--------|----
192.168.33.11|clusterdb1|Manager, servicenode
192.168.33.12|clusterdb2|Datanode, servicenode
192.168.33.13|clusterdb3|Datanode
192.168.33.14|proxysql|ProxySQL

#### Manager
![Manager](ss/manager.PNG)

#### Testing NDBCluster
1. Pastikan status ndbd di datanode adalah running dan tabel menggunakan engine `ndbcluster`
2. Di clusterdb2 (salah satu datanode) run command `systectl stop ndbd`
3. Status node manager:

![image](ss/manager2.png)

4. Hasil akses melalui servicenode:

![image](ss/servicenode-access.PNG)

Sukses, telah dialihkan ke datanode ke-2

#### ProxySQL
![ProxySQL](ss/proxysql.PNG)

#### Test akses dari HeidiSQL
![HeidiSQL](ss/heidisql.PNG)

## Tugas 2 - Implementasi Partisi

#### Mengecek apakah plugin partition telah aktif (command dan screenshot hasil)

![HeidiSQL](ss/plugins.PNG)

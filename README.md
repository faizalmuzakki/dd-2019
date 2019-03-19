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

#### 1. Mengecek apakah plugin partition telah aktif (command dan screenshot hasil)

![HeidiSQL](ss/plugins.PNG)

#### 2. Create partition --> buat tabel dan contoh insert data dan hasil query-nya
##### Range partition
- contoh tabel "userslogs" dan "rc1"

    `CREATE TABLE userslogs (username VARCHAR(20) NOT NULL,logdata BLOB NOT NULL,created DATETIME NOT NULL,PRIMARY KEY(username, created))PARTITION BY RANGE( YEAR(created) )(PARTITION from_2013_or_less VALUES LESS THAN (2014),PARTITION from_2014 VALUES LESS THAN (2015),PARTITION from_2015 VALUES LESS THAN (2016),PARTITION from_2016_and_up VALUES LESS THAN MAXVALUE);`

    ![userslogs](ss/range_col_userslogs.PNG)

    `CREATE TABLE rc1 (a INT,b INT)PARTITION BY RANGE COLUMNS(a, b) (PARTITION p0 VALUES LESS THAN (5, 12),PARTITION p3 VALUES LESS THAN (MAXVALUE, MAXVALUE));`

    ![rc1](ss/rc1.PNG)

- Jalankan contoh query untuk tabel "rc1"

    `INSERT INTO rc1 (a,b) VALUES (4,11);INSERT INTO rc1 (a,b) VALUES (5,11);INSERT INTO rc1 (a,b) VALUES (6,11);INSERT INTO rc1 (a,b) VALUES (4,12);INSERT INTO rc1 (a,b) VALUES (5,12);INSERT INTO rc1 (a,b) VALUES (6,12);INSERT INTO rc1 (a,b) VALUES (4,13);INSERT INTO rc1 (a,b) VALUES (5,13);INSERT INTO rc1 (a,b) VALUES (6,13);`

    ![insert_range](ss/insert_range.PNG)

    `SELECT *,'p0' FROM rc1 PARTITION (p0) UNION ALL SELECT *,'p3' FROM rc1 PARTITION (p3) ORDER BY a,b ASC;`

    ![select_range](ss/select_range.PNG)

##### List Partition
  - contoh tabel "serverlogs" dan "lc"

    `CREATE TABLE serverlogs (serverid INT NOT NULL,logdata BLOB NOT NULL,created DATETIME NOT NULL)PARTITION BY LIST (serverid)(PARTITION server_east VALUES IN(1,43,65,12,56,73),PARTITION server_west VALUES IN(534,6422,196,956,22));`

    ![list_serverlogs](ss/list_serverlogs.PNG)

    `CREATE TABLE lc (a INT NULL,b INT NULL)PARTITION BY LIST COLUMNS(a,b) (PARTITION p0 VALUES IN( (0,0), (NULL,NULL) ),PARTITION p1 VALUES IN( (0,1), (0,2), (0,3), (1,1), (1,2) ),PARTITION p2 VALUES IN( (1,0), (2,0), (2,1), (3,0), (3,1) ),PARTITION p3 VALUES IN( (1,3), (2,2), (2,3), (3,2), (3,3) ));`

    ![lc](ss/lc.PNG)

  -  Jalankan contoh query untuk tabel "lc"

  `INSERT INTO lc (a,b) VALUES (0,0), (NULL,NULL), (0,1), (0,2), (0,3), (1,1), (1,2), (1,0), (2,0), (2,1), (3,0), (3,1), (1,3), (2,2), (2,3), (3,2), (3,3);`

    ![insert_lc](ss/insert_lc.PNG)

  `SELECT *,'p0' FROM lc PARTITION (p0) UNION ALL SELECT *,'p1' FROM lc PARTITION (p1) UNION ALL SELECT *,'p2' FROM lc PARTITION (p2) UNION ALL SELECT *,'p3' FROM lc PARTITION (p3) ORDER BY a,b ASC;`

    ![select_list](ss/select_list.PNG)

##### Hash Partition
##### Key Partition

#### 3. Testing pada bagian "A Typical Use Case: Time Series Data"
##### Menguji SELECT
##### Gunakan perintah EXPLAIN untuk melihat plan eksekusi query untuk masing-masing tabel
##### Jalankan query benchmark untuk masing-masing tabel. Hasilnya adalah running time.
##### Jalankan query delete (bagian BIG DELETE) dan tampilkan perbedaan running time-nya.

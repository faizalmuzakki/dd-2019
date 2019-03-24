# Tugas ETS

## Jump To
- [Instruksi](#instruksi)
- [Pengumpulan](#pengumpulan)
- [Arsitektur](#arsitektur)
- [Install Wordpress](#install-wordpress)
- [Konfigurasi Wordpress](#konfigurasi-wordpress)

### INSTRUKSI
1. Buatlah sebuah cluster MySQL menggunakan NDB Engine + 1 buah ProxySQL
2. Install aplikasi yang siap digunakan (seperti Wordpress, Joomla, atau CMS yang lain).
- Aplikasi dapat diinstal di node yang sama dengan ProxySQL, atau bisa juga menambahkan 1 node baru.
- Jangan lupa untuk mengubah SQL create table untuk menggunakan NDB Engine
3. Lakukan simulasi yang menunjukkan adanya fail over (salah satu node service atau data dimatikan) dan aplikasi masih dapat berfungsi dengan baik.
4. Lakukan pengukuran response time (load test) menggunakan JMeter.
Bagaimana cara menggunakan JMeter dapat dicari dengan mudah di Google atau Youtube.

### PENGUMPULAN

##### A. Dokumentasi yang berisi:
1. Arsitektur dan proses instalasi yang dilakukan.
2. Dokumentasi pengetesan menggunakan JMeter

##### B. Demo di kelas
Melakukan demo di kelas.


### Artitektur
Arsitektur sama dengan tugas sebelumnya

IP|Hostname|Task
--|--------|----
192.168.33.11|manager|Manager, servicenode
192.168.33.12|clusterdb2|Datanode, servicenode
192.168.33.13|clusterdb3|Datanode
192.168.33.14|proxysql|ProxySQL, Wordpress Node

![vagrant status](src/vagrant_status.PNG)

### Install Wordpress
- SSH ke proxysql
    - `vagrant ssh proxysql`
- Install apache dan php
    - `sudo apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-mysql`
- Konfigurasi package wordpress
    - `wget -c http://wordpress.org/latest.tar.gz`
    - `tar -xzvf latest.tar.gz`
    - `sudo mv wordpress/* /var/www/html/`
- Set directory permission
    - `sudo chown -R www-data:www-data /var/www/html/`
    - `sudo chmod -R 755 /var/www/html/`
- Restart apache
    - `sudo systemctl restart apache2`

### Konfigurasi wordpress
- ssh ke salah satu servicenode
- masuk ke mysql
  - `mysql -u root -p`
  - password: root
- membuat database untuk wordpress
  - `create database wordpress`
- membuat user untuk wordpress
  - `CREATE USER 'wordpress'@'%' IDENTIFIED BY 'wordpress';`
  - `GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';`
  - `FLUSH PRIVILEGES;`

user telah dibuat, selanjutnya buat user yang sama di proxysql.
- ssh ke proxysql
- masuk ke mysql
  - `mysql -u root -p -h 127.0.0.1 -P 6032`
  - password: password
- jalankan perintah
  - `INSERT INTO mysql_users(username, password, default_hostgroup) VALUES ('wordpress', 'wordpress', 2);`
  - `LOAD MYSQL USERS TO RUNTIME;`
  - `SAVE MYSQL USERS TO DISK;`

langkah selanjutnya adalah menghubungkan aplikasi wordpress dengan database yang telah dibuat sebelumnya.
- kunjungi ip address proxysql ([192.168.33.14](192.168.33.14)), akan muncul seperti gambar dibawah

![welcome](src/welcome.jpg)

- klik continue, akan muncul form konfigurasi database wordpress. Isi sesuai dengan konfigurasi yang telah dibuat sebelumnya, arahkan IP ke proxysql untuk memanfaatkan load balancer.

![config_wordpress](src/config_wp.jpg)

- klik submit, langkah selanjutnya adalah membuat user wordpress. isi sesuai keinginan anda, jangan sampai lupa. karena user ini akan digunakan untuk login admin wordpress.

![config_wordpress_user](src/config_wp-user.jpg)

- klik install wordpress, konfigurasi telah berhasil

![home](src/home.jpg)

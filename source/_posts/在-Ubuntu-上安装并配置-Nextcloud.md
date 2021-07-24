---
title: 在 Ubuntu 上安装并配置 Nextcloud
date: 2021-07-24 09:16:37
updated: 2021-07-24 09:16:37
tags: 
  - Ubuntu
  - Nextcloud
categories: Ubuntu
titlename: install-and-configure-nextcloud-on-ubuntu
---
最近一段时间正好有想把 OneDrive 上存放的部分内容（如下载的音乐）以及存放在本地硬盘的内容（如备份的安装包等）迁移到其它位置的想法，这样可以给 OneDrive 和本地硬盘腾出宝贵的存储空间，但是迁移的位置反而称为了难题，百度网盘因为限速肯定无法成为首选，其它国外网盘容量较小而且可能会因为特殊原因访问受阻，都不是太好的选择。而 Nextcloud 这个开源项目因其社区驱动、可以自托管、拥有全平台客户端（Windows、macOS、Linux、iOS 和 Android）以及 WebDAV 支持进入了我的视野，于是我决定尝试自建 Nextcloud 私有云将这些数据全部迁移到这里。  

<!-- more -->  

> 系统环境：Kubuntu 21.04，并在 Ubuntu Server 21.04 上测试通过  

## 第一步：安装并配置 Apache 和 PHP 环境

### 1. 安装 Apache 和 PHP  

打开系统终端，使用 `apt` 工具安装 `Apache` 和 `PHP` 环境。  

> **Apache 版本**：Apache/2.4.46 (Ubuntu，Server built:   2021-06-17T17:09:41)   
> **PHP 版本**：7.4.16 (cli) (built: Jul  5 2021 13:04:38) ( NTS )  

命令如下：  

```bash
sudo apt install apache2 php7.4
```

安装完成后分别运行 `apache2 -v` 和 `php -v` 命令检测是否安装成功：  

[![WyHNwt.png](https://z3.ax1x.com/2021/07/24/WyHNwt.png)](https://imgtu.com/i/WyHNwt)  

---

### 2. 安装 PHP 扩展模块  

接下来安装 PHP 的部分扩展模块，这些模块是 Nextcloud 正常运行所需要的：  

> 注意：所需要的 PHP 扩展模块可能会随着 Nextcloud 的后续更新而发生变化，请以 Nextcloud 实际显示的内容为准  

命令如下：  

```bash
sudo apt install php7.4-zip php7.4-xml php7.4-gd php7.4-curl php7.4-mbstring php7.4-mysql php7.4-intl php7.4-bcmath php7.4-gmp php-imagick php-apcu php-redis
```

安装完成后运行 `php -m` 命令显示已安装的 PHP 扩展模块：  

[![WyH5pF.png](https://z3.ax1x.com/2021/07/24/WyH5pF.png)](https://imgtu.com/i/WyH5pF)  

---

### 3. 配置并检测 PHP 环境是否正常运行于 Apache 服务  

完成以上步骤后，接下来设置 Apache 和 PHP，并检查 PHP 环境能否正常在 Apache 服务器环境中运行。  

1. 在终端中输入 `cd /var/www/html` 命令并执行，将当前工作目录设置为 `/var/www/html`；

2. 确保当前工作目录为 `/var/www/html`，然后在终端中输入 `sudo vim index.php` 后按下回车键，进入 Vim；

3. 在 `index.php` 文件中新增以下内容，然后保存并退出：  
   ```php
   <?php
    phpinfo()
   ?>
   ```
4. 在终端中输入 `cd /etc/apache2` 命令并执行，将当前工作目录设置为 `/etc/apache2`；

5. 确保当前工作目录为 `/etc/apache2`，然后在终端中输入 `sudo vim apache2.conf` 后按下回车键，进入 Vim；

6. 在 `apache2.conf` 中查找以下内容：  
   ```conf
   <Directory /var/www/>
        DirectoryIndex index.html
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
   </Directory>
   ```
   在 `DirectoryIndex` 后新增 `index.php` 字段，这部分内容修改后应为：  
   ```conf
   <Directory /var/www/>
        DirectoryIndex index.html index.php
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
   </Directory>
   ```
   然后保存并退出；

7. 在终端中输入 `sudo service apache2 status` 检查 Apache 服务的运行状态，如果显示为 `Running`（正在运行），在终端中输入以下命令重新启动服务器：  
   ```bash
   sudo service apache2 restart
   ```

**检查 Apache 服务**：确保 Apache 服务正常运行，接下来打开浏览器，在地址栏输入 `localhost`，应该会出现以下页面内容（可能因系统而异）：  

[![WyHb01.png](https://z3.ax1x.com/2021/07/24/WyHb01.png)](https://imgtu.com/i/WyHb01)  

**检查 PHP 环境**：确保 Apache 服务正常运行，接下来打开浏览器，在地址栏输入 `localhost/index.php`，应该会出现以下页面内容（可能因系统而异）：  

[![WyHrlQ.png](https://z3.ax1x.com/2021/07/24/WyHrlQ.png)](https://imgtu.com/i/WyHrlQ)  

以上，Apache 和 PHP 环境的基础配置完成。  

---

## 第二步：安装并配置 MySQL / MariaDB 数据库  

### 1. 安装 MySQL / MariaDB 数据库  

Nextcloud 的正常运行必须要有数据库的支持，由于性能原因，官方不建议使用 `SQlite` 作为数据库后端，因此使用 `MySQL` 或 `MariaDB` 作为数据库后端（这两者大致相同）。  

打开系统终端，使用 `apt` 工具安装 `MariaDB` 数据库后端。 

```bash
sudo apt install mariadb-server
```

安装完成后，在终端中输入 `mysql --version` 查看当前数据库后端 `MariaDB Server` 的版本：  

> mysql  Ver 15.1 Distrib 10.5.10-MariaDB, for debian-linux-gnu (x86_64) using  EditLine wrapper  

至此，MariaDB 安装完成，接下来配置帐号登录和数据库。  

---

### 2. 设置 root 帐号  

你可以尝试使用 `mysql -u root -p` 以 root 帐号身份登录数据库管理端，如果失败，你可能需要进行以下操作[^3]：  

1. 在终端中输入 `cd /etc/mysql`，将当前工作目录设置为 `/etc/mysql`；
2. 确保当前工作目录为 `/etc/mysql`，在终端中输入 `sudo vim my.cnf` 进入 Vim（文件名可能因系统而异）；
3. 在 `my.cnf` 文件中新增以下内容：  
   ```conf
   [mysqld]
   skip-grant-tables
   ```
   然后保存并退出；
4. 在终端中输入 `sudo service mysql restart` 重启 MariaDB 服务，接下来再次在终端中输入 `mysql -u root -p`，若需要输入密码直接按下回车键继续，此时可以无需密码进入管理后端了；
5. 在管理后端中，输入 `use mysql;` 选择需要操作的数据库 `mysql`；
6. 选择数据库成功后，在管理后端输入 `flush privileges;` 刷新权限；
7. 刷新权限完成后，在管理后端输入 `alter user root@localhost identified by 'PASSWORD';`（`identified by` 后输入重设的 root 帐号的密码），然后按下回车键执行；
8. 密码重设完成后，在管理后端输入 `flush privileges;` 再次刷新权限；
9. 在管理后端输入 `quit;` 退出管理后端；  

以上步骤完成后，在终端中输入 `cd /etc/mysql`，将当前工作目录设置为 `/etc/mysql`；确保当前工作目录为 `/etc/mysql`，在终端中输入 `sudo vim my.cnf` 进入 Vim（文件名可能因系统而异），注释掉 `skip-grant-tables`  这一行：  

```conf
[mysqld]
# skip-grant-tables
```

然后保存并退出。  

接下来在终端中输入 `sudo service mysql restart` 命令重启 MariaDB 服务；完成后在终端中输入 `mysql -u root -p` 再次以 root 帐号身份登录 MariaDB 管理后端，如果成功，继续配置用于 Nextcloud 的数据库，如果失败，可尝试参考全文末尾的[^2][^4][^7]部分来解决问题。  

---

### 3. 设置 Nextcloud 数据库  

在终端中输入 `mysql -u root -p` 进入 MariaDB 管理后端，然后依次输入并执行以下命令[^1]：  

```mysql
create database nextcloud; 
create user nxtcloudadmin@localhost identified by 'admin123'; 
grant all privileges on nextcloud.* to nxtcloudadmin@localhost identified by 'admin123'; 
flush privileges; 
exit;
```

> 将 `nxtcloudadmin` 替换为你自定义的用户名，将 `identified by` 后面的 `admin123` 替换为你自设的密码。  
> **注意**：这非常重要，你在此处输入的用户名和密码将被用来登录和配置 Nextcloud 所使用的数据库，请牢记密码。  

配置完成后，在终端中输入 `sudo service mysql restart` 重启 MariaDB 服务，接下来开始安装和配置 Nextcloud 云盘。  

---

## 第三步：安装并配置 Nextcloud  

### 1. 获取 Nextcloud  

访问 [这个链接](https://nextcloud.com/install/#instructions-server) 获取最新版本的 Nextcloud，在终端中输入以下命令，将 Nextcloud 程序包下载到本地、解压，准备部署：  

```bash
wget https://download.nextcloud.com/server/releases/nextcloud-22.0.0.zip
unzip nextcloud-22.0.0.zip
sudo cp -r nextcloud /var/www
```

---

### 2. 配置 Apache 服务器  

在终端中输入以下命令：  

```bash
sudo vim /etc/apache2/sites-available/nextcloud.conf
```

进入 Vim，在文件中新增以下内容：  

```conf
Alias /nextcloud "/var/www/nextcloud/"

<Directory /var/www/nextcloud/>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews
  Satisfy Any

  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
```

然后保存并退出。  

接下来启用所需要的 Apache 服务器模块，然后启用 Nextcloud 站点，在终端中输入以下命令：  

```bash
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo a2enmod setenvif

cd /etc/apache2/sites-available

sudo a2ensite nextcloud.conf
```

并等待操作全部执行完成。  

以上步骤完成后，接下来将 Nextcloud 根目录 `/var/www/nextcloud/` 的所有者设为 www-data（Apache HTTP 服务用户），在终端中输入以下命令并重启 Apache 服务：  

```bash
sudo chown -R www-data:www-data /var/www/nextcloud/
sudo service apache2 restart
```

待 Apache 服务重启后，打开浏览器，在地址栏输入 `localhost/nextcloud`，如果不出意外，此时就应进入 Nextcloud 的图形安装界面了。  

---

### 3. 安装 Nextcloud 程序  

如果以上步骤全部完成，不出意外此时用浏览器访问 `localhost/nextcloud` 就会进入 Nextcloud 的图形安装界面了。如下图所示：  

[![WybpXd.png](https://z3.ax1x.com/2021/07/24/WybpXd.png)](https://imgtu.com/i/WybpXd)  

**设置登录时使用的管理员帐号密码**[^6]：  

[![WybmcQ.png](https://z3.ax1x.com/2021/07/24/WybmcQ.png)](https://imgtu.com/i/WybmcQ)  

**设置 Nextcloud 所使用的数据库（数据库类型选择 `MySQL/MariaDB`）**[^6]：  

[![Wyb3NV.png](https://z3.ax1x.com/2021/07/24/Wyb3NV.png)](https://imgtu.com/i/Wyb3NV)  

输入完上方的配置信息字段后，取消勾选底部的“安装推荐的应用”选项，然后单击“完成安装”按钮，耐心等待 Nextcloud 配置完成进入主界面。  

[![WybY3F.png](https://z3.ax1x.com/2021/07/24/WybY3F.png)](https://imgtu.com/i/WybY3F)  

至此，Nextcloud 的安装基本完成。  

---

## 第四步：对 Nextcloud 进行微调  

### 1. 修复 `"Memcache \OC\Memcache\APCu not available for local cache"` 问题  

要避免出现这个提示信息，你需要启用可用于命令行请求的 APCu 功能支持，默认情况下该功能仅对网络服务器请求启用[^8]。  

在终端中依次输入以下命令：  

```bash
cd /etc/php/7.4/mods-available
sudo vim apcu.ini
```

使用 Vim 打开 `apcu.ini` 配置文件，在文件末尾新增以下内容：  

```ini
apc.enable_cli=1
```

然后保存并退出。

然后重新执行更新 `.htaccess` 文件的命令，如果未生效，请重启 Apache 服务。

---

### 2. 移除链接中的 `index.php`  

`mod_env` 和 `mod_rewrite` 必须已安装在你的服务器上，另外`.htaccess` 文件必须被配置为可被 HTTP 组用户写入。接下来在 `config.php` 文件中添加两个变量键值：  

在终端中输入以下命令：  

```bash
sudo vim /var/www/nextcloud/config/config.php
```

进入 Vim，在文件中新增以下内容（**根据实际安装情况选择**）：  

```php
# 如果 Nextcloud 被安装在 /nextcloud 子目录中
'overwrite.cli.url' => 'https://example.org/nextcloud',
'htaccess.RewriteBase' => '/nextcloud',
```

或  

```php
# 如果 Nextcloud 被安装在站点根目录下
'overwrite.cli.url' => 'https://example.org/',
'htaccess.RewriteBase' => '/',
```

然后保存并退出。  

完成上述改动后，在终端中输入以下命令：  

```bash
sudo chmod +x /var/www/nextcloud/occ
sudo -u www-data php /var/www/nextcloud/occ maintenance:update:htaccess
```

来更新你的 `.htaccess` 文件并应用所有改动。  

> 如果所做的改动仍未生效，可能还需要重启 Apache 服务器。  

---

### 3. 修改 `PHP 内存限制值` 和 `Nextcloud 最大上传文件大小`  

首先定位 Nextcloud 所使用的 PHP 配置文件 `php.ini` 的位置。

在浏览器的地址栏中输入地址 `localhost/index.php` 打开 PHP 的环境概述页面，查找 `Loaded Configuration File` 键值项，该项右侧的文件位置即为当前已加载并且在 Nextcloud 中起作用的配置文件的位置。  

[![Wybau9.png](https://z3.ax1x.com/2021/07/24/Wybau9.png)](https://imgtu.com/i/Wybau9)  

在终端中输入以下命令：  

```bash
sudo vim /etc/php/7.4/apache2/php.ini
```

进入 Vim，然后查找以下内容：  

```ini
; Maximum amount of memory a script may consume
; http://php.net/memory-limit
memory_limit = 128M
```

修改为：  

```ini
; Maximum amount of memory a script may consume
; http://php.net/memory-limit
memory_limit = 512M
```

继续查找以下内容：  

```ini
; Maximum allowed size for uploaded files.
; http://php.net/upload-max-filesize
upload_max_filesize = 2M
```

修改为：  

```ini
; Maximum allowed size for uploaded files.
; http://php.net/upload-max-filesize
upload_max_filesize = 2048M
```

然后保存并退出，重启 Apache 服务器，此时服务器的 `PHP 内存限制值` 将变为 `512M`，而 `Nextcloud 的最大文件上传大小` 将变为 `2048M`。  

---

### 4. 启用内存缓存  

为 Nextcloud 配置内存缓存可以加快 Nextcloud 的运行速度，提升运行效率[^5]。  

在终端中输入以下命令安装 `Redis`：  

```bash
sudo apt install redis
```

确保 `php-apcu`、`Redis` 和 `php-redis` 都已正确安装。然后使用 Vim 打开 Nextcloud 的配置文件 `config.php`，将以下内容加入文件中保存：  

```php
'memcache.local' => '\OC\Memcache\APCu',
'memcache.distributed' => '\OC\Memcache\Redis',
'memcache.locking' => '\OC\Memcache\Redis',
'redis' => [
     'host' => 'localhost',
     'port' => 6379,
],
```

再使用 Vim 打开 `/etc/redis/redis.conf` 文件（即 `Redis` 配置文件），查找并修改以下内容：  

```conf
# Specify the path for the Unix socket that will be used to listen for
# incoming connections. There is no default, so Redis will not listen
# on a unix socket when not specified.
#
# unixsocket /var/run/redis/redis-server.sock
# unixsocketperm 700
```

修改为：  

```conf
# Specify the path for the Unix socket that will be used tlisten for
# incoming connections. There is no default, so Redis will not listen
# on a unix socket when not specified.
#
unixsocket /var/run/redis/redis-server.sock
unixsocketperm 770
```

然后保存并退出。  

在终端中输入以下命令：  

```bash
sudo usermod -a -G redis www-data
```

将 `网络服务器` 用户添加到 `Redis` 用户组中，确保 `redis.sock` 可被服务器正常读写。然后重新启动 `Redis` 服务和 `Apache` 服务，检查内存缓存工作是否正常。  

---

## 引用参考  

[^1]:https://blog.csdn.net/qq_30754565/article/details/81591812
[^2]:https://blog.csdn.net/username666/article/details/105293770
[^3]:https://blog.csdn.net/jacson_bai/article/details/107116050
[^4]:https://docs.nextcloud.com/server/21/admin_manual/issues/general_troubleshooting.html#service-discovery
[^5]:https://docs.nextcloud.com/server/21/admin_manual/configuration_server/caching_configuration.html
[^6]:https://docs.nextcloud.com/server/21/admin_manual/installation/installation_wizard.html
[^7]:https://www.shangmayuan.com/a/3dae555349e840e29413da4e.html
[^8]:https://help.nextcloud.com/t/nc13-memcache-oc-memcache-apcu-not-available-for-local-cache/31027  

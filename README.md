wordpress
=====================

Описание
-----------

Проект для развертывания Wordpress на ОС CentOS 6 на ВМ. Используется связка NGINX+PHP-FPM. В качестве СУБД использовать PerconaDB. Развервание осуществляется Pupppet.

Установка и запуск
---------------------------------

Скопровать и распоковать архив wordpress-master.zip. 

Или выполнить команду:

``` 
 git clone https://github.com/avv8401/wordpress.git
```
Перейти в папку wordpress и выполнить команду:

``` 
vagrant up --provision
```
Доступ к сайту wordpress осуществляется по порту 8037.Пример:

```
firefox http://localhost:8037/
```
Список используемых модулей(содержатся в папке modules): information by now:

* continuent-percona_repo - подключает репозитории Percona 
* puppetlabs-mysql - для развертывания сервера MySQL 
* mysql_service - объеденяет 2 указзаных выше модуля 
* jfryman-nginx - устанавливает веб сервер NGINX 
* php_fpm - устанавливает php и php-fpm 
* wordpress - модуль по развертыванию wordpress 
* example42-iptables - настройка iptables.

Описение модуля wordpress:
* $vhname - имя виртуального хоста для Nginx. Конфигурационый файл будет распологатся в директории /etc/nginx/sites-available. 
* $www - директория с сайтом wordpress. 
* $ssl_enable - включение/выключение SSL. 
* $db_user - имя пользователь базы данных. 
* $db_pass - пароль пользователя базы данных. 
* $db_host - хост базы данных.
* $db_name - имя базы данных.
 
Доступ к  ВМ по SSH

```
vagrant ssh
```
Пользователь vagrant может выполнить sudo без пароля.


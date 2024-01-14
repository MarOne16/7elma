#!/bin/sh

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

wp core download --allow-root

while ! mysqladmin -h mariadb ping --silent; do sleep 1; done

# change those lines in wp-config.php file to connect with database
if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp config create --skip-check --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost='mariadb' --allow-root
fi

wp core install --url=$DOMAIN_NAME --title='Blog Title' --admin_user=$WORDPRESS_USER --admin_password=$WORDPRESS_PASSWORD --admin_email=$WP_ADMINEMAIL --allow-root

wp user create $WP_USER $WP_USEREMAIL --user_pass=$WP_PASS --allow-root

#install a plugin 

# wp config set WP_REDIS_HOST redis --allow-root --add
# wp config set WP_REDIS_PORT 6379 --allow-root --add

# wp plugin install redis-cache --allow-root
# wp plugin activate redis-cache --allow-root
# wp redis enable --allow-root
# wp redis status

/usr/sbin/php-fpm7.4 -F
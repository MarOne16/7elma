#!/bin/sh

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf


wp core download --allow-root

while ! mysqladmin -h mariadb ping --silent; do sleep 1; done

if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp config create --skip-check --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root
fi

wp core install --url=$DOMAIN_NAME --title='NULL' --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL  --allow-root

if ! wp user list --field=user_login --name="$WP_USR" --allow-root 2>/dev/null | grep -q "^$WP_USR$"; then
    wp user create "$WP_USR" "$WP_EMAIL" --user_pass="$WP_PWD" --allow-root
else
    echo "WordPress user '$WP_USR' already exists. Skipping user creation."
fi


/usr/sbin/php-fpm7.4 -F
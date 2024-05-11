#!/bin/bash
# Backup WordPress Data and Database to S3 Bucket

# Set Variables
DB_CONTAINER_NAME="wordpress_db_1"
WP_VOLUME_PATH="/var/wp-site"
S3_BUCKET="my-wordpress-backup-bucket-11-05"

# Backup the WordPress Database
docker exec $DB_CONTAINER_NAME mysqldump -u wordpress -p'wordpress' wordpress > $WP_VOLUME_PATH/backup.sql

# Archive the Database and WordPress Files
tar czf /tmp/wordpress_backup.tar.gz -C $WP_VOLUME_PATH backup.sql wp-content

# Upload to S3
aws s3 cp /tmp/wordpress_backup.tar.gz s3://$S3_BUCKET/wordpress_backup_$(date +%F).tar.gz

# Cleanup
rm -f /tmp/wordpress_backup.tar.gz
rm -f $WP_VOLUME_PATH/backup.sql

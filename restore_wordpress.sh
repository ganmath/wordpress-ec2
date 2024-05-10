#!/bin/bash
# Restore WordPress Data and Database from S3 Bucket

# Set Variables
DB_CONTAINER_NAME="wordpress_db_1"
WP_VOLUME_PATH="/var/wp-site"
S3_BUCKET="my-wordpress-backup-bucket"

# Download Latest Backup
aws s3 cp s3://$S3_BUCKET/latest_backup.tar.gz /tmp/latest_backup.tar.gz

# Extract Files
tar xzf /tmp/latest_backup.tar.gz -C $WP_VOLUME_PATH

# Restore Database
docker exec -i $DB_CONTAINER_NAME mysql -u wordpress -p'wordpress' wordpress < $WP_VOLUME_PATH/backup.sql

# Cleanup
rm -f /tmp/latest_backup.tar.gz
rm -f $WP_VOLUME_PATH/backup.sql

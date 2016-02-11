#!/bin/bash

chmod -R 0644 /etc/apache2/sites-available/
chmod 0644 /etc/cron.d/tds
chmod 0777 /home/app/.s3cfg
chmod 0777 /home/app/deploy.sh

# mariadb-monitor
To monitor whether MariaDB is active or has been killed by the OOM killer

## How to Use

Grant the file permission of 755, and then it can be executed.

```shell
chmod 755 /path/to/the/file/db_monitor.sh
```

You can add the script to a cron job to monitor the database and restart it if necessary.

Add the following line to your `crontab`:

```shell
crontab -e
```

```bash
*/1 * * * * /bin/bash /path/to/the/file/db_monitor.sh
```

This will execute the script every minute, allowing you to monitor the database continuously.

You can check by this command

```shell
crontab -l
```

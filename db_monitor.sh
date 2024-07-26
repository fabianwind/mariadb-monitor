#!/bin/bash

# log路徑
LOG_FILE="./db_monitor.log"

# 當前時間
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# 檢查MariaDB服務的狀態
check_mariadb() {
    systemctl is-active --quiet mariadb
}

# 重啟MariaDB服務
restart_mariadb() {
    echo "MariaDB服務停止，嘗試重新啟動..." >> $LOG_FILE
    systemctl start mariadb
}

# 最大重試次數
MAX_RETRIES=3
# 重試間隔時間（秒）
RETRY_INTERVAL=5

# 開始記錄
echo "$CURRENT_TIME: 開始檢查MariaDB服務狀態..." >> $LOG_FILE

# 檢查並重啟服務，蟲試次數
for ((i=1; i<=MAX_RETRIES; i++)); do
    if check_mariadb; then
        echo "$CURRENT_TIME: MariaDB服務運行正常。" >> $LOG_FILE
        exit 0
    else
        restart_mariadb
        echo "$CURRENT_TIME: 已嘗試重啟次數：$i" >> $LOG_FILE
        if (( i < MAX_RETRIES )); then
            echo "$CURRENT_TIME: 等待 $RETRY_INTERVAL 秒後重試..." >> $LOG_FILE
            sleep $RETRY_INTERVAL
        fi
    fi
done

# 無法啟動，寫入log
echo "$CURRENT_TIME: 已達到最大重試次數，MariaDB服務未能啟動。" >> $LOG_FILE
exit 1
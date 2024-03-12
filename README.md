# SpringBoot初體驗

## 切換profile選擇設定檔
可用選項：

1. H2_env
    - 使用H2資料庫於記憶體中
    - dockcerfile若未指定profile則預設使用此設定
    - 直接CloudRun上去會使用此設定

2. psql_env
    - 使用PostgreSQL資料庫
    - volume掛載於本專案的`./psql-data`資料夾中
    - 整合於docker-compose中，直接啟動即可
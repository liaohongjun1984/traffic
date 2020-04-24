
1 配置本地host
120.24.232.32 tygi.mysql.com
120.24.232.32 tygi.slave.mysql.com
127.0.0.1 tygi.memcache.yyop
127.0.0.1 test.care.189.cn

2 suc-web Debug Configuration配置
Name:admin
directory:suc-web
Goals:clean  generate-sources  jetty:run
Profiles:test
勾选skip Tests

3 登录地址和账号
local.suc.bd.iweju.com:8080
admin
123456

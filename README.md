# php-fpm-nginx
php-fpm and nginx based on debian-jessie

## 目录结构

```bash
-- buildpack   # 各系统，各版本buildpack镜像
-- debian      # 各系统，各版本基本运行镜像
```

## 使用

可以根据具体情况替换默认的php-fpm 和nginx 配置文件。

- 拉取镜像

```bash
docker pull goodrainapps/php-fpm-nginx:5.6-debian-jessie
```

- 运行镜像

```bash
docker run -it --rm -p 80:80 goodrainapps/php-fpm-nginx:5.6-debian-jessie
```

## nginx文档主目录
镜像默认使用 `/app` 目录作为web的主目录，请将应用代码存放到该目录下，并修改正确的属主 `chown rain.rain /app -R`

## 持久化目录
镜像默认使用 `/data` 目录作为持久化目录，可根据应用的实际情况将持久化文件存放在这个目录，或者自定义持久化目录

## 支持的参数
镜像支持`debug`和`version` 参数

| 参数 | 说明|
|------|---------|
| debug| 进入容器命令行 |
| version |显示PHP和Nginx版本信息|



## 支持的环境变量

暂无

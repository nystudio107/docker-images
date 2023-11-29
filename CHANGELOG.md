# nystudio107/docker-images Change Log

## 1.2.24 - UNRELEASED
### Changed
* Remove `ENV PHPIZE_DEPS`, and use the environment variable inherited from the parent Alpine images rather than manually setting it ourselves

## 1.2.24 - 2023.11.26
### Changed
* Removed `libressl` in favor of `openssl` to allow Postgres to work

## 1.2.23 - 2023.10.05
### Added
* Switch `php-prod-base:8.2-alpine` from Alpine `3.17` to `3.18`

## 1.2.22 - 2023.07.22
### Added
* Add `node-20-alpine` image

## 1.2.21 - 2023.07.19
### Added
* Add `node-18-alpine` image
* Add `php-prod-base:8.1-alpine` image
* Add `php-dev-base:8.1-alpine` image
* Add `php-prod-base:8.2-alpine` image
* Add `php-dev-base:8.2-alpine` image

## 1.2.20 - 2021.11.24
### Added
* Add `node-16-alpine` image

## 1.2.19 - 2021.08.02
### Added
* Add trigger-based profiling for Xdebug

### Fixed
* Fixed upstream issues with `libressl` by pinning to alpine3.13 (https://stackoverflow.com/questions/68013058/alpine3-14-docker-libtls-so-20-conflict)
* Change from the specific version `gnu-libiconv=1.15-r3` to just `gnu-libiconv`

## 1.2.18 - 2021.06.26
### Changed
* Continue running the `php-fpm` containers as root (since `php-fpm` uses worker pools with the proper user/group), but switch to `su-exec` to ensure any craft CLI commands are run as `www-data`

## 1.2.17 - 2021.06.15
### Fixed
* Fixed typo in Dockerfile that would cause the PHP container to not build

## 1.2.16 - 2021.06.15
### Changed
* Removed `USER` directive in the PHP containers, since the pool runs as `www-data` already
* Fix permissions regression

## 1.2.15 - 2021.06.11
### Changed
* Cleaned up the `php-dev-craft` & `php-prod-craft` Dockerfile file permissions

## 1.2.14 - 2021.06.11
### Added
* Added GitHub actions for automated Docker image building & pushing

## 1.2.13 - 2021.05.24
### Changed
* Use the `mysql/mysql-server:8.0` image for MySQL, which is the official image from Oracle and is M1 compataible (as well as a bit smaller) (https://github.com/docker-library/mysql/issues/318)

## 1.2.12 - 2021.05.23
### Changed
* Run php container as the `www-data` user to avoid permissions issues

## 1.2.11 - 2021.03.29
### Added
* Added support for webp to the GD PHP extension in `php-prod-base:8.0-alpine` & `php-prod-base:7.4-alpine`

## 1.2.10 - 2021.03.14
### Added
* Added `14-alpine` image for `n`ode-dev-base`

## 1.2.9 - 2021.03.07
### Added
* Added `docker-compose.yaml` & image for MySQL 8

### Changed
* Use official MariaDB images

## 1.2.10 - 2021.03.14
### Added
* Added `14-alpine` image for `node-dev-base`

## 1.2.9 - 2021.03.07
### Added
* Added `docker-compose.yaml` & image for MySQL 8

### Changed
* Use official MariaDB images

## 1.2.8 - 2021.02.19
### Added
* Added `libjpeg-turbo-dev` to `node-dev-base:12-alpine` to allow ImageMin to work with Sharp

## 1.2.7 - 2021.02.09
### Fixed
* Fixed iconv for Alpine 3.1.3 by pinning it to `gnu-libiconv=1.15r3` per: https://github.com/docker-library/php/issues/1121

## 1.2.6 - 2021.02.09
### Added
* Added PHP 8.0 containers with JIT enabled for prod, and including Imagick for both dev & prod

## 1.2.5 - 2021.01.26
### Added
* Added Docker bind mount for `compiled_templates` so XDebug can be used with Twig templates

## 1.2.4 - 2021.01.06
### Changed
* Broke out the `php.ini` settings into `zzz-docker-php.ini` that we copy into place
* Synced up the various settings that contribute to the maximum uploadable file size
* Renamed `zzz-docker.cong` -> `zzz-docker-php-fpm.conf` to make what it's for more clear

## 1.2.3 - 2021.01.04
### Added
* Added `node-dev-webpack` placeholder containers

## 1.2.2 - 2021.01.04
### Changed
* `chown` the `cms/web` directory

## 1.2.1 - 2021.01.03
### Changed
* Use `yobasystems/alpine-mariadb:10.4.15` for MariaDB

## 1.2.0 - 2021.01.03
### Added
* Added significantly slimmer Alpine images for all containers with the `-alpine` tag
* Added `redis` placeholder container
* Added `mariadb` placeholder container
* Added `postgres` placeholder container

### Changed
* Added `--no-install-recommends` to all `apt-get install` commands

## 1.1.1 - 2020.12.22
### Changed
* Have `php-dev-base` layer on top of `php-prod-base`

## 1.1.0 - 2020.12.21
### Added
* Added `dh-autoreconf` to fix a [build issue](https://github.com/imagemin/imagemin-gifsicle/issues/37#issuecomment-578115789) with gifsicle
* Added PHP 7.4 images for `php-dev-base` and `php-prod-base`

## 1.0.10 - 2020.12.01
### Added
* Added `postgresql-client-12` to the postgres PHP containers to allow db backups to work

## 1.0.9 - 2020.11.25
### Changed
* Change `mysql-client` to `mariadb-client`

## 1.0.8 - 2020.11.25
### Added
* Add `mysql-client` in the `php-dev-craft` & `php-prod-craft` MariaDB containers so we get `mysqldump`

### Changed
* Both MariaDB and Postgres `php-prod-craft` containers should use `FROM php-prod-base`

## 1.0.7 - 2020.11.20
### Added
* Add `node-12` image

## 1.0.6 - 2020.11.17
### Fixed
* Removed `xdebug.remote_connect_back` from the `php-dev-base` container's `xdebug.ini` file to allow xdebug to connect properly

## 1.0.5 - 2020.10.26
### Changed
* Removed deprecated `links` from `docker-compose.yaml`
* Use Composer 2.x

## 1.0.4 - 2020.10.26
### Changed
* Use port `9003` for `xdebug`

## 1.0.3 - 2020.10.24
### Added
* Added a `php_xdebug` container to speed up normal request by eliminating `xdebug` unless it's requested for via `XDEBUG_SESSION` cookie
* Added Nginx container
* Added `keep_alive.sh` script for the `queue` container

## 1.0.2 - 2020.09.09
### Added
* Added a `queue` docker container to run queue jobs via `./craft queue/listen`

## 1.0.1 - 2020.09.08
### Added
* Added image optimizers to the `php-dev-craft` Docker image

## 1.0.0 - 2020.06.01
### Added
* Initial release

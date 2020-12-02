# nystudio107/docker-images Change Log

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

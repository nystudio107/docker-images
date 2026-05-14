BUILDER_NAME?=craft-builder
BUILD_PLATFORM?=linux/$(shell arch)
BUILD_COMMAND?=docker buildx build --builder ${BUILDER_NAME}
IMAGE_NAMESPACE?=nystudio107
PHP_PROD_NAMESPACE?=php-prod-base
PHP_DEV_NAMESPACE?=php-dev-base
NODE_NAMESPACE?=node-dev-base

# Mirrors PHP supported versions: https://www.php.net/supported-versions.php
PHP_VERSIONS?=php-8.2-alpine php-8.3-alpine php-8.4-alpine php-8.5-alpine
# Mirrors NodeJS supported versions: https://nodejs.org/en/about/previous-releases
NODE_VERSIONS?=node-20-alpine node-22-alpine node-24-alpine node-26-alpine

.PHONY: all create-builder php $(PHP_VERSIONS) node $(NODE_VERSIONS)

# Build all base images
build: export BUILD_FLAGS:=--load
build: php node

# Build & push all base images
push: export BUILD_FLAGS:=--push
push: export BUILD_PLATFORM:=linux/arm64/v8,linux/amd64
push: php node

# Ensure a builder exists for docker buildx
create-builder:
	-@if [ ! "$$(docker buildx inspect ${BUILDER_NAME} 2>/dev/null)" ]; then \
		echo "No builder exists, creating builder: ${BUILDER_NAME}" ; \
		docker buildx create --name ${BUILDER_NAME} ; \
	fi

# Build all php base images
php:$(PHP_VERSIONS)

# Build specific php prod & dev base images
$(PHP_VERSIONS):create-builder
	${BUILD_COMMAND} --platform ${BUILD_PLATFORM} ${BUILD_FLAGS} -t ${IMAGE_NAMESPACE}/${PHP_PROD_NAMESPACE}:$(subst php-,,$@) ${PHP_PROD_NAMESPACE}/$@
	${BUILD_COMMAND} --platform ${BUILD_PLATFORM} ${BUILD_FLAGS} -t ${IMAGE_NAMESPACE}/${PHP_DEV_NAMESPACE}:$(subst php-,,$@) ${PHP_DEV_NAMESPACE}/$@

# Build all node base images
node:$(NODE_VERSIONS)

# Build specific node base images
$(NODE_VERSIONS):create-builder
	${BUILD_COMMAND} --platform ${BUILD_PLATFORM} ${BUILD_FLAGS} -t ${IMAGE_NAMESPACE}/${NODE_NAMESPACE}:$(subst node-,,$@) ${NODE_NAMESPACE}/$@

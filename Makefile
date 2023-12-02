BUILDER_NAME?=craft-builder
BUILD_PLATFORM?=linux/$(shell arch)
BUILD_COMMAND?=docker buildx build --load --platform ${BUILD_PLATFORM} --builder ${BUILDER_NAME}
IMAGE_NAMESPACE?=nystudio107
PHP_PROD_NAMESPACE?=php-prod-base
PHP_DEV_NAMESPACE?=php-dev-base
NODE_NAMESPACE?=node-dev-base

PHP_VERSIONS?=php-7.4-alpine php-8.0-alpine php-8.1-alpine php-8.2-alpine
NODE_VERSIONS?=node-14-alpine node-16-alpine node-18-alpine node-20-alpine

.PHONY: all create-builder php $(PHP_VERSIONS) node $(NODE_VERSIONS)

# Build all base images
all: php node

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
	${BUILD_COMMAND} -t ${IMAGE_NAMESPACE}/${PHP_PROD_NAMESPACE}:$(subst php-,,$@) ${PHP_PROD_NAMESPACE}/$@
	${BUILD_COMMAND} -t ${IMAGE_NAMESPACE}/${PHP_DEV_NAMESPACE}:$(subst php-,,$@) ${PHP_DEV_NAMESPACE}/$@

# Build all node base images
node:$(NODE_VERSIONS)

# Build specific node base images
$(NODE_VERSIONS):create-builder
	${BUILD_COMMAND} -t ${IMAGE_NAMESPACE}/${NODE_NAMESPACE}:$(subst node-,,$@) ${NODE_NAMESPACE}/$@

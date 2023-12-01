BUILDER_NAME?=craft-builder
BUILD_PLATFORMS?=linux/$(shell arch)
BUILD_COMMAND?=docker buildx build --load --platform ${BUILD_PLATFORMS} --builder ${BUILDER_NAME}
IMAGE_NAMESPACE?=nystudio107
.PHONY: create-builder

# Ensure a builder exists for docker buildx
create-builder:
	-@if [ ! "$$(docker buildx inspect ${BUILDER_NAME} 2>/dev/null)" ]; then \
		echo "No builder exists, creating builder: ${BUILDER_NAME}" ; \
		docker buildx create --name ${BUILDER_NAME} ; \
	fi
# Build an image with docker buildx
build-image: create-builder
	${BUILD_COMMAND} -t ${IMAGE_NAMESPACE}/${TARGET_VERSION} ${TARGET_BASE}/${TARGET_VERSION}

# Build & load all php base images
php: php8.0 php8.1 php8.2

# Build & load php prod & dev base 8.0 images
php8.0: php-prod-base8.0 php-dev-base8.0
# Build & load php prod base 8.0 images
php-prod-base8.0: TARGET_BASE=php-prod-base
php-prod-base8.0: TARGET_VERSION=8.0-alpine
php-prod-base8.0: build-image
# Build & load php dev base 8.0 images
php-dev-base8.0: TARGET_BASE=php-dev-base
php-dev-base8.0: TARGET_VERSION=8.0-alpine
php-dev-base8.0: build-image

# Build & load php prod & dev base 8.1 images
php8.1: php-prod-base8.1 php-dev-base8.1
# Build & load php prod base 8.1 images
php-prod-base8.1: TARGET_BASE=php-prod-base
php-prod-base8.1: TARGET_VERSION=8.1-alpine
php-prod-base8.1: build-image
# Build & load php dev base 8.1 images
php-dev-base8.1: TARGET_BASE=php-dev-base
php-dev-base8.1: TARGET_VERSION=8.1-alpine
php-dev-base8.1: build-image

# Build & load php prod & dev base 8.2 images
php8.2: php-prod-base8.2 php-dev-base8.2
# Build & load php prod base 8.2 images
php-prod-base8.2: TARGET_BASE=php-prod-base
php-prod-base8.2: TARGET_VERSION=8.2-alpine
php-prod-base8.2: build-image
# Build & load php dev base 8.2 images
php-dev-base8.2: TARGET_BASE=php-dev-base
php-dev-base8.2: TARGET_VERSION=8.2-alpine
php-dev-base8.2: build-image

# Build & load all node base images
node: node14 node16 node18 node20

# Build & load node 14 images
node14: TARGET_BASE=node-dev-base
node14: TARGET_VERSION=14-alpine
node14: build-image

# Build & load node 16 images
node16: TARGET_BASE=node-dev-base
node16: TARGET_VERSION=16-alpine
node16: build-image

# Build & load node 18 images
node18: TARGET_BASE=node-dev-base
node18: TARGET_VERSION=18-alpine
node18: build-image

# Build & load node 20 images
node20: TARGET_BASE=node-dev-base
node20: TARGET_VERSION=20-alpine
node20: build-image

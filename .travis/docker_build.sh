#!/bin/sh -e

IMAGE_NAME=${TRAVIS_REPO_SLUG}

for ARCH in amd64 arm64v8 arm32v7 arm64v6; do
    case $ARCH in
    amd64)
        DOCKERFILE='Dockerfile'
        ;;
    *)
        DOCKERFILE="Dockerile.$ARCH"
        ;;
    esac

    FULL_NAME_NAME=${IMAGE_NAME}:${ARCH}-test
    docker build -t "${FULL_NAME_NAME}" -f ${DOCKERFILE} .
    echo FULL_NAME_NAME >>"/tmp/${TRAVIS_COMMIT}/images"

    ## DEBUG
    docker version
    docker inspect "${FULL_NAME_NAME}"
    cat "/tmp/${TRAVIS_COMMIT}/images"
done

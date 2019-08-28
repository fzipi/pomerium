#!/bin/sh -e

IMAGE_NAME=${TRAVIS_REPO_SLUG}
TMPDIR=/tmp/${TRAVIS_COMMIT}

mkdir -p "${TMPDIR}"

for ARCH in amd64 arm64v8 arm32v7 arm64v6; do
    case $ARCH in
    amd64)
        DOCKERFILE='Dockerfile'
        ;;
    *)
        DOCKERFILE="Dockerfile.$ARCH"
        ;;
    esac

    FULL_IMAGE_NAME=${IMAGE_NAME}:${ARCH}-test
    docker build -t "${FULL_IMAGE_NAME}" -f ${DOCKERFILE} .
    echo FULL_IMAGE_NAME >>${TMPDIR}/images

    ## DEBUG
    docker version
    docker inspect "${FULL_IMAGE_NAME}"
    cat "/tmp/${TRAVIS_COMMIT}/images"
done

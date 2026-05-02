FROM alpine:latest

RUN set -o xtrace \
    && apk update \
    && apk add --no-cache fuse3 file curl \
    && rm -rf /var/cache/apk/*

RUN set -o xtrace \
    && ARCH=$(uname -m) \
    && case $ARCH in \
        x86_64) APPIMAGETOOL_ARCH=x86_64 ;; \
        aarch64) APPIMAGETOOL_ARCH=aarch64 ;; \
        armv7l) APPIMAGETOOL_ARCH=armhf ;; \
        i686) APPIMAGETOOL_ARCH=i686 ;; \
        *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac \
    && wget -O /usr/local/bin/appimagetool "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-${APPIMAGETOOL_ARCH}.AppImage" \
    && chmod +x /usr/local/bin/appimagetool

From alpine:edge

ADD package.json wdio.conf.js yarn.lock /root/webdriverio-chrome/

RUN apk add --update --no-cache \
            udev \
            ttf-freefont \
            chromium \
            chromium-chromedriver \
            openjdk8 \
            nodejs \
            nodejs-npm \
            yarn make gcc g++ python \
            curl && \
    cd /tmp && \
    curl https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O && \
    unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv && \
    rm -rf * && \
    cd /root/webdriverio-chrome/ && \
    yarn && \
    apk del --purge yarn make gcc g++ python curl

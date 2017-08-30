From alpine:edge

ADD package.json wdio.conf.js yarn.lock test-sample.js /root/webdriverio-chrome/

RUN apk add --update --no-cache \
            udev \
            ttf-freefont \
            chromium \
            chromium-chromedriver \
            xvfb \
            openjdk8 \
            nodejs \
            yarn \
            make gcc g++ python \
            curl && \
    cd /tmp && \
    curl https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O && \
    unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv && \
    cd /root/webdriverio-chrome/ && \
    yarn global add node-gyp && \
    yarn && \
    mkdir -p test/specs && \
    mv test-sample.js test/specs/ && \
    mkdir screenshots && \
    yarn global remove node-gyp && \
    rm -rf /root/.node-gyp && \
    rm -rf /tmp/* && \
    yarn cache clean && \
    apk del --purge make gcc g++ python curl

ENV DISPLAY :99

WORKDIR /root/webdriverio-chrome

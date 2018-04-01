#
# First Stage
#
FROM alpine:3.7 AS pre

ADD package.json wdio.conf.js yarn.lock /root/webdriverio-chrome/
ADD test-sample.js /root/webdriverio-chrome/test/specs/
RUN mkdir /root/webdriverio-chrome/screenshots

WORKDIR /tmp
RUN apk add --update make gcc g++ python curl yarn
RUN curl https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O
RUN unzip NotoSansCJKjp-hinted.zip

WORKDIR /root/webdriverio-chrome/
RUN yarn global add node-gyp
RUN yarn

#
# Second Stage
#
FROM alpine:3.7

COPY --from=pre /root/webdriverio-chrome/ /root/webdriverio-chrome/
COPY --from=pre /tmp/*.otf /usr/share/fonts/noto/

RUN apk add --no-cache \
            udev \
            ttf-freefont \
            chromium \
            chromium-chromedriver \
            openjdk8-jre \
            nodejs \
            yarn && \
    fc-cache -fv

WORKDIR /root/webdriverio-chrome

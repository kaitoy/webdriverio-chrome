#
# First Stage
#
FROM alpine:edge AS pre

ADD package.json yarn.lock /tmp/
WORKDIR /tmp

RUN apk add --update make gcc g++ python curl yarn
RUN curl https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O
RUN unzip NotoSansCJKjp-hinted.zip

RUN yarn global add node-gyp
RUN yarn

#
# Second Stage
#
FROM alpine:edge

ADD package.json wdio.conf.js yarn.lock /root/webdriverio-chrome/
ADD test-sample.js /root/webdriverio-chrome/test/specs/
COPY --from=pre /tmp/node_modules /root/webdriverio-chrome/node_modules/
COPY --from=pre /tmp/*.otf /usr/share/fonts/noto/

RUN apk add --update --no-cache \
            udev \
            ttf-freefont \
            chromium \
            chromium-chromedriver \
            openjdk8-jre \
            nodejs \
            yarn && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    fc-cache -fv && \
    mkdir /root/webdriverio-chrome/screenshots

WORKDIR /root/webdriverio-chrome

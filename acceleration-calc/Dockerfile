FROM node:8.11.3-alpine

RUN addgroup -S join-com && \ 
    adduser -S -D -h /opt/join-com -s /bin/false join-com && \
    chown -R join-com:join-com /opt/join-com && \
    chmod -R 755 /opt/join-com && \
    apk add curl

ENV APP_DIR=/opt/join-com
ENV WEB_PORT=3000

# Create app directory
WORKDIR $APP_DIR

USER join-com

# Setup configs and build dependencies
COPY . $APP_DIR


# Install app dependencies
RUN yarn install 

# Bundle app source
RUN yarn build

EXPOSE $WEB_PORT
CMD ["yarn", "start"]

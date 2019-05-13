FROM node:10.14.2-alpine

RUN addgroup -S join-com && \ 
    adduser -S -D -h /opt/join-com -s /bin/false join-com && \
    chown -R join-com:join-com /opt/join-com && \
    chmod -R 755 /opt/join-com

ENV APP_DIR=/opt/join-com
ENV WEB_PORT=3001

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

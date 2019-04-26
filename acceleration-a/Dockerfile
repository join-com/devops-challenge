FROM node:10.14.2-alpine

ENV WEB_PORT 3002
ENV RUNTIME_ENV dev

RUN addgroup -S nodeapp && \ 
    adduser -S -D -h /opt/nodeapp -s /bin/false nodeapp && \
    chown -R nodeapp:nodeapp /opt/nodeapp && \
    chmod -R 755 /opt/nodeapp

WORKDIR /opt/nodeapp

USER nodeapp

COPY . ./

RUN yarn install && \
    yarn build

EXPOSE ${WEB_PORT}

CMD ["sh", "-c", "yarn $RUNTIME_ENV"]
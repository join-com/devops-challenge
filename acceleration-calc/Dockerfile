FROM node:10.14.2-alpine

MAINTAINER Raisal PA

ENV APP_HOME=/app \
    WEB_PORT=3000

WORKDIR $APP_HOME

COPY . $APP_HOME

RUN adduser -D myapp && \
    yarn install && yarn build && chown -R myapp: $APP_HOME

USER myapp

EXPOSE $WEB_PORT

CMD yarn start

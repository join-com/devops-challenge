FROM node:10-jessie
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN yarn install
RUN yarn build
ENTRYPOINT ["/usr/local/bin/yarn"]



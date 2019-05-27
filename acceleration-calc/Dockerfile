FROM node:alpine

WORKDIR /app
ADD . /app
RUN yarn install && yarn build

ENTRYPOINT ["yarn", "start"]

EXPOSE 3000

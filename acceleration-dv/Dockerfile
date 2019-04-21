FROM node:8.6.0

ADD ./server /server

WORKDIR /acceleration-dv

EXPOSE 3001

RUN yarn install
RUN yarn
CMD ["yarn", "build"]
CMD ["yarn", "dev"]
CMD ["yarn", "start"]


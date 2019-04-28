FROM node:lts-alpine
WORKDIR /app
COPY . ./
ENV RUNENV=dev
EXPOSE 3002
RUN yarn install && yarn build
CMD yarn ${RUNENV}
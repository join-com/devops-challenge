FROM node:lts-alpine
WORKDIR /app
COPY . ./
ENV RUNENV=dev
EXPOSE 3001
RUN yarn install && yarn build
CMD yarn ${RUNENV}

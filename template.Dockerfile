FROM node:NODE_TAG
COPY . /app
WORKDIR /app
RUN yarn install && \
    yarn build
USER node
ENTRYPOINT ["yarn"]
CMD ["dev"]

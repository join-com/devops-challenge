FROM node:12-alpine

ENV ENVIRONMENT dev
ENV WEB_PORT 3000
ENV DV_URL http://accelerate-dv/dv
ENV A_URL http://accelerate-a:3002/a
COPY --chown=node:node package.json yarn.lock tsconfig.json /app/
COPY --chown=node:node server/index.ts /app/server/index.ts
WORKDIR /app
USER node
RUN yarn install && \
    yarn build

EXPOSE ${WEB_PORT}
CMD yarn ${ENVIRONMENT}

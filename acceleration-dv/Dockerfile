ARG NODE_VERSION

### [stage 1] - package
FROM node:${NODE_VERSION}-alpine as prod_base
WORKDIR /app/

# install runtime dependencies
RUN apk add --no-cache tini

# install runtime npm packages
COPY package.json yarn.lock  ./
RUN yarn install --production

### [stage 2] - build app (typescript)
FROM prod_base as builder

# install npm packages from devDependencies (required for build)
RUN yarn install

COPY tsconfig.json .
COPY server/ server/
RUN yarn build

### [stage 3] - package code
FROM prod_base

COPY --from=builder /app/dist/ dist/

CMD ["yarn", "start"]
ENTRYPOINT ["/sbin/tini", "--"]

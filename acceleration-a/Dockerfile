# Create a multi-stage build to reduce the size of the final image
FROM node:10.14.2-jessie as builder
WORKDIR /app
COPY package*.json ./
COPY tsconfig*.json ./
COPY server server
RUN yarn install && yarn build

FROM node:10.14.2-jessie
WORKDIR /app
COPY package*.json ./
# esto es portable
ENV WEB_PORT=3005
RUN yarn install --production
COPY --from=builder /app/dist dist
CMD ["yarn", "start"]
# para buildear la imagen
# docker build -t acceleration-a:v1.0.0 .
# formas de correrlo
# docker run --env WEB_PORT=3003 acceleration-a:v1.0.0
# docker run --env-file .env acceleration-a:v1.0.0
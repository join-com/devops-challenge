FROM node:10.14.2-slim

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Install app dependencies
COPY package.json /app
COPY yarn.lock /app
RUN yarn install

# Bundle app source
COPY . /app
RUN yarn build

# Exposed port for acceleration-a
EXPOSE 3002
CMD [ "yarn", "start" ]

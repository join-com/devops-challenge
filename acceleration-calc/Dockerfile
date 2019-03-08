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

# Exposed port for acceleration-calc
EXPOSE 3000
CMD [ "yarn", "start" ]

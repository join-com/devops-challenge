FROM node:10.14.2-slim
ADD . /app
WORKDIR "/app"
RUN /usr/local/bin/yarn install && /usr/local/bin/yarn build
EXPOSE 3000
CMD /usr/local/bin/yarn run start

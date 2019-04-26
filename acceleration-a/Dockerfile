FROM node
ENV WEB_PORT 3002

RUN useradd -rm -d /var/lib/acceleration-a -s /bin/false -u 999 nodeapp && \
    chown -R nodeapp:nodeapp /var/lib/acceleration-a && chmod -R 755 /var/lib/acceleration-a

WORKDIR /var/lib/acceleration-a
EXPOSE 3002
USER nodeapp

COPY *.json yarn.lock ./
COPY server ./server/
RUN yarn install && yarn build

ENTRYPOINT ["yarn"]
CMD ["dev"]


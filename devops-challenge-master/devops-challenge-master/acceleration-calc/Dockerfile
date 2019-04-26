FROM node

ENV WEB_PORT 3000

RUN useradd -rm -d /var/lib/acceleration-calc -s /bin/false -u 999 nodeapp && \
    chown -R nodeapp:nodeapp /var/lib/acceleration-calc && chmod -R 755 /var/lib/acceleration-calc

WORKDIR /var/lib/acceleration-calc
EXPOSE 3000
USER nodeapp

COPY *.json yarn.lock ./
COPY server ./server/
RUN yarn install && yarn build

ENTRYPOINT ["yarn"]
CMD ["dev"]

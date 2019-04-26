FROM node
ENV WEB_PORT 3001

RUN useradd -rm -d /var/lib/acceleration-dv -s /bin/false -u 999 nodeapp && \
    chown -R nodeapp:nodeapp /var/lib/acceleration-dv && chmod -R 755 /var/lib/acceleration-dv

WORKDIR /var/lib/acceleration-dv
EXPOSE 3001
USER nodeapp

COPY *.json yarn.lock ./
COPY server ./server/
RUN yarn install && yarn build

ENTRYPOINT ["yarn"]
CMD ["dev"]


FROM node:18-alpine

WORKDIR /app

# Install necessary packages
RUN apk update && apk add --no-cache wget bash

ARG UUID
ENV UUID=${UUID}
ENV NODE_ENV=production
ENV PORT=4100

COPY dist dist/
COPY start.sh start.sh

RUN chmod +x start.sh

CMD [ "bash", "start.sh" ]
# CMD [ "node", "./dist/apps/node-vl/main.js" ]

EXPOSE 4100

FROM node:18-alpine

WORKDIR /app

# Install necessary packages
RUN apk update && apk add --no-cache wget bash

# Download and install cloudflared
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared \
    && chmod +x cloudflared \
    && mv cloudflared /usr/bin/

ARG UUID
ARG CLOUDFLARE_TUNNEL_TOKEN
ENV NODE_ENV=production
ENV PORT=4100
ENV UUID=${UUID}
ENV CLOUDFLARE_TUNNEL_TOKEN=${CLOUDFLARE_TUNNEL_TOKEN}

COPY dist dist/
COPY start.sh start.sh

RUN chmod +x start.sh

CMD [ "bash", "start.sh" ]
# CMD [ "node", "./dist/apps/node-vl/main.js" ]

EXPOSE 4100

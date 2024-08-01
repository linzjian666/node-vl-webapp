FROM node:18-alpine

WORKDIR /app

# Install necessary packages
RUN apk update && apk add --no-cache wget bash

# Download and install cloudflared
RUN echo 'aHR0cHM6Ly9naXRodWIuY29tL2Nsb3VkZmxhcmUvY2xvdWRmbGFyZWQvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL2Nsb3VkZmxhcmVkLWxpbnV4LWFtZDY0' | base64 -d \
    | wget -q -O cloudflared - \
    && chmod +x cloudflared \
    && mv cloudflared /usr/bin/

ENV NODE_ENV=production
ENV PORT=4100

COPY dist dist/
COPY start.sh start.sh

RUN chmod +x start.sh

CMD [ "bash", "start.sh" ]
# CMD [ "node", "./dist/apps/node-vl/main.js" ]

EXPOSE 4100

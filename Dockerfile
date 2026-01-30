FROM node:18.18.0

COPY ./app /app

WORKDIR /app

RUN npm install

CMD ["npm", "run", "host"]

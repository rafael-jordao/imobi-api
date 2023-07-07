FROM node:18-alpine

WORKDIR /usr/app

COPY package*.json ./
COPY yarn.lock ./
RUN yarn install

COPY . .

EXPOSE 3000

CMD ["yarn", "run", "start:dev"]
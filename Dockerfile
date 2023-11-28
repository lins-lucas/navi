FROM node:21 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . ./
RUN npm run build

FROM node:21-alpine3.17

WORKDIR /app

COPY --from=build /app/dist ./dist

EXPOSE 3000

CMD [ "node", "dist/index.js" ]
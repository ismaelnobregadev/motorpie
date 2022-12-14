FROM node:15.13-alpine as build
WORKDIR /app

ENV PATH="./node_modules/.bin:$PATH"


COPY package.json /app/package.json

RUN yarn

COPY . /app

RUN yarn build

FROM nginxinc/nginx-unprivileged
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

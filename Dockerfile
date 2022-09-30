FROM node:15.13-alpine as build
WORKDIR /app

ENV PATH="./node_modules/.bin:$PATH"


COPY package.json /app/package.json

RUN yarn

COPY . /app

RUN yarn build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

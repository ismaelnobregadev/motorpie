FROM node:15.13-alpine
WORKDIR /app

ENV PATH="./node_modules/.bin:$PATH"


COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json

RUN yarn

COPY . /app

RUN yarn build


FROM nginx:1.16.0-alpine as build
COPY --from=build /usr/share/nginx/html .

COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80
CMD [“nginx”, “-g”, “daemon off;”]

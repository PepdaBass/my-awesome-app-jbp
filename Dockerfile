FROM node:10 as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY ./ ./
RUN npm run build


FROM nginx:10 as prod
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
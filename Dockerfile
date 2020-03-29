FROM nginx:1.15.5
## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY /dist/windfire-restaurants-ui /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
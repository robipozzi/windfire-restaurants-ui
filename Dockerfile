FROM nginx:1.15.5
LABEL author="Roberto Pozzi"
ENV APPLICATION_DIR="/usr/share/nginx/html"
RUN chgrp -R 0 /var/log/nginx /var/run /var/cache && \
    chmod -R g=u /var/log/nginx /var/run /var/cache
# OpenShift - users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/conf.d/default.conf
EXPOSE 8080
# OpenShift - comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
## Remove default nginx website
RUN rm -rf $APPLICATION_DIR/*
## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY /dist/windfire-restaurants-ui $APPLICATION_DIR
CMD ["nginx", "-g", "daemon off;"]
#CMD ["/bin/sh",  "-c",  "envsubst < /usr/share/nginx/html/assets/config/env.template.js > /usr/share/nginx/html/assets/config/env.js && exec nginx -g 'daemon off;'"]
FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add apache2
RUN echo '<h1>Hello world<h1>' \ > /var/www/localhost/htdocs/index.html

# open port 80
EXPOSE 80

CMD ["-D","FOREGROUND"]

#start apache when container runs
ENTRYPOINT ["/usr/sbin/httpd"]
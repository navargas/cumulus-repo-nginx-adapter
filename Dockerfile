FROM nginx:1.9.5
RUN apt-get update -y && apt-get install curl nodejs npm -y
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install forever -g
ADD cumulus-repo /root/
RUN cd /root/ && npm install
ADD nginx.conf /etc/nginx/nginx.conf
ENV serverport 9092
ENV nginxserv yes

WORKDIR /root
CMD ["bash", "-c", "forever app.js NO_MIRRORS & nginx -g \"daemon off;\""]

FROM debian:buster

RUN apt-get update && apt-get install -y \
    redis-server

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf

RUN echo "maxmemory 256mb" >> /etc/redis/redis.conf 
RUN echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf
EXPOSE 6379

CMD [ "redis-server", "--protected-mode", "no" ]
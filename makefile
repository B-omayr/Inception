build:
	mkdir -p /Users/iomayr/Desktop/data/mysql
	mkdir -p /Users/iomayr/Desktop/data/wordpress
	docker-compose -f srcs/docker-compose.yml up --build

stop:
	docker-compose -f srcs/docker-compose.yml down

up:
	docker-compose -f srcs/docker-compose.yml up

clean:
	rm -rf /Users/iomayr/Desktop/data
	docker-compose -f srcs/docker-compose.yml down -v

all: clean build

.PHONY: all clean build stop up
build:
	mkdir -p /Users/iomayr/data/mysql
	mkdir -p /Users/iomayr/data/wordpress
	docker-compose -f srcs/docker-compose.yml up --build

stop:
	docker-compose -f srcs/docker-compose.yml down

up:
	docker-compose -f srcs/docker-compose.yml up

clean:
	rm -rf /Users/iomayr/data
	docker-compose -f srcs/docker-compose.yml down -v

fclean:
	docker-compose -f srcs/docker-compose.yml system prune -af

all: clean build

.PHONY: all clean build stop up
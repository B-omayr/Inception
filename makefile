build:
	mkdir -p /home/iomayr/data/mysql
	mkdir -p /home/iomayr/data/wordpress
	docker-compose -f srcs/docker-compose.yml up --build

stop:
	docker-compose -f srcs/docker-compose.yml down

up:
	docker-compose -f srcs/docker-compose.yml up

clean:
	echo "Temporary1337@@@" | sudo -S rm -rf /home/iomayr/data;
	docker-compose -f srcs/docker-compose.yml down -v

fclean:
	docker system prune -a

all: clean build

.PHONY: all clean build stop up

DOCKER_COMPOSE = ./srcs/docker-compose.yml
DATA_PATH = /home/pbureera/data

all: up

up:
	@sudo mkdir -p $(DATA_PATH)/html
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo docker-compose -f $(DOCKER_COMPOSE) up -d

stop:
	@sudo docker-compose -f $(DOCKER_COMPOSE) stop

# down stops and removes the containers 
# -v removes any volumes associated with the containers being stopped and removed
down:
	@sudo docker-compose -f $(DOCKER_COMPOSE) down -v

clean: down
	@sudo docker system prune -af

remove_data:
	@sudo rm -rf $(DATA_PATH)

re: clean up

.PHONY: all up stop remove_data down clean re
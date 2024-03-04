DOCKER_COMPOSE = ./srcs/docker-compose.yml
DATA_PATH = /home/pbureera/data

all: up

up:
	@sudo mkdir -p $(DATA_PATH)/html
	@sudo mkdir -p $(DATA_PATH)/mysql
	@sudo docker-compose -f $(DOCKER_COMPOSE) up -d --build
# -f specifies the location of the YAML file that defines the services, networks and volumes
# up - start and run Docker containers defined in YAML file
# -d detached mode (in the background)
# if image already exists locally, will not rebuild, just start the container
# if no image, will build images for services 

stop:
	@sudo docker-compose -f $(DOCKER_COMPOSE) stop

down:
	@sudo docker-compose -f $(DOCKER_COMPOSE) down -v

clean: down
	@sudo docker system prune --all --volumes --force
# Remove unused containers, networks, images and volumes
# Doesnt affect the data stored within the containers

fclean:
	docker stop $$(docker ps -qa);
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q); \
	@sudo rm -rf $(DATA_PATH)
# docker stop $$(docker ps -qa): stops all running containers
# docker rm $$(docker ps -qa): removes all stopped containers
# docker rmi -f $$(docker images -qa): force removes all images
# docker volume rm $$(docker volume ls -q): removes all volumes
# docker network rm $$(docker network ls -q): removes all networks

re: fclean all

.PHONY: all up stop down clean fclean re
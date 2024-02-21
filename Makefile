LOGIN = pbureera
DATADIR = /home/${LOGIN}/data
VOLWORDPRESS = ${DATADIR}/wordpress
VOLMARIADB = ${DATADIR}/mariadb
DOCKERCOMPOSE = srcs/docker-compose.yml
UPFLAG = --detach
DOWNFLAG = --volumes --rmi all

all: build

${VOLWORDPRESS}:
	@sudo mkdir -p ${VOLWORDPRESS}

${VOLMARIADB}:
	@sudo mkdir -p ${VOLMARIADB}

build: | ${VOLWORDPRESS} ${VOLMARIADB}
	@docker compose -f ${DOCKERCOMPOSE} up --build ${UPFLAG}

up: | ${VOLWORDPRESS} ${VOLMARIADB}
	@docker compose -f ${DOCKERCOMPOSE} up ${UPFLAG}

start: | ${VOLWORDPRESS} ${VOLMARIADB}
	@docker compose -f ${DOCKERCOMPOSE} start

stop:
	@docker compose -f ${DOCKERCOMPOSE} stop

down:
	@docker compose -f ${DOCKERCOMPOSE} down

clean: down
	@printf "Purge configuration ${name}...\n"
	@docker system prune -a
fclean:
	@printf "Full cleanup of all docker configurations\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker volume rm $$(docker volume ls -q)
	@docker network prune --force
	@docker volume prune --force

re: fclean all

.PHONY: all build up start stop down clean prune fclean re
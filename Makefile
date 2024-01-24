DATA_DIR :=  $(HOME)/data
WORDPRESS_DIR := $(DATA_DIR)/wordpress
DB_DIR := $(DATA_DIR)/db

ifeq ($(OS), linux)
	sudo := sudo
else
	sudo :=""
endif

create-dirs:
	@mkdir -p $(DATA_DIR)
	@mkdir -p $(WORDPRESS_DIR)
	@mkdir -p $(DB_DIR)

up: create-dirs
	@docker-compose -f ./srcs/docker-compose.yaml up --build -d

start: create-dirs
	@docker-compose -f ./srcs/docker-compose.yaml start

stop:
	@docker-compose -f ./srcs/docker-compose.yaml stop

down:
	@docker-compose -f ./srcs/docker-compose.yaml down

clean:
	@docker-compose -f ./srcs/docker-compose.yaml down -v
clean-images: clean
	@images=$$(docker images -q); \
	if [ -n "$$images" ]; then \
	    docker rmi $$images; \
	fi

fclean: clean-images
	@$(sudo) rm -rf $(HOME)/data/

prune: fclean
	@docker system prune -af --volumes

.PHONY: clean fclean down up prune clean-images

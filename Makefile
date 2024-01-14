
start:
	docker-compose -f docker-compose.yaml start

stop:
	docker-compose -f docker-compose.yaml stop

up:
	docker-compose -f docker-compose.yaml up --build

down:
	docker-compose -f docker-compose.yaml down

clean:
	docker-compose -f docker-compose.yaml down -v

clean-images: clean
	@images=$$(docker images -q); \
	if [ -n "$$images" ]; then \
	    docker rmi $$images; \
	fi

fclean: clean-images
	rm -rf ./data_db/* -y
	rm -rf ./data/* -y

prune: fclean
	docker system prune -af --volumes

.PHONY: clean fclean down up prune clean-images
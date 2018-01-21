NODE_IMAGE := node:carbon
FRONT_DIR := $(realpath .)

node_modules: package.json
	docker run --rm --user $$(id -u) -it -v "$(FRONT_DIR):/app" -w /app $(NODE_IMAGE) npm install --no-optional

dev: node_modules
	docker run --rm  -itp 8080:8080 -v "$(FRONT_DIR):/app" -w /app $(NODE_IMAGE) npm run dev

dist: node_modules src
	docker run --rm --user $$(id -u) -it -v "$(FRONT_DIR):/app" -w /app $(NODE_IMAGE) npm run build

clean:
	rm -rf node_modules dist

ORG     := turdusmerula
APP     := partkeepr
NAME    := $(ORG)/$(APP)

.PHONY: all build tag push list run test inspect stop rm

all: run

build:
	@scripts/build

tag: build
	@scripts/tag
	
push: tag
	docker push $(NAME)

list:
	docker images $(NAME)

run: build
	docker run -d -p 22 -p 80:80 --name $(APP) $(NAME):$(VERSION)

stop:
	docker stop $(APP)

rm:
	docker rm $(APP)

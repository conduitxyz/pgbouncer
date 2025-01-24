IMAGE_NAME=innovative/pgbouncer
IMAGE_VERSION=innovative-1.24.0.innovative

podman-x86:
	podman buildx build \
		--platform linux/amd64 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) \
		-f ./Dockerfile \
		--load \
		.

# to build arm64 on amd64
# sudo apt install -y qemu-user-static binfmt-support && podman buildx create --use
podman-arm:
	podman buildx build \
		--platform linux/arm64 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) \
		-f ./Dockerfile \
		--load \
		.

push:
	podman buildx build \
		--platform linux/arm64,linux/amd64 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) \
		-f ./Dockerfile \
		--push \
		.

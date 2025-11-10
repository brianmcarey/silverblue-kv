FROM quay.io/kubevirtci/bootstrap:v20251022-6eb3ab1

RUN dnf update -y && \
	dnf -y install vim neovim golang htop kubernetes-client

RUN mkdir -p /silverblue-kv

COPY ./config/podman.json /etc/containers/networks/podman.json

COPY ./config/containers.conf /etc/containers/containers.conf

COPY ./scripts/prepare_env.sh /silverblue-kv/

ENTRYPOINT /silverblue-kv/prepare_env.sh

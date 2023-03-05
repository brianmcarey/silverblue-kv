# silverblue-kv

Scripts to set up an ephemeral Kubevirt development environment on Fedora Silverblue or any other distro that has podman installed. This enviroment also includes a podman in podman setup which allows the user to run any containerized development flows.

These scripts require `sudo` privileges so please take some time to read them.

## Usage

There are two main scripts, one that brings up the development environment (up.sh) and another which cleans up the bits and pieces once you're done (down.sh).

The `up.sh` script takes the full path to your working directory:
```
./up.sh /home/user/workspace/kubevirt
```

To clean up:
```
./down.sh
```

If you want to persist any of the data used by the podman in podman instance:
```
./up.sh -p /home/user/workspace/kubevirt
```

To clean up the environment with the peristent podman data volume:
```
./down.sh -d
```

## Custom Image

The image is built using the `Containerfile` and is based on the [bootstrap image](https://github.com/kubevirt/project-infra/tree/main/images/bootstrap) used by KubeVirt CI. Some of the podman in podman configuration is located under the config directory. To build a custom image with your modifications to the Containerfile run the following:
```
sudo podman build -t quay.io/bcarey1/silverblue-kv:latest .
```

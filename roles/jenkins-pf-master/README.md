# jenkins-master ansible role

## Description
This role is used to create the jenkins-master AMI.

It only installs jdk8 and git.

NOTE: The name of the folder mounted in the docker container must be the same as the ansible role name - unfortunately seems to be a limitation on the kitchen-ansible gem.

## Patched kitchen-docker gem
In order to allow our jenkins slaves to run `kitchen test` for ansible CI, we needed to use a patched version of the kitchen-docker gem.

By default the kitchen-docker gem does not allow overriding of the docker container IP to allow kitchen to ssh to the container and run ansible.

That would be fine on a normal VM as kitchen can use docker0 to ssh into the container.

However it cannot use docker0 inside the container, so we have to tell kitchen what the container's IP is at runtime.

That functionality is not there by default until this MR is merged: https://github.com/test-kitchen/kitchen-docker/pull/283#issuecomment-364151453

Until then, we manually pull down that branch, build the gem and install it in this docker image.

NOTE: `kitchen test` will not work on mac due to this workaround due to the way networking works in docker for mac.

If you want to build locally, you can run this container to execute kitchen test or locally you can still use the original kitchen-docker gem and remove `use_internal_docker_network: true` from your kitchen.yml. (Be sure not to commit this as it will break CI.)

## Building the container
To build the container just clone the repo and run :
```
make build
```

To push to docker registry :
```
make push
```

## Tips
- If your commit message contains : `skip-build`, build will not occur.

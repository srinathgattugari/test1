JaaC - Jenkins2 as a Code - Jenkins-pf-master Ansible role
===================================================================================
## Description
The <strong>JaaC</strong> container running with customized Jenkins2 docker image **[jenkins-pf](https://gitlab.deveng.systems/Devops/docker-images/jenkins-pf)** is managed as a systemd unit daemon service named as `jenkins-pf.service` which in turn is created by this ansible role.

## Important files
Below are the important files which are required by this role to setup Jenkins systemd unit daemon service in a Jenkins master server:-
- <strong>`./files/override.j2`</strong>: This jinja2 template file list down all the environment variables that needs to be used by the `jenkins-pf.service` file to manage the Jenkins master container.
- <strong>`./files/jenkins-pf.service`</strong>: The systemd unit service file to run Jenkins as a daemon service in the Jenkins master server. The variables used in this file is set by override.conf file deployed in `jenkins-pf.service.d` directory.
- <strong>`./vars/ldap.yml`</strong>: Contains the encrypted value of LDAP password.

## Customizing override.j2 file
The `override.j2` file can be customized for setting up a new Jenkins instance running as a systemd daemon service. The below variables needs to be updated with their values before running this ansible role:-
- <strong>`ENV`</strong>: This can be either `sandbox`, `non-production` or `production`.
- <strong>`JAVA_OPTS`</strong>: Only update the `-Dhttp.proxyHost` and `-Dhttps.proxyHost` IP addresses which is actually the IP of Jenkins master server.
- <strong>`JENKINS_HOST_PORT`</strong>: Host port to map with Jenkins master server port in the container.
- <strong>`JENKINS_JNLP_HOST_PORT`</strong>: Host port to map with Jenkins master server port for JNLP slave connection in the container.
- <strong>`JENKINS_HOME_DIR`</strong>: Dedicated mountpoint for Jenkins home directory to bind volume it with the container.
- <strong>`JENKINS_IMAGE_NAME`</strong>: Docker Image name built using this repo.
- <strong>`JENKINS_IMAGE_VER`</strong>: Docker Image version built using this repo.
- <strong>`URL_SEED_JOBS_REPO`</strong>: Gitlab SSH URL which is storing all the seed-jobs for pipelines.

After updating the override.j2, run below command to startup the container:-
```
# ansible-playbook tasks/main.yml --ask-vault-pass
```
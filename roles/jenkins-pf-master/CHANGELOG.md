# Changelog
All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.4.16] 2019-05-24
## Added
- PAAS-1260 : Jenkins filesystem cleanup script.

## [0.4.15] 2019-05-08
## Added
- PAAS-1339 : Added Datadog API Key Parameter in service file for Datadog Jenkins Plugin.

## [0.4.14] 2019-01-30
## Added
- PAAS-953 : Added Parameter for Jira Steps plugin Configuration in service file.

## [0.4.13] 2018-11-29
## Added
- PAAS-593 : Added Parameters for Allure plugin Configuration in service file.

## [0.4.12] 2018-11-15
## Added
- PAAS-136 : Added Parameters for Gitlab plugin Configuration in service file.

## [0.4.11] 2018-10-24
## Added
- PAAS-40 : Added the variables for SMTP configuration in jenkins and updated the git client version

## [0.4.10] 2018-08-21
## Added
- DEVSUPPORT-11932 : Sonar auth token added 

## [0.4.9] 2018-08-20
## Added
- Added a variable to configure the number of maximum running slaves instances.

## [0.4.8] 2018-08-17
## Fixed
- Fixed unit test.

## [0.4.7] 2018-08-17
## Updated
- DEVENV-5108: As part of DEVENV-5108 removed secret file for ldap password.

## [0.4.6] 2018-08-16
## Added
- DEVSUPPORT-11932 : java minor version upgraded.  

## [0.4.5] 2018-08-01
## Added
- DEVENV-4770 : Sonar plugin configuration

## [0.4.4] - 2018-07-31
## Added
- DEVSUPPORT-11604 : Added support to configure the number of executors on each slave.

## [0.4.3] - 2018-07-26
## Added
- Devenv-4998 : Added support for slave disks configuration

## [0.4.2] - 2018-07-06
## Added
- DEVENV-3749 : Added `LDAP_CONFIG_LOCATION` variable to set ldap config file location.

## [0.4.1] - 2018-07-05
## Added
- DEVENV-4679 : Added new variables to manage new high cpu/mem slaves.

## [0.4.0] - 2018-06-22
## Added
- DEVENV-4708 : Use env-file (/etc/jenkins.secrets) for secrets so they're not logged

## [0.3.0] - 2018-06-20
## Update
- DEVENV-4692 : Jenkins and git version modified.

## [0.2.0] - 2018-03-02
### Added
- DEVENV-3619 : Add step to copy service file

## [0.1.0] - 2018-02-26
### Added
- Init semantic versioning.
- DEVENV-3538 : Create Versioning strategy for ansible roles

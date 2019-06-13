#!/usr/bin/env bash

set -o errexit

function set_logging {
  FILENAME=$(basename $0)
  LOG_FILE=${LOG_FILE:-"/dev/null"}
  VERBOSITY=${VERBOSITY:-"1"}
}

function debug {
  [[ ${VERBOSITY} -ge 2 ]] && echo "$(date +%Y-%m-%d:%H:%M:%S) [DEBUG] $@" || true
  [[ ${VERBOSITY} -ge 2 ]] && echo "$(date +%Y-%m-%d:%H:%M:%S) [DEBUG] $@" >> ${LOG_FILE} || true
  [[ ${VERBOSITY} -ge 2 ]] && echo "$(date +%Y-%m-%d:%H:%M:%S) [DEBUG] $@" | systemd-cat -p debug -t ${FILENAME} || true
}

function log {
  [[ ${VERBOSITY} -ge 1 ]] && echo "$(date +%Y-%m-%d:%H:%M:%S) [INFO] $@" || true
  [[ ${VERBOSITY} -ge 1 ]] && echo "$(date +%Y-%m-%d:%H:%M:%S) [INFO] $@" >> ${LOG_FILE} || true
  [[ ${VERBOSITY} -ge 1 ]] && echo "$(date +%Y-%m-%d:%H:%M:%S) [INFO] $@" | systemd-cat -p info -t ${FILENAME} || true
}

function error {
  echo "$(date +%Y-%m-%d:%H:%M:%S) [ERROR] $1" >&2
  echo "$(date +%Y-%m-%d:%H:%M:%S) [ERROR] $@" >> ${LOG_FILE} || true
  echo "$(date +%Y-%m-%d:%H:%M:%S) [ERROR] $1" | systemd-cat -p err -t ${FILENAME}
  exit ${2:-"1"}
}

function delete_workspace {
  log "Checking the workspace folder which is older than 30 days"
  find /data/jenkins-home/workspace -mtime +30 -prune -exec rm -rf {} + || error "Workspace folder deletion is not succeeded" $?
  debug "Workspace folders older than 30 days are deleted"
}

function delete_builds {
  log "Checking the latest 30 jenkins build and delete the rest "
  for job in /data/jenkins-home/jobs/*/; do
    if [ -d "${job}"branches ] && ls -l "${job}"branches/ | grep -q '^d'; then
      for branch in "${job}"branches/*/; do
        if  [ -d "${branch}"builds ] && [ -z "$(xmlstarlet sel -t -v "flow-definition/properties/jenkins.model.BuildDiscarderProperty/strategy/numToKeep" "${job}"config.xml 2>/dev/null)" ] && ls -l "${branch}"builds/ | grep -q '^d' ; then
          ls -dt "${branch}"builds/*/ | tail -n +31 | xargs rm -rf -- || error "Jenkins old builds deletion is not succeeded" $?
        fi
      done
    elif [ -d "${job}"builds ] && [ -z "$(xmlstarlet sel -t -v "flow-definition/properties/jenkins.model.BuildDiscarderProperty/strategy/numToKeep" "${job}"config.xml 2>/dev/null)" ] && ls -l "${branch}"builds/ | grep -q '^d' ; then
      ls -dt "${job}"builds/*/ | tail -n +31 | xargs rm -rf -- || error "Jenkins old builds deletion is not succeeded" $?
    fi
  done
  debug "Jenkins builds older than 30 days are deleted"
}

function delete_dead_branches {
  log "Deleting all the dead branches older than 7 days"
  for job in /data/jenkins-home/jobs/*/; do
    if [ -d "${job}"branches ] && [ "$(xmlstarlet sel -t -v "org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject/orphanedItemStrategy/daysToKeep" "${job}"/config.xml 2>/dev/null)" == "-1" ] && ls -l "${job}"branches/ | grep -q '^d' ; then
      for branch in "${job}"branches/*/; do
        if [ "$(xmlstarlet sel -t -v "flow-definition/disabled" "${branch}"config.xml 2>/dev/null)" == "true" ]; then
          find ${branch} -mtime +7 -prune -exec rm -rf {} + || error "Git branch deletion in jenkins job is not succeeded" $?
        fi
      done
    fi
  done
  debug "Deleted all the dead branches older than 7 days"
}


set_logging
delete_workspace
delete_builds
delete_dead_branches

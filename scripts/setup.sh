#!/bin/bash

set -e

version="v1.25"
target="v1.25.2"
# this will be the branch we use to generate carry commits
branch="rebase-${target}"

if git show-ref --verify --quiet refs/heads/${branch}; then
  echo "branch [${branch}] already exists"
  exit 1
fi

git checkout master
git fetch k8s-upstream
git fetch ocp-upstream

git checkout -b ${branch} ${target}
git merge -s ours -m "Merge remote-tracking branch 'openshift/master' into ${branch} openshift-rebase(${version}):marker"  ocp-upstream/master

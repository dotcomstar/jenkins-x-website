#!/bin/bash

if [ -z "$GITHUB_ACTIONS" ]
then
  echo "not setting up git as not in a GitHub Action"
else
  echo "lets setup git"
  git config user.name github-actions
  git config user.email github-actions@github.com
fi

git clone https://github.com/jenkins-x/jx-api

cp jx-api/schema/core.jenkins-x.io/v4beta1/requirements.json schemas/requirements.json
rm -rf jx-api

if [ -z "$DISABLE_COMMIT" ]
then
    echo "adding latest schema"
    git add schemas
    git commit -a -m "chore: regenerated schema docs"
    git push
else
    echo "disabled commiting changes"
fi

echo "complete"

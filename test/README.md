# Webrouter Unit testing

This directory contains files for running unit tests on the base image.  These tests are run at build time; failing tests will halt the image from being published.

## Run locally

To run these tests locally, build an image from the main Dockerfile and tag it as `validate-router` like so:

```bash
docker build --tag "validate-router" .
```

The "validate-router" tag is what the `validate.yml` compose setup uses to refer to the image it will test.  Once the image has been built and tagged with the right label, the tests can be run with this command:

```bash
docker-compose -f validate.yml up
```

This launches a webrouter container, and additional containers that run the unit tests.  These commands should be run from the root directory of the repo.  If the test container exits with a status code of 0, then the tests pass.

## CI/CD Pipeline

These tests are run as part of the CodeBuild process that builds and pushes new images to Docker Hub.  The CodeBuild process is running in the `web2cloud-nonprod` account.  It uses a buildspec in the CodeBuild definition that looks like this:

```yml
version: 0.2
phases:
  pre_build:
    commands:
      - docker login -u "$builduser" -p "$buildpw"
  build:
    commands:
      - BUILDDATE=$(cat BUILDDATE.DAT)
      - echo "$BUILDDATE"
      - IMAGEURI="${IMAGEBASE}:$BUILDDATE"
      - docker build  --tag "$IMAGEURI" .
      - docker tag "$IMAGEURI" "validate-router"
      - docker-compose -f validate.yml up --abort-on-container-exit 
      - docker push "$IMAGEURI"
      - docker tag "$IMAGEURI" "${IMAGEBASE}:latest"
      - docker push "${IMAGEBASE}:latest"
  post_build:
    commands:
      - printf '[{"name":"bu-webrouter", "imageUri":"%s"}]' "$IMAGEURI" >basebuild.json 
artifacts:
  files: basebuild.json
```

## Test suite components

The testing setup described in `validate.yml` consists of 3 containers: `test-backend`, `sut`, and `bufe-autotest-test`

### bufe-autotest-test

This is the webrouter container, built with the "validate-router" tag.

### test-backend

This container mocks the response of an app server that the webrouter container is routing to.

### sut

This container runs the unit tests, using `curl` to connect to the webrouter container and evaluating the responses.

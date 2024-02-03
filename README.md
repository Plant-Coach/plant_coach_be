Please visit the main README [here](https://github.com/Plant-Coach) on the project's main page.

## Using Docker

Docker Compose
- `version` is only informative.
  - therefore the schema used is not from `version` but the most recent version isntead.
  -

Name Element
- name
```yaml
services:
  foo:
    image: busybox
    environment:
      - COMPOSE_PROJECT_NAME
    command: echo "I'm running ${COMPOSE_PROJECT_NAME}"
```

Services is a mandatory top-level definition
- includes the names and service definitions.
- each service defines runtime constratints and requirements to run its containers.
Attach
- when attach
- The `deploy` section gr
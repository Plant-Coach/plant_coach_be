Please visit the main README [here](https://github.com/Plant-Coach) on the project's main page.

## Docker Instructions:

`docker compose up`

`docker build . -t jmgrant/plant-coach-be:amd64-6 --platform linux/amd64`

## Pipelines
- Uses GitHub Actions

### Build and Test
- Validates the Rails application runs
- Lints the code 
- Verifies dependencies for known vulnerabilities
- Reviews code quality issues.

### Build and Push
- Builds the container image.
- Pushes the container image to DockerHub.
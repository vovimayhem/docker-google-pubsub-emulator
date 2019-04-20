# Google Cloud PubSub Emulator for Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/vovimayhem/google-pubsub-emulator.svg)](https://hub.docker.com/r/vovimayhem/google-pubsub-emulator)
[![Docker Build Status](https://img.shields.io/docker/build/vovimayhem/google-pubsub-emulator.svg)](https://hub.docker.com/r/vovimayhem/google-pubsub-emulator)
[![Docker Automated Build](https://img.shields.io/docker/cloud/automated/vovimayhem/google-pubsub-emulator.svg)](https://hub.docker.com/r/vovimayhem/google-pubsub-emulator)

This is the Docker image for the [Google Cloud PubSub Emulator](https://cloud.google.com/pubsub/docs/emulator)

## Basic Usage

This command will download the image if it isn't present, and start the
emulator, making it available at localhost:8085:

```bash
docker run -p 8085:8085 vovimayhem/google-pubsub-emulator
```

## Advanced Usage

### Data volume

This image accepts mounting a volume for the emulator to store data. Inside the
pubsub, the emulator expects the data to be available at `/data`:

```bash
docker run -p 8085:8085 -v /tmp/data:/data vovimayhem/google-pubsub-emulator
```

### Docker Compose

You can also use it on your `docker-compose.yml` file. Notice the env variable
`PUBSUB_EMULATOR_HOST` on the app service to configure the client so it points
to the emulator:

```yaml
version: "2.4"

volumes:
  pubsub_data:

services:
  pubsub:
    image: vovimayhem/google-pubsub-emulator:latest
    ports:
    - ${PUBSUB_PORT:-8085}:8085
    volumes:
    - pubsub_data:/data
  app:
    # Some lines ommitted
    environment:
      PUBSUB_EMULATOR_HOST: pubsub:8085
```

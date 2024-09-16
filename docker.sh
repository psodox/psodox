#!/usr/bin/env bash

# Docker and Docker Compose aliases
d() {
  docker "$@"
}

dc() {
  docker-compose "$@"
}

install() {

}

"$@"
}
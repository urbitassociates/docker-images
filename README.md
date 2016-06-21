Urb-it Docker Images
====================

These are Urb-it's Docker images, used mainly for internal development.

## Docker Snippets
Useful snippets for cleanups etc.

#### Stop all containers
```
docker stop $(docker ps -a -q)
```
```
docker ps -a -q | xargs docker stop
```

#### Remove all containers
```
docker rm $(docker ps -a -q)
```
```
docker ps -a -q | xargs docker rm
```

#### Remove all images
```
docker rmi $(docker images -q)
```
```
docker images -q | xargs docker rmi
```

#### Remove orphaned volumes
```
docker volume rm $(docker volume ls -qf dangling=true)
```
```
docker volume ls -qf dangling=true | xargs docker volume rm
```

#### Remove exited containers
```
docker rm -v $(docker ps -a -q -f status=exited)
```
```
docker ps -a -q -f status=exited | xargs docker rm -v
```

#### Stop & Remove all containers with base image name <image_name>
```
docker rm $(docker stop $(docker ps -a -q --filter ancestor=<image_name>))
```
```
docker ps -a -q --filter ancestor=<image_name> | xargs docker stop | xargs docker rm
```

#### Remove dangling images
```
docker rmi $(docker images -f "dangling=true" -q)
```
```
docker images -f "dangling=true" -q | xargs docker rmi
```

#### Cleanup Volumes
```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
           -v /var/lib/docker:/var/lib/docker \
           --rm martin/docker-cleanup-volumes
```

#### Remove all DinD containers
```
docker rm $(docker stop $(docker ps -a -q --filter ancestor=urbit/dind-jenkins))
```

#### Cleanup exited + orphaned + DinD
```
docker ps -a -q -f status=exited | xargs docker rm -v && \
docker volume ls -qf dangling=true | xargs docker volume rm && \
docker ps -a -q --filter ancestor=urbit/dind-jenkins | xargs docker stop | xargs docker rm
```

#### Docker-outside-of-Docker
```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
              -v $(which docker):/usr/bin/docker -p 8080:8080 my-dood-container
```

#### Docker-inside-Docker
```
docker run --privileged --name my-dind-container -d docker:dind
```
```
docker run --privileged --name my-dind-container -d urbit/dind-jenkins:latest
```
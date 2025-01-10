
## Note:

This is primarily a Demo video to revise concepts related to Docker. To test the commands we have used in the video, you will need a system with Docker installed.Kubernetes installation is not required.

### Documentation Referenced:

https://hub.docker.com/_/nginx

### Docker File - Example 1

```sh
FROM busybox:latest
CMD ["ping","-c","3","google.com"]
```
```sh
docker build -t busybox:ping .

docker images

docker run busybox:ping

docker ps

docker ps -a
```
### Docker File - Example 2

```sh
FROM ubuntu
ENTRYPOINT ["/bin/echo"]
CMD ["hello", "world"]
```

```sh
docker build -t ubuntu:custom .

docker images

docker run ubuntu:custom
```
### Overriding the Default CMD in Docker
```sh
docker run ubuntu:custom how are you
```
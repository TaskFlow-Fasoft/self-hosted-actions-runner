FROM ubuntu:latest
LABEL authors="joaol"

ENTRYPOINT ["top", "-b"]
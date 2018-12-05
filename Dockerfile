# Refers to docker.io/openjdk 8-jdk-slim
FROM openjdk@sha256:e54d401f6bdd8a00b2d8837038b0a63da2cf527ce52849e351af435d2f650dae
LABEL maintainer="Markku Korkeala"
ARG GRAALVERSION=graalvm-ce-1.0.0-rc9
ARG GRAALBASEURL=https://github.com/oracle/graal/releases/download/vm-1.0.0-rc9
ARG GRAALVM_SHA256=39ae49285044352b7ead2a4277cb286f5a3be84611b849e8f21b86f37205bb61
ENV GRAALVM_HOME=/usr/local/graalvm

RUN apt-get update && apt-get install -y gcc make libc6-dev zlib1g-dev curl
RUN curl -sL $GRAALBASEURL/$GRAALVERSION-linux-amd64.tar.gz > /tmp/$GRAALVERSION-linux-amd64.tar.gz \
	&& echo "$GRAALVM_SHA256  /tmp/$GRAALVERSION-linux-amd64.tar.gz" | sha256sum -c --strict \
	&& tar xzvf /tmp/$GRAALVERSION-linux-amd64.tar.gz \
	&& mv $GRAALVERSION /usr/local/ && ln -s /usr/local/$GRAALVERSION /usr/local/graalvm
RUN cp /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts /usr/local/graalvm/jre/lib/security/cacerts
RUN $GRAALVM_HOME/bin/native-image --version

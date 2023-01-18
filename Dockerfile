FROM maven:3.6.3-jdk-8

COPY target/ target/
COPY application.properties application.properties
COPY entrypoint.sh entrypoint.sh

RUN rm -rf target/classes/static

ENTRYPOINT bash ./entrypoint.sh
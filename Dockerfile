FROM maven:3.6.0-jdk-8 AS build
ADD ./* .
ADD envYaml envYaml
ADD src src
ADD target target
RUN ls -a
ENTRYPOINT mvn clean test "-DconfigPath=/qa.yaml" "-Dkarate.options=--tags @regression classpath:com/smartkids"
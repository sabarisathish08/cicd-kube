# Build stage
FROM openjdk:11-jdk AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone https://github.com/sabarisathish08/vprofile-project.git
RUN cd vprofile-project && git checkout docker && mvn install 

FROM tomcat:9-jre11
LABEL "Project"="vprofile"
LABEL "Author"="Sabari"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
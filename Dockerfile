# Multistage Dockerfile

FROM openjdk:8 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone -b main https://github.com/vivekdeshmukh/DevOps.git
RUN cd DevOps && mvn install

FROM tomcat:8-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE DevOps/target/devops-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 80
CMD ["catalina.sh", "run"]
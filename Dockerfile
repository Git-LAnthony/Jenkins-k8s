FROM tomcat:8.0.20-jre8
COPY test-java-app.war /usr/local/tomcat/webapps/test-java-app.war
#EXPOSE 8080
#CMD [ "catlina.sh","run" ]

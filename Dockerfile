# Use the official Tomcat image
FROM tomcat:9.0

# Copy your WAR files into Tomcat's webapps directory
COPY ./target/spti-health-api.war /usr/local/tomcat/webapps/

# Expose Tomcat port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]



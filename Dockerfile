# Use a stable OpenJDK image with Maven pre-installed
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set the working directory
WORKDIR /app

# Copy project files
COPY . .

# Clean and package the MyWMS application with Java 17
RUN mvn clean package -DskipTests

# Use Tomcat as runtime
FROM tomcat:10.1-jdk17

# Remove default Tomcat applications for security and performance
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
    /usr/local/tomcat/webapps/docs \
    /usr/local/tomcat/webapps/examples \
    /usr/local/tomcat/webapps/host-manager \
    /usr/local/tomcat/webapps/manager

# Set the working directory in Tomcat
WORKDIR /usr/local/tomcat/webapps/

# Copy the built WAR file to Tomcat's webapps folder as ROOT application
COPY --from=build /app/target/MyWMSApp.war ROOT.war

# Set JVM options for better performance on limited resources
ENV JAVA_OPTS="-Xmx512m -Xms256m -Djava.awt.headless=true"
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8"

# Expose the port Tomcat runs on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
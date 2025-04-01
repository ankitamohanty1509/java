# Use an OpenJDK base image
FROM openjdk:11-jre-slim

# Copy the Java file into the container
COPY HelloWorld.java /app/HelloWorld.java

# Compile the Java file
RUN javac /app/HelloWorld.java

# Run the Java application
CMD ["java", "-cp", "/app", "HelloWorld"]

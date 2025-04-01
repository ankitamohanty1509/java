Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the Java source code into the container
COPY HelloWorld.java /app/HelloWorld.java

# Compile the Java source code
RUN javac HelloWorld.java

# Run the Java program
CMD ["java", "HelloWorld"]

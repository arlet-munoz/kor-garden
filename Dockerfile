FROM openjdk:21-jdk

# Copiar archivos del proyecto
COPY . /app
WORKDIR /app

# Dar permisos al wrapper de Maven
RUN chmod +x ./mvnw

# Construir el proyecto
RUN ./mvnw clean package -DskipTests

# Exponer puerto
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "target/backend-0.0.1-SNAPSHOT.jar", "--spring.profiles.active=prod"]
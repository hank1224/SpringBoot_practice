FROM eclipse-temurin:21-jdk as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

#ENV JDBC_POSTGRESQL_URL=jdbc:postgresql://db:5432/student
#ENV POSTGRESQL_USERNAME=postgres
#ENV POSTGRESQL_PASSWORD=postgres

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM eclipse-temurin:21-jdk
VOLUME /tmp

#ENV JDBC_POSTGRESQL_URL=jdbc:postgresql://db:5432/student
#ENV POSTGRESQL_USERNAME=postgres
#ENV POSTGRESQL_PASSWORD=postgres

ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.demo.Demo1Application"]
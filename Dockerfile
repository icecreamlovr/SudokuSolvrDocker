FROM --platform=linux/amd64 amazoncorretto:17-alpine-jdk
COPY . /
CMD ["java", "-jar", "Sudoku.jar"]

# TODO: add mySQL db setup
# TODO: use a smaller base image

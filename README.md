# SudokuSolvrDocker
Build a docker image and deploy to AWS ECS.

# Steps
1. Clone Sudoku Solvr
```
$ git clone git@github.com:icecreamlovr/SudokuSolvrServer.git
```

2. Build jar
```
$ cd SudokuSolvrServer
$ gradle bootJar
```

3. Build docker image
```
$ cd <this folder> 
$ docker build -t sudoku .
```

4. Run locally
```
$ docker run -t -i -p 8080:8080 sudoku 
```

5. Download AWS CLI and configure login

6. Push to AWS ECR
```
$ aws ecr create-repository --repository-name sudoku-repository --region us-west-1
$ docker tag sudoku <repositoryUri>
$ aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
$ docker push <repositoryUri>
```

7. Start container on ECS
- https://aws.amazon.com/getting-started/hands-on/deploy-docker-containers/


# Problems encountered
## 503 Service Unavailable on ECS
This is because the docker image is built on ARM architecture. Switched to AMD64 architecture fixed the problem. Couple ways to switch:
- Specify platform when building docker image
  -  `$ docker buildx build --platform=linux/amd64 -t sudoku .`
- Specify platform in Dockerfile
  - `FROM --platform=linux/amd64 amazoncorretto:17-alpine-jdk`
- Specify different base image
  - `FROM amd64/amazoncorretto:17-alpine-jdk`

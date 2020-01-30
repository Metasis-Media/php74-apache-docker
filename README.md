# Apache+PHP74
 
### Assumptions
- MySQL as a Service or Vagrant MySQL
- Volume with wwwroot will be mounted at start

### Building Locally

To build and run the container locally, run the following commands:

- git clone project
- From project folder, run: ```cd app && composer install``` to install Laravel depenencies
- From app folder: ``` cp .env.example .example ``` & change the DB info
- From app folder, generate app keys: ``` php artisan key:generate ```
- From project folder we need to build the docker container: ```docker build --no-cache -t pa74 . ```
- Start container: ``` docker container run -d -v /path/to/app:/var/www/html -p 80:80 pa74:latest ```
- Once you start the container, you need to get the container ID to SSH into it: ```docker container ls``` will list the container running. copy the id and use in next step
- to ssh into container: ```docker exec -it contianer-id /bin/bash ``` REAPLACE container-id with the actual id!
- run migrations: ```php artisan migrate```

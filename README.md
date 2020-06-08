# README


## Configuration and Setup

* ### Requirements:

  * Ruby version: 2.7.0
  * Docker and docker compose

* ### Database Creation and configuration

  * Copy .env.template as .env and setup proper value for the respective environment variables.
  ``` cp .env.template .env ```


  * Run db:create and db:setup
  ``` sudo docker-compose run web rake db:create db:setup```

* ### Spin Server
  ```sudo docker-compose up --build```


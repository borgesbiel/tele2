Tele2 - logging system
===================

A simple logging application based on tele2 tech stack.
Built with:
- Ruby (Simple PORO Classes)
- EventMachine
- Bunny
- RabbitMQ

----------

Application
-------------

In this example i create a simple application which is decomposed in microservices. The microservices are developed in the ruby language and use Bunny ruby client to communicate with RabbitMQ and EventMachine to get keyboard client input.

Each microservice has a single responsibility to return the result to the messaging system then another microservice continues the job. The communication between the microservices is done via RabbitMQ queues, which results in a microservice consuming data from a queue and publishing the outcome to another queue. As a result, a chain of microservices processes the requests.


Workflow Diagram
-------------
![picture](/images/workflow.png?raw=true "workflow")

## Running each micro-service in docker container

This steps assume you have docker installed and working in your system.

Run with Docker
-------------

1. Clone the repository

  ```bash
  git clone git@github.com:borgesbiel/tele2.git
  ```
2. Build tele2 image (ruby:2.3-onbuild) using docker-compose

  ```bash
  docker-compose up -d
  ```

## Run microservices in docker

1. Run each microservice in a terminal.

  ```bash
   docker run --network=tele2_default --link tele2_rabbitmq_1:rabbitmq -t -i tele2 ruby keyboard_client.rb
  ```

  ```bash
   docker run --network=tele2_default --link tele2_rabbitmq_1:rabbitmq -t -i tele2 ruby gateway.rb
  ```

  ```bash
   docker run --network=tele2_default --link tele2_rabbitmq_1:rabbitmq -t -i tele2 ruby logger.rb
  ```

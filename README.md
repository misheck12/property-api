# Property API

This is a Ruby on Rails API for managing properties.

## Ruby version

This API requires Ruby version 3.2.2. Make sure you have it installed before proceeding.

## System dependencies

Ensure that the following dependencies are installed on your system:

- Ruby 3.2.2
- Rails 7
- PostgreSQL 15

## Configuration

1. Clone this repository to your local machine:

   ```shell
   git clone https://github.com/misheck12/property-api.git
   ```

2. Navigate to the project directory:

   ```shell
   cd property-api
   ```

3. Install the required gems by running the following command:

   ```shell
   bundle install
   ```

4. Create a database configuration file (`config/database.yml`) and provide the necessary credentials for connecting to your PostgreSQL database.

## Database creation and initialization

To create and set up the initial database schema and seed data, run the following commands:

```shell
rails db:create
rails db:migrate
```

## How to run the test suite

You can run the test suite using the following command:

```shell
bundle exec rspec
```

## Services

This API integrates with the following services:

- Job queues: Sidekiq (https://sidekiq.org/)
- Cache server: Redis (https://redis.io/)
- Search engine: Elasticsearch (https://www.elastic.co/)

Make sure you have these services set up and running before starting the API.

## Deployment instructions

To deploy this API to a production environment, follow these steps:

1. Set up a production database configuration (`config/database.yml`) with the appropriate credentials.

2. Configure your production environment variables in a file like `.env.production` or use a deployment tool like Capistrano (https://capistranorb.com/) or Docker (https://www.docker.com/) to manage environment variables.

3. Precompile the assets by running the following command:

   ```shell
   rails assets:precompile RAILS_ENV=production
   ```

4. Start the Rails server in production mode:

   ```shell
   rails server -e production
   ```

## Accessing Swagger

This API provides a Swagger documentation interface for easy testing and exploration. To access Swagger, follow these steps:

1. Start the Rails server:

   ```shell
   rails server
   ```

2. Open your web browser and visit the following URL:

   ```
   http://localhost:3000/swagger
   ```

   This will open the Swagger UI where you can view and interact with the API endpoints.

## License

This project is licensed under the MIT License.
```

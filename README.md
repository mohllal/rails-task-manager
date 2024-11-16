# Task Manager

Task Manager is a Rails application that allows users to create, update, view, and delete tasks.

It is the coursework project for the [Build Your Ruby on Rails Skills](https://www.linkedin.com/learning/paths/build-your-ruby-on-rails-skills?u=2115305) learning path on LinkedIn Learning which consists of the following courses:

1. [Ruby on Rails 7 Essential Training](https://www.linkedin.com/learning/ruby-on-rails-7-essential-training)
2. [Ruby on Rails Controllers and Views](https://www.linkedin.com/learning/ruby-on-rails-controllers-and-views)
3. [Ruby on Rails Models and Associations](https://www.linkedin.com/learning/ruby-on-rails-models-and-associations)
4. [Ruby on Rails: Debugging](https://www.linkedin.com/learning/ruby-on-rails-debugging)

## Requirements

### Ruby Version

- Ruby 3.2.5

### System Dependencies

- MySQL

## Configuration

### Environment Variables

Create a `.env` file in the root directory with the following content:

```env
MYSQL_ROOT_PASSWORD=root_password
MYSQL_DATABASE=task_manager_development
MYSQL_USER=task_manager_user
MYSQL_PASSWORD=task_manager_password
RAILS_ENV=development
```

### Database

Create database and run migrations:

```bash
bin/rails db:create
bin/rails db:migrate
```

If you want to seed the database with some sample data, run:

```bash
bin/rails db:seed
```

## Running the Application

1. Install dependencies:

    ```bash
    bundle install
    ```

2. Run a local MySQL database server and put the credentials in the `.env` file.

3. To start the Rails server, run:

    ```bash
    bundle exec rails server
    ```

4. Open your browser and navigate to `http://localhost:3000`.

### Running with Docker Compose

To run the application using Docker Compose, run:

```bash
docker-compose build
docker-compose up -d --force-recreate --remove-orphans
```

### Running Tests

1. Ensure the test database is created and migrated:

    ```bash
    bundle exec rails db:create RAILS_ENV=test
    bundle exec rails db:migrate RAILS_ENV=test
    ```

2. To run the tests, run:

    ```bash
    bundle exec rails test
    ```

#### Running Tests with Docker Compose

To run the tests using Docker Compose, run:

```bash
docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml up \
  --force-recreate \
  --remove-orphans \
  --abort-on-container-exit
```

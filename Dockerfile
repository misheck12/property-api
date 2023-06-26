# Base image for Ruby on Rails
FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        nodejs \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Install Geocoder dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgeos-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install project dependencies
RUN bundle install --jobs 4 --retry 3

# Copy the entire project directory to the container
COPY . .

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=misheck
ENV POSTGRES_PASSWORD=123456
ENV POSTGRES_DB=mydb

# Precompile assets
RUN bundle exec rails assets:precompile

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

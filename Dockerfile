FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /meal_plan
WORKDIR /meal_plan
COPY Gemfile /meal_plan/Gemfile
COPY Gemfile.lock /meal_plan/Gemfile.lock
RUN bundle install
COPY . /meal_plan

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
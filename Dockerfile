FROM ruby:3.1

RUN mkdir /pai-log
WORKDIR /pai-log
COPY Gemfile /pai-log/Gemfile
COPY Gemfile.lock /pai-log/Gemfile.lock
RUN bundle install
COPY . /pai-log

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

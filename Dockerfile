FROM ruby:3.0.2

# setting yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


# install packages
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn
WORKDIR /soseki
COPY Gemfile /soseki/Gemfile
COPY Gemfile.lock /soseki/Gemfile.lock
RUN bundle install
COPY . /soseki

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

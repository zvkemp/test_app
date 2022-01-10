FROM ruby:3.0.1

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN mkdir -p /app

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app

ENTRYPOINT ["/tini", "--"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

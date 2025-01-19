ARG RUBY_VERSION
ARG VARIANT=bookworm

FROM ruby:$RUBY_VERSION-$VARIANT

ENV RUBY_YJIT_ENABLE 1

ENV LANG C

# NOTE: ここでタイムゾーン設定してもRailsではちょっと違うので消してもいいかも
ENV TZ Asia/Tokyo

ENV APP /app

RUN mkdir $APP

COPY ./back/.ruby-version ./back/Gemfile ./back/Gemfile.lock $APP

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev

WORKDIR $APP

RUN bundle install --jobs=4

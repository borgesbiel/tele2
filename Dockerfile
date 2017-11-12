FROM ruby:2.3-onbuild
ADD . /
RUN bundle install

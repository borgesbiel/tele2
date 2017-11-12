FROM ruby:2.3-onbuild
ADD . /
RUN bundle install
WORKDIR /lib
EXPOSE 5672
EXPOSE 15672

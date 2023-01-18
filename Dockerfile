FROM ruby:2.7.2
ADD . /plant_coach_be_docker_image
WORKDIR /plant_coach_be_docker_image
RUN bundle install

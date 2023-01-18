FROM ruby:2.7.2
ADD . /plant_coach_be_docker_image
WORKDIR /plant_coach_be_docker_image
RUN bundle install

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

EXPOSE 3000
CMD ["bash"]

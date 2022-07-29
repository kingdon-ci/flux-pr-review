# syntax = docker.io/docker/dockerfile:experimental
FROM kingdonb/rvm-ruby3:1038d2fc as builder-base
LABEL maintainer="Kingdon Barrett <kingdon@weave.works>"
ENV APPDIR="/home/${RVM_USER}/app"
ENV RUBY=3.1.2
ENV GEMSET=testing

USER root
COPY jenkins/runasroot-dependencies.sh /home/${RVM_USER}/jenkins/
RUN /home/${RVM_USER}/jenkins/runasroot-dependencies.sh
RUN chgrp rvm /usr/local/bin && chmod g+w /usr/local/bin

FROM builder-base AS gem-builder-base
USER ${RVM_USER}
COPY --chown=rvm Gemfile Gemfile.lock .ruby-version ${APPDIR}/

FROM builder-base AS jenkins-builder
COPY jenkins/runasroot-jenkins-dependencies.sh /home/${RVM_USER}/jenkins/
RUN /home/${RVM_USER}/jenkins/runasroot-jenkins-dependencies.sh

FROM gem-builder-base AS gem-bundle
RUN --mount=type=ssh,uid=999,gid=1000 \
    rvm ${RUBY}         do rvm gemset create ${GEMSET} \
 && rvm ${RUBY}@${GEMSET} do bundle check \
 || rvm ${RUBY}@${GEMSET} do bundle install
RUN echo 'export PATH="$PATH:$HOME/app/bin"' >> ~/.profile \
 && echo "rvm ${RUBY}@${GEMSET}" >> ~/.profile

# FROM gem-bundle AS assets
# COPY --chown=${RVM_USER} Rakefile ${APPDIR}
# COPY --chown=${RVM_USER} config ${APPDIR}/config
# COPY --chown=${RVM_USER} bin ${APPDIR}/bin
# COPY --chown=${RVM_USER} app/assets ${APPDIR}/app/assets
# COPY --chown=${RVM_USER} lib/nd_workflow_class_methods.rb ${APPDIR}/lib/nd_workflow_class_methods.rb
# COPY --chown=${RVM_USER} vendor/assets ${APPDIR}/vendor/assets
# # COPY --chown=${RVM_USER} app/javascript ${APPDIR}/app/javascript/
# RUN --mount=type=cache,uid=999,gid=1000,target=/home/rvm/app/public/assets \
#   rvm ${RUBY}@${GEMSET} do bundle exec rails assets:precompile && cp -ar /home/rvm/app/public/assets /tmp/assets

FROM gem-bundle AS builder
# COPY --from=assets --chown=${RVM_USER} /tmp/assets ${APPDIR}/public/assets
FROM builder AS slug
COPY --chown=${RVM_USER} . ${APPDIR}
USER ${RVM_USER}
# RUN echo 'export PATH="$PATH:$HOME/app/bin"' >> ../.profile

FROM jenkins-builder AS jenkins
COPY --from=gem-bundle --chown=${RVM_USER} \
  /usr/local/rvm/gems/ruby-${RUBY}@${GEMSET} /usr/local/rvm/gems/ruby-${RUBY}@${GEMSET}
COPY --from=slug --chown=${RVM_USER} \
  ${APPDIR} ${APPDIR}
USER root
RUN useradd -m -u 1000 -g rvm jenkins
RUN chgrp rvm -R /home/${RVM_USER}/app
RUN chmod g+w -R /home/${RVM_USER}/app
USER jenkins

# RUN echo 'export PATH="$PATH:/home/rvm/app/bin"' >> ~/.profile

FROM slug AS prod
USER ${RVM_USER}
# USER root
# ENTRYPOINT ["/sbin/my_init", "--"]

# # Example downstream Dockerfile:
FROM slug as test
RUN bundle config set app_config .bundle
# If your app uses a different startup routine or entrypoint, set it up here
CMD rvm ${RUBY}@${GEMSET} do bundle exec rails server -b 0.0.0.0
EXPOSE 3000

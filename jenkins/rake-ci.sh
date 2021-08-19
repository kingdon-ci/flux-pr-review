#!/bin/bash

source /etc/profile.d/rvm.sh
rvm ${RUBY}@testing

bundle check
bundle exec ruby graphql_microtest.rb && \
	bundle exec rspec

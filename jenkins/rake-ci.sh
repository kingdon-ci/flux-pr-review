#!/bin/bash

if [ -f /etc/profile.d/rvm.sh ]; then
	source /etc/profile.d/rvm.sh
elif [ -f ~/.rvm/scripts/rvm ]; then
	source ~/.rvm/scripts/rvm
fi

rvm ${RUBY}@testing

bundle check

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bundle exec ruby graphql_microtest.rb && \
	bundle exec rspec

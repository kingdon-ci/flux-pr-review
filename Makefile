ALL_REPOS := fluxcd/community fluxcd/flux2 fluxcd/flux2-kustomize-helm-example fluxcd/flux2-multi-tenancy fluxcd/go-git-providers \
	fluxcd/helm-controller fluxcd/image-automation-controller fluxcd/image-reflector-controller \
	fluxcd/kustomize-controller fluxcd/notification-controller fluxcd/pkg fluxcd/source-controller \
	fluxcd/source-watcher fluxcd/terraform-provider-flux fluxcd/website fluxcd/webui

.PHONY: all
all: clean doit
review.csv:
	rvm $(shell cat .ruby-version) do bundle exec epr $(ALL_REPOS) > review.csv

.PHONY: clean
clean:
	rm -f review.csv

.PHONY: doit
doit: review.csv
	rvm $(shell cat .ruby-version) do bundle exec ./bugcrush.rb review.csv
	# do it

.PHONY: deps
deps:
	rvm $(shell cat .ruby-version) do bundle install

.PHONY: test
test:
	rvm $(shell cat .ruby-version) do bundle exec srb tc

FLUXV2_REPOS := fluxcd/community fluxcd/flux2 fluxcd/flux2-kustomize-helm-example fluxcd/flux2-multi-tenancy fluxcd/go-git-providers \
	fluxcd/helm-controller fluxcd/image-automation-controller fluxcd/image-reflector-controller \
	fluxcd/kustomize-controller fluxcd/notification-controller fluxcd/pkg fluxcd/source-controller \
	fluxcd/source-watcher fluxcd/terraform-provider-flux fluxcd/website fluxcd/webui

FLUXV1_REPOS := fluxcd/flux fluxcd/helm-operator fluxcd/flagger fluxcd/charts fluxcd/homebrew-tap \
	fluxcd/helm-operator-docs-redirects fluxcd/legacy-docs-redirects fluxcd/flux-recv \
	fluxcd/gitsrv fluxcd/distribution

.PHONY: all
all: clean doit

.PHONY: fluxv1
fluxv1: cleanv1 doitv1

review.csv:
	rvm $(shell cat .ruby-version) do bundle exec epr $(FLUXV2_REPOS) > review.csv

review-v1.csv:
	rvm $(shell cat .ruby-version) do bundle exec epr $(FLUXV1_REPOS) > review-v1.csv

.PHONY: clean cleanv1
clean:
	rm -f review.csv
cleanv1:
	rm -f review-v1.csv

.PHONY: doit doitv1
doit: review.csv
	rvm $(shell cat .ruby-version) do bundle exec ./bugcrush.rb review.csv v2 discussions.csv
	# do it
doitv1: review-v1.csv
	rvm $(shell cat .ruby-version) do bundle exec ./bugcrush.rb review-v1.csv v1
	# do it

.PHONY: deps
deps:
	rvm $(shell cat .ruby-version) do bundle install

.PHONY: dry-run
dry-run:
	echo "do a dry run (check auth is ready, github token can pull, do not write anything)"
	exit 1

.PHONY: test
test:
	#rvm $(shell cat .ruby-version) do bundle exec srb tc
	./jenkins/rake-ci.sh

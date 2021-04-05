.PHONY: all
all: doit
pr.csv:
	epr fluxcd/flux > pr.csv
	epr fluxcd/helm-operator |tail -n +2 >> pr.csv
	epr fluxcd/flux-recv |tail -n +2 >> pr.csv

.PHONY: doit
doit: pr.csv
	bundle exec ./googlify pr.csv
	# do it

.PHONY: clean
clean:
	rm -f pr.csv

.PHONY: deps
deps:
	bundle install

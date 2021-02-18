.PHONY: all
all: doit
pr.csv:
	epr fluxcd/flux > pr.csv

.PHONY: doit
doit: pr.csv
	bundle exec ./googlify pr.csv
	# do it

.PHONY: clean
clean:
	rm pr.csv

.PHONY: deps
deps:
	bundle install

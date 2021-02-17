pr.csv:
	epr fluxcd/flux > pr.csv

.PHONY: doit
doit: pr.csv
	./googlify pr.csv
	# do it

.PHONY: clean
clean:
	rm pr.csv

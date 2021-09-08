### `make pr.csv`

`pr.csv` is the default make target, run `make`

Also, `make clean`

### Credentials

There is usually a file `.env.local` which contains the following secret data:

```
GITHUB_TOKEN=ghp_123456999XXXFAKETOKEN999123456778889
```

You may also find the token in a git config like this:

```
[epr]
	token = ghp_123456999XXXFAKETOKEN999123456778889
[remote "origin"]
	url = git@github.com:kingdon-ci/flux-pr-review.git
```

The `sshaw/export-pull-requests` repo, which is a dependency of this app,
[provides a reference](https://github.com/sshaw/export-pull-requests#token)
on where `epr` can be expected to look for your `GITHUB_TOKEN`.
(`epr` will not look in the `GITHUB_TOKEN` environment variable, even if you exported it.)

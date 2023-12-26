### Flux Bug Scrub

For details about the Bug Scrub prep and how to run `make` (what to do
before/around/after that) visit [BUGSCRUB.md](/BUGSCRUB.md)

### Prerequisites

You need Ruby. I recommend RVM:

```bash
gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable

# (make sure that rvm is a function, log out your shell and log back in...)

rvm install 3.3.0 --with-openssl-dir=$(brew --prefix openssl@3)
rvm gemset create bugscrub
rvm gemset create testing
rvm 3.3.0@bugscrub do bundle install
rvm 3.3.0@testing do bundle install
rvm use 3.3.0@bugscrub

...

source .env.local
export GITHUB_TOKEN
make reset; make clean; make
```

You should ensure that `bundle install` is functioning and the dependencies are all downloaded. You may need to enable openssl.

```bash
...
```

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

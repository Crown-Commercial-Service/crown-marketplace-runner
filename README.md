# Crown Marketplace Runner

![Test Status](https://github.com/Crown-Commercial-Service/crown-marketplace-runner/actions/workflows/code_analysis.yml/badge.svg)

This is a simple project to help set up the development environment for the Crown Marketplace projects.

The Crown Marketplace projects consist of the following:
- [Crown Marketplace][] - [Ruby on Rails] application for the Facilities Management framework and managing users
- [Crown Marketplace Legacy][] - Ruby on Rails application for the Legal Services, Management Consultancy and Supply Teachers frameworks
- [Crown Marketplace - Feature tests][] - Cucumber test suite for automated testing of the web apps
- [CCS GitHub Actions x AWS CodePipeline][] - GitHub action to trigger deployments of the web apps
- [Crown Marketplace Maintenance][] - Single page app for use when Crown Marketplace is in maintinance mode
- [CCS OmniAuth::OpenIDConnect][] - CCS version of `OmniAuth::OpenIDConnect`
- [CCS Frontend Helpers][] - Ruby on Rails View helpers for GOV.UK Frontend components and CCS components
- [CCS Frontend Project][] - HTML, CSS and JavaScript code for CCS components

There are more details about these projects in their respective READMEs.

## Quick Start

- Make sure the [correct version](#ruby) of [Ruby][] is installed
- Run `bin/setup` check you have the required software installed and to download the project repositories.
  If you are missing any software make sure it is installed before continuing.
- Run `bin/build-applications` to build the web applications
- Add `.env.local` file to the projects to pass the local environment variables
- Run `bin/run-dev` to bring up the web applications and their background services.
  You can then access them on http://localhost.

## Scripts

### `bin/run-dev`

Running `bin/run-dev` will bring up the two web applications and their Sidekiq instances and start an NGINX server on `http://localhost`.

The exact process are:
- **web** - the NGINX server
- **crown-marketplace_assets** - Crown Marketplace Shakapacker dev server for JavaScript assets
- **crown-marketplace_app** - Crown Marketplace application dev server running on port 3000
- **crown-marketplace-legacy_assets** - Crown Marketplace Legacy Shakapacker dev server for JavaScript assets
- **crown-marketplace-legacy_app** - Crown Marketplace Legacy application dev server running on port 3000
- **redis** - The Redis server for Sidekiq
- **crown-marketplace_sidekiq** - Crown Marketplace Sidekiq server
- **crown-marketplace-legacy_sidekiq**: Crown Marketplace Legacy Sidekiq server

You can run the applications without Sidekiq by passing the `--no-sidekiq` argument to the command.


### `bin/setup`

Running `bin/setup` checks you have the following software installed:
- **PostgreSQL** (database)
- **Redis** (cache for Sidekiq)
- **NodeJS** (for JavaScript assets)
- **Bun** (for application assets)
- **ClamAV** (optional) (Virus check documents)
- **NGINX** (local web server)

You can found out more about how to install these in the [Software requirements](#software-requirements).

It will also download the following repositories into the `code` directory (if not already downloaded):
- Applications:
  - [Crown Marketplace][]
  - [Crown Marketplace Legacy][]
- Testing:
  - [Crown Marketplace - Feature tests][]
- Frontend:
  - [CCS Frontend Helpers][]
  - [CCS Frontend Project][]
- Misc.:
  - [CCS GitHub Actions x AWS CodePipeline][]
  - [Crown Marketplace Maintenance][]
  - [CCS OmniAuth::OpenIDConnect][]

### `bin/build-applications`

Running `bin/build-applications` will do the following to both applications:
- Run `bundle install` to download the ruby gems
- Run `bin/rails assets:precompile` to compile the CSS and JavaScript assets
- Run `bin/rails db:prepare` to create or migrate existing database

### `bin/update-code`

Running `bin/update-code` will fetch the latest version of the code (on the default branch) for all the projects

## Software requirements

This project runs on macOS and the instructions below assume you have [`homebrew`][homebrew] installed.

If you have any problems installing these you should consult the documentation or speak to another developer for help.

### Ruby

The web application projects currently run on [Ruby][] v3.4.1.

Ensure that a ruby version manager (e.g. rvm or rbenv) is installed and set up properly before continuing.

### PostgreSQL and PostGIS

[PostgreSQL][] and [PostGIS][] are required for the local database setup.

```shell
brew install postgresql
brew install postgis
```

### Redis

[Redis][] is required for the [Sidekiq][] (background jobs) server to run.

```shell
brew install redis
```

### NodeJS

[NodeJS][] is used to manage external CSS and JavaScript packages that are used in the frontend applications.
You should use [Node Version Manager][] (so as not to conflict with your system and other projects).

```shell
brew install nvm
```

You can then install an up to date version of node (these projects use v20).

```shell
nvm install 20 
```

### Bun

[Bun][] is used to manage the NodeJS modules.

```shell
brew install bun
```

### ClamAV

[ClamAV][] is the antivirus software used to scan uploaded files.
It is not a requirement to run the projects which is why it is an optional dependency.

```shell
brew install clamav
```

### NGINX

[NGINX][] is only required for the Crown Marketplace Runner as it is used as a reverse proxy to access both applications via the same URL.


```shell
brew install nginx
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Crown-Commercial-Service/crown-marketplace-runner.

To contribute to the project, you should checkout a new branch from `main` and make your changes.

Before pushing to the remote, you should squash your commits into a single commit.
This can be done using `git rebase -i main` and changing `pick` to `s` for the commits you want to squash (usually all but the first).
This is not required but it helps keep the commit history fairly neat and tidy

Once you have pushed your changes, you should open a Pull Request on the main branch.
This will run:
- Rubocop

Once all these have passed, and the PR has been reviewed and approved by another developer, you can merge the PR.

[Crown Marketplace]: https://github.com/Crown-Commercial-Service/crown-marketplace
[Crown Marketplace Legacy]: https://github.com/Crown-Commercial-Service/crown-marketplace-legacy
[Crown Marketplace - Feature tests]: https://github.com/Crown-Commercial-Service/crown-marketplace-feature-tests
[CCS GitHub Actions x AWS CodePipeline]: https://github.com/Crown-Commercial-Service/ccs-aws-codepipeline-action
[Crown Marketplace Maintenance]: https://github.com/Crown-Commercial-Service/crown-marketplace-maintenance
[CCS OmniAuth::OpenIDConnect]: https://github.com/Crown-Commercial-Service/ccs_omniauth_openid_connect
[CCS Frontend Helpers]: https://github.com/Crown-Commercial-Service/ccs-frontend_helpers
[CCS Frontend Project]:  https://github.com/Crown-Commercial-Service/ccs-frontend-project
[homebrew]: https://brew.sh/
[PostgreSQL]: https://www.postgresql.org/
[PostGIS]: https://postgis.net/
[Redis]: https://redis.io/
[Sidekiq]: https://sidekiq.org/
[NodeJS]: https://nodejs.org/en
[Node Version Manager]: https://github.com/nvm-sh/nvm
[Bun]: https://bun.sh/
[NGINX]: https://nginx.org/en/
[ClamAV]: https://www.clamav.net/
[Ruby on Rails]: https://rubyonrails.org/
[Ruby]: https://www.ruby-lang.org/en/

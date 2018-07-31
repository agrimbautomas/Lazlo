## Lazlo API

Markdown
[![pipeline status](https://gitlab.com/agrimbautomas/lazlo-web-rails/badges/production/pipeline.svg)](https://gitlab.com/agrimbautomas/lazlo-web-rails/commits/production)
[![coverage report](https://gitlab.com/agrimbautomas/lazlo-web-rails/badges/production/coverage.svg)](https://gitlab.com/agrimbautomas/lazlo-web-rails/commits/production)

A Ruby on Rails API to process web requests and run the BAT tool for the Lazlo Web Platform.


## Requirements
- Ruby > 2.3
- NodeJs > 5.10 

## Install for development

```
$ bundle install --path vendor/bundler
$ bundle exec rake db:setup
```

### Start Server

In order to start the server on http://localhost:3000/ you will need to run:
```
$ rails server
```
And the run in another terminal/process the following commmand in the same project dir to start the API Workers.
```
$ rake jobs:work
```

### Auto load images of resources
Create ```site-images``` folder in root dir and add images into it.
Later just run the rake command:
```
$ rake app:add_images
```


### Admin Section

If you want to access to the admin panel of the app you cand do it from http://localhost:3000/admin
By default you will have and admin user with the email 'admin@lazlo.com' and the password 'lazlo-password'.


### Database
To set the databases enviroments you need to create a fila called database.yml in the config dir (/config/database.yml).
The format of this file is yml based and you can get an example in the [database example file][10].

### Tests

[RSpec][1] and [RSpec-Rails][2] are used for testing, following [Test-Driven Development][3] methodologies.
To run the tests use *rspec* rake task or *lazlo:test*.

```
$ bundle exec rspec
```

or

```
$ bundle exec rake lazlo:test
```


### Code Coverage

[SimpleCov][4] is used for code coverage reports. To generate a coverage report from tests use the rake task *lazlo:coverage*.

```
$ bundle exec rake lazlo:coverage
```

The report is saved at `test_output/coverage/index.html`.

### Documentation

[GITLAB WIKI][5] is used to store all the API documentation. WIKI: https://git@gitlab.com:agrimbautomas/lazlo-web-rails.git/wikis

> [Reports][6]

> [Settings][7]

> [Users][8]

### Code Review

Automatic code review is implemented using [Rubycritic][9]. Rubycritic is used for code smells.

 - Rubycritic is run with *lazlo:codereview*.

```
$ bundle exec rake lazlo:codereview
```

 - Rubycritic output is saved at `test_output/codereview/overview.html`


## Rake Tasks

 - *lazlo:codereview*: Automatic code-review report (report task).
 - *lazlo:coverage*: Generate code coverage report from tests (report task).
 - *lazlo:test*: Run all tests in spec directory.

### SSL Certificates

To update certificates with 'letsencrypt' gem, go to the server and run 'rake letsencrypt_plugin'. 


### Authentication

The Lazlo API uses [Devise Gem - Flexible authentication solution for Rails with Warden][15]
for authentication, and [Doorkeeper][16] for token generation and verification.

Doorkeeper is an OAuth 2 provider for Rails. It's built on top of Rails engines. The gem is in active development. So far it supports all protocol flows, but we will still have to work on few missing pieces.


### CORS

To allow API consumption from other domains in Javascript we need to supply support for [CORS][17].

CORS support is provided by the Cors Rack middleware. Currently this middleware allows access from every domain
to every path (existing or not).

[1]: http://rspec.info/
[2]: https://github.com/rspec/rspec-rails
[3]: http://agiledata.org/essays/tdd.html
[4]: https://github.com/colszowka/simplecov
[5]: https://git@gitlab.com:agrimbautomas/lazlo-web-rails.git/wikis/home
[6]: https://git@gitlab.com:agrimbautomas/lazlo-web-rails.git/wikis/Reports
[7]: https://git@gitlab.com:agrimbautomas/lazlo-web-rails.git/wikis/Settings
[8]: https://git@gitlab.com:agrimbautomas/lazlo-web-rails.git/wikis/Users
[9]: https://github.com/whitesmith/rubycritic
[10]: https://git@gitlab.com:agrimbautomas/lazlo-web-rails.git/blob/master/config/database-example.yml

[15]: https://github.com/plataformatec/devise
[16]: https://github.com/doorkeeper-gem/doorkeeper
[17]: https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
[18]: /lib/lazlo/rack/cors.rb
[19]: https://github.com/chriswarren/doorkeeper-jwt

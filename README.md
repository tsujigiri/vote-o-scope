# Vote-o-Scope [![Build Status](https://travis-ci.org/tsujigiri/vote-o-scope.svg?branch=master)](https://travis-ci.org/tsujigiri/vote-o-scope)

Elevator pitch: It's a match-making machine for elections!

Vote-o-Scope lets you assemble statements and collect positions to those
statements from to-be-elected representatives or parties.

Voters can then click through the statements, put in their own positions
by clicking *agree*, *disagree* or *neutral* and then see an overview
of what party or representative matches best.


## Setup

At the moment, there is no CSS included. This is by intention as this
way it's very easy to create a branch and add a layout for each site
the app is to be integrated with. So, for now, you have to fork it and
add a layout yourself
([This might change in the future](https://github.com/tsujigiri/vote-o-scope/issues/3)).

In order to get the app running, follow these steps.

1. Decide for a database. Supported is anything ActiveRecord can handle.
   Copy one of the respective configuration files from
   `config/database.yml.<database>` to `config/database.yml` and adapt
   it as needed.

2. Configure your database system, so that the app can create the
   database and tables. Run
   `RAILS_ENV=production bundle exec rake db:create db:schema:load`.

3. Run `RAILS_ENV=production bundle exec rake assets:precompile`.

4. Run it... There are plenty of ways of running a Rails app. Covering
   them here would go beyond the scope of this README.


## Getting Started

First, to be able to log in and edit the content, create a user on the
command line:

```
RAILS_ENV=production bundle exec user:add[email,password]
```

Then go to `https://your-domain.tld/users/sign_in` and sign in. You will
be redirected to the admin pages where you can edit the content.

## Development

To run the tests, [phantomjs](http://phantomjs.org/) needs to be installed.


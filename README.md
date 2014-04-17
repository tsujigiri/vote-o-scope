# Vote-o-Scope

Elevator pitch: It's a match-making machine for elections!

Vote-o-Scope lets you assemble statements and collect positions to those
statement from to-be-elected representatives and parties.

Voters can then click through the statements themselves, put in their
own positions by clicking *agree*, *disagree* or *neutral* and then see
an overview of what party or representative matches best.


## Setup

**tl/tr**: It's a Rails app, nothing special about it.

In order to get the it running, follow these steps.

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


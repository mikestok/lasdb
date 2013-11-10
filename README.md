# LASDB - Love and Sex Database

## Purpose

This is a Ruby on Rails project for exploration. It is a simple question and
answer database for multiple choice tests.

## Development

### Ruby Version

Ruby 2.0.0 is assumed to be used. It is mentioned in the `Gemfile`, and
the `.ruby-version` file.

### Ruby Gems

To install the gems use this command the first time you use `bundler` to
get the gems in the right place.

    bundle install --path vendor/install

### Git & Tagging

This uses git-flow for development.

As of 2011 04 24 issues and feature requests should go in Github -
https://github.com/mikestok/lasdb/issues 

Git flow feature branches should be called _github-issue-_*n* where
the *n* is the issue number.

Currently as I'm the only person working on this the relases are
numbered *yyyy-mm-dd-*r*n* where *n* is the number of the release for
that day.

## Deployment to Heroku

As of 2013-10-20 I am using Rails 3.2 and Ruby 2.0; during the upgrade it
made sense to precompile the assets locally so before pushing to Heroku I
need to run:

    RAILS_ENV=production bundle exec rake assets:precompile

to precompile the assets.

### Deploying a Development Branch

In order to test the application I sometimes push a development branch to 
Heroku to try it out on my development instance. To do that I need to commit
my changes to the local branch and run:

    git push -f heroku HEAD:master

To "fix" Heroku's master branch I can check out master locally and run:

    git push --force heroku master

## Access Control on Heroku

For some security the production version of the app requires a USERNAME
and SECRET to be set up on Heroku.  This can be done using

    heroku config:add USERNAME='username' --app whatever
    heroku config:add SECRET='secret' --app whatever

As this is using basic auth we need to force the use of SSL, and this
in turn assumes the Piggyback SSL addon has been added on in Heroku.

## Entity Relationship Diagram

_On a Mac…_ if you install the graphviz package from
http://www.graphviz.org/Download_macos.php then you can use a command like:

    bundle exec rake erd \
      attributes=foreign_keys,primary_keys,timestamps,inheritance,content \
      notation=bachman

To generate a PDF of the database schema.

## Database Backups

See http://devcenter.heroku.com/articles/pgbackups for information on
the Heroku PGBackups add-on.

I have added database-backups/ to .gitignore so that I can stash the
backups on a development machine without polluting git.

Run

    script/download-heroku-backup

to get the latest database backup (assumes PG Backups addon is installed).

## Author(s)

Mike Stok <mike@stok.ca>

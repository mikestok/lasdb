LASDB - Love and Sex Database
=============================

Purpose
-------

This is a Ruby on Rails project for exploration.

Database Backups
----------------

Run

    script/download-heroku-backup

to get the latest database backup (assumes PG Backups addon is installed).

Development
-----------

This uses git-flow for development.

As of 2011 04 24 issues and feature requests should go in Github - 
https://github.com/mikestok/lasdb/issues 

Git flow feature branches should be called _github-issue-_*n* where
the *n* is the issue number.

Currently as I'm the only person working on this the relases are
numbered *yyyy-mm-dd-*r*n* where *n* is the number of the release for
that day.

Access Control
--------------

For some security the production version of the app requires a USERNAME
and SECRET to be set up on Heroku.  This can be done using

    heroku config:add USERNAME='username' --app whatever
    heroku config:add SECRET='secret' --app whatever

As this is using basic auth we need to force the use of SSL, and this 
in turn assumes the Piggyback SSL addon has been added on in Heroku.

Backups
-------

See http://devcenter.heroku.com/articles/pgbackups for information on
the Heroku PGBackups add-on.

I have added database-backups/ to .gitignore so that I can stash the
backups on a development machine without polluting git.

Author
------

Mike Stok <mike@stok.ca>

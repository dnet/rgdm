Redmine-Git Database Migrator
=============================

Purpose
-------

This tool makes it possible to migrate a project's database schema using SQL statements embedded in Redmine issues. Given an expression compatible with `git log`, `rgdm` extracts the issue numbers mentioned in the first lines of the commit messages (usually used for summary). These issue numbers are then queried using the Redmine REST API to access text entries, which can contain SQL code in `<code class="sql">...</code>` blocks.

Dependencies
------------

 * reasonable shell (tested with zsh, dash, ksh, bash)
 * git (obviously)
 * xsltproc
 * curl

Debian/Ubuntu users should just use `apt-get install xlstproc git curl`.

Setup and usage
---------------

 * make sure the dependencies above are installed
 * put all rgdm files in a directory of your choice (since you have git installed at this point, the simplest way is to clone the repository using `git clone git://github.com/dnet/rgdm.git`)
 * let git know about the Redmine URL and key by editing either the global (`~/.gitconfig`) or local (`repo/.git/config`) git configuration file (you can use the sample.gitconfig as an example)
 * in any git repository, the database migration history can be viewed using `/path/to/rgdm.sh [since..until]`
 * without any arguments, `rgdm` displays the whole database history
 * any git commit ID (`HEAD`, `master`, SHA-1 hash, tag) can be used since the arguments are parsed by `git log`

License
-------

The whole project is licensed under MIT license.

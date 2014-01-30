git-shame(1) -- Who to blame for stale remote branches
======================================================

## SYNOPSYS

`git shame` [--[no]-color] [--remote REMOTE] [--[no-]show-commands] [--[no-]show-report] [--[no-]show-merged] [--[no-]show-unmerged] [--users email1@example.com, email2@example.com, ...]

## DESCRIPTION

Projects can accumulate a significant number of remote topic branches.
Which are active? Which are safe to delete? Who "owns" them?

`git shame` knows, and can help you clean these branches up (see [EXAMPLES]).

## OPTIONS

* `--color`

  Colorful output. This is automatically set when output is a TTY and
  the _colored_ gem is installed.

* `--no-color`

  Turn off colors. This is the default when output is not to a TTY.

* `--remote REMOTE`

  Specify a remote branch. The default is _origin_.

* `--show-commands`

  Output shell commands to delete remote branches. This is off by default.

* `--no-show-commands`

  Do not output shell commands. This is the default.

* `--show-report`

  Output a report of remote branches, grouped by their "owners", ordered by
  staleness (time of most recent commit), showing their merged/unmerged status
  relative to the currently checked out branch. This is on by default.

* `--no-show-report`

  Don't show a report. You may want to use this in conjunction with
  `--show-commands` and pipe the output to sh(1) (be careful!)

* `--show-merged`

  Show merged branches in report and command output. This is on by default.

* `--no-show-merged`

  Do not show merged branches in report and command output.

* `--show-unmerged`

  Show unmerged branches in report and command output. This is on by default.

* `--no-show-unmerged`

  Do not show unmerged branches in report and command output.

* `--users email1@example.com, email2@example.com, ...`

  By default, `git shame`'s output includes all branches regardless of ownership.
  You may limit report and command output to branches "owned" by certain users,
  specified by a list of one or more email addresses separated by commas.

## EXAMPLES

Before running any of these, make sure your local repo is up to date
relative to your remote. Run `git pull` and `git remote --prune`.
As the merged status is relative to the currently checked out branch,
be sure to `git checkout` the branch you typically merge into (often this
is _master_ or _develop_ depending on the project's workflow).

* `git shame`

  Running with no options generates the standard report.
  The report groups branches by "owner", which `git shame` defines as
  the user who made the last commit to it.
  It's prettier if you have the _colored_ gem installed.

* `git shame --no-show-report --show-commands --show-merged --no-show-unmerged`

  This will output shell commands to delete all remote branches considered
  safe to delete (that is, they have been merged into the current branch).
  Resist the urge to pipe the output sh(1)! Sanity check it first.

## AUTHOR

Daniel Rench

## SEE ALSO

git(1), git-branch(1), git-remote(1), [git-shame on github](https://github.com/drench/git-shame)


[SYNOPSYS]: #SYNOPSYS "SYNOPSYS"
[DESCRIPTION]: #DESCRIPTION "DESCRIPTION"
[OPTIONS]: #OPTIONS "OPTIONS"
[EXAMPLES]: #EXAMPLES "EXAMPLES"
[AUTHOR]: #AUTHOR "AUTHOR"
[SEE ALSO]: #SEE-ALSO "SEE ALSO"


[git-shame(1)]: git-shame.1.html

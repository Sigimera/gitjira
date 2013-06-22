# gitjira

Git JIRA is an extension that combines feature, or all other type of branches,
with JIRA issues. It shows the current status and the summary of the issue.

In order to be able to combine branches the branch name must include the following
string _PROJECTKEY-###_

Examples if the project key is _PROJ_ and the issue number is _123_

    PROJ-123
    PROJ-123_description
    features/PROJ-123_some_description
    someprefix/PROJ-123-some_description

## Installation

Install via rubygems.org:

    $ gem install gitjira
    or with global via rvm
    $ rvm @global do gem install gitjira

## Setup:

    $ git-jira init
    JIRA host (e.g. https://jira.example.org): http://www.example.org/jira
    Your JIRA username                       : johnny
    Your JIRA password                       : ************
    Related JIRA project key (e.g. PROJ)     : PROJ

If you want update the configuration file, e.g. changing the host, you can
update directly the .git/config file or via the following command:

    $ git-jira init -f # or --force


## Example Scenario #1 - List branch information that have related JIRA issues:

    $ git-jira list
    Open           0% done  PROJ-123  - Implement some new feature
    Resolved     100% done  PROJ-20   - And yet another feature
    Resolved      42% done  PROJ-16   - Add /features page

## Exampel Scenario #2 - Get information about the current branch

    $ git-jira describe
    => Add /features page <=

    Issue Key...........: PROJ-123
    Type................: New Feature
    Status..............: Resolved
    Progress............: 42.0 %
    Estimated Work......: 1d
    Remaining Work......: 4h 35m
    Resolution..........: Fixed
    Priority............: Major
    Assignee............: Me
    Reporter............: Me
    Created At..........: 2013-05-26 13:09:17 +0200
    Updated At..........: 2013-06-20 23:21:18 +0200
    Fix Version.........: v1.2.0 (2013-06-30),

    Add a page that list all features.

## Tips & Tricks

Use aliases to be even more efficient, e.g. add 'alias jl = jira list' to your global ~/.gitconfig

    $ git jl # same as git jira list

## Usage

    # See what commands are available.
    $ git-jira --help # or git jira -h

## Contributing

Please contribute and help to make this tool even better.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


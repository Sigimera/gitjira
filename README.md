# gitjira

Git JIRA is an extension that combines branches with JIRA issues. It allows the
extraction of issue information directly from the console, without changing to
the JIRA website and interrupting the work process.

In order to be able to enrich a branch with issue informaiton the name must
include the following string _PROJECTKEY-###_ aka. the issue name.

Examples if the project key is _PROJ_ and the issue number is _123_

    PROJ-123
    PROJ-123_description
    features/PROJ-123_some_description
    someprefix/PROJ-123-some_description

## Installation

Install via rubygems.org:

    $ gem install gitjira
    or globally via rvm
    $ rvm @global do gem install gitjira

## Setup:

    $ git-jira init # or gj init
    JIRA host (e.g. https://jira.example.org): http://www.example.org/jira
    Your JIRA username                       : johnny
    Your JIRA password                       : ************
    Related JIRA project key (e.g. PROJ)     : PROJ

If you want update the configuration file, e.g. changing the host, you can
update directly the .git/config file or via the following command:

    $ git-jira init -f # or --force or gj init


Check if the configuration was stored correctly.

    $ git-jira config # or gj config
    JIRA Host...........: https://www.example.org/jira
    JIRA Project Key....: PROJ
    JIRA Username.......: johnny


## Example #1 - List branch information that have related JIRA issues:

    $ git-jira list # or gj list or git-jira or gj
    Open           0% done  PROJ-123  - Implement some new feature
    Resolved     100% done  PROJ-20   - And yet another feature
    Resolved      42% done  PROJ-16   - Add /features page

## Exampel #2 - Get information about the current branch

    $ git-jira describe # or gj describe
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

    Add a page that lists all features.

## Exampel #3 - Get information about a specific issue

Get information about a specific issue that must not be available as branch.

    $ git-jira describe -i 123 # or git-jira describe -i PROJ-123 or gj describe -i PROJ-123
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

    Add a page that lists all features.

## Tips & Tricks

Use aliases to be even more efficient:

    $ cat ~/.gitconfig
    ...
    [alias]
        jl = jira list
        jd = jira describe
    ...

    $ git jl # same as git jira list
    $ git jd # same as git jira describe

## Usage

    # See what commands are available.
    $ git-jira --help # or git jira -h

## Resources

* [RubyGems.org](https://rubygems.org/gems/gitjira) - The gem lives here...
* [GitHub](https://github.com/Sigimera/gitjira) - The code lives here...
* [Documentation](http://sigimera.github.io/gitjira/) - The documentation lives here...

## Contributing

Please contribute and help to make this tool even better.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


# gitjira

Git JIRA is an extension that combines feature or all other type of branches
with JIRA issues. It shows the current status and the summary of the issue.

In order to be able to combine branches the branch name must include the following
string _PROJECTKEY-###_

Examples if the project key is _PROJ_ and the issue number _123_

    features/PROJ-123_some_description
    someprefix/PROJ-123_some_description
    PROJ-123
    PROJ-123_description

### Setup:

    $ git jira init
    JIRA host (e.g. https://jira.example.org): http://www.example.org/jira
    Your JIRA username                       : johnny
    Your JIRA password                       : ************
    Related JIRA project key (e.g. PROJ)     : PROJ


### Example Scenario - Feature Branches:

    $ git jira list
    Open           0% done  PROJ-123  - Implement some new feature
    Resolved     100% done  PROJ-20   - And yet another feature
    Resolved      42% done  PROJ-16   - Add /features page

## Tips & Tricks

Use aliases to be even more efficient, e.g. add 'alias jl = jira list' to your global ~/.gitconfig

   $ git jl # same as git jira list

## Installation

Install via rubygems.org:

    $ gem install gitjira

## Usage

    # See what commands are available.
    $ git-jira --help # or git jira -h

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


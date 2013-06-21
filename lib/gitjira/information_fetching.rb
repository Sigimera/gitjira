class Gitjira::InformationFetching

  def self.branches
    jira_url = "#{Gitjira::InformationFetching.host}rest/api/2/issue/"
    credentials = Gitjira::InformationFetching.credentials
    project_key = Gitjira::InformationFetching.project_key
    branches = `git branch -a`.split("\n")
    issues = Array.new
    issues_printed = Array.new

    branches.each do |current_branch|
      branch = current_branch[/#{project_key}-\d+/]
      if branch
        unless issues_printed.include?(branch)
          issues_printed << branch
          fetch = true
        end
      end

      if fetch
        response = RestClient::Resource.new("#{jira_url}#{branch}", {
          :headers => { "Authorization" => "Basic #{credentials}" }
        }).get
        json = JSON.parse(response)
        if json['fields']['progress']['percent']
          puts sprintf "%-12s %3.0f%s\t%-14s - %s", json['fields']['status']['name'], json['fields']['progress']['percent'], "% done", branch, json['fields']['summary']
        else
          puts sprintf "%-12s\t\t%-14s - %s", json['fields']['status']['name'], branch, json['fields']['summary']
        end

        fetch = false
      end
    end

    return nil
  end

  def self.project_key
     `git config --local --get gitjira.projectkey`.chomp
  end

  def self.credentials
     `git config --local --get gitjira.credentials`.chomp
  end

  def self.host
     `git config --local --get gitjira.host`.chomp
  end

end


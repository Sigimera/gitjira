class Gitjira::InformationFetching

  def self.branches
    project_key = self.project_key
    branches = `git branch -a`.split("\n")
    issues = Array.new
    issues_printed = Array.new

    branches.each do |current_branch|
      branch = current_branch[/#{project_key}-\d+/]
      if branch and not issues_printed.include?(branch)
          issues_printed << branch
          fetch = true
      end

      if fetch
        json = self.fetch_issue_json(branch)
        if json['fields']['progress']['percent']
          puts sprintf "%-12s %3.0f%s\t%-14s - %s",
            json['fields']['status']['name'],
            json['fields']['progress']['percent'],
            "% done", branch, json['fields']['summary']
        else
          puts sprintf "%-12s\t\t%-14s - %s",
            json['fields']['status']['name'],
            branch, json['fields']['summary']
        end

        fetch = false
      end
    end

    return nil
  end

  def self.describe(issue = nil)
    issue = "#{self.project_key}-#{issue}" if issue and not issue.to_s.start_with?(self.project_key)
    issue = self.extract_issue unless issue

    if issue
      issue_info = self.fetch_issue_json(issue)
      if issue_info
        fields = issue_info['fields']

        puts "=> #{fields['summary']} <="
        puts ""
        puts "Issue Key...........: #{issue_info['key']}"
        puts "Type................: #{fields['issuetype']['name']}"
        puts "Status..............: #{fields['status'] ? fields['status']['name'] : 'None'}"
        if fields['progress'] and fields['progress']['percent']
          puts "Progress............: #{fields['progress']['percent'].round(2)} %"
        end
        if fields['timetracking'] and fields['timetracking']['originalEstimate'] and fields['timetracking']['remainingEstimate']
          puts "Estimated Work......: #{fields['timetracking']['originalEstimate']}"
          puts "Remaining Work......: #{fields['timetracking']['remainingEstimate']}"
        end
        puts "Resolution..........: #{fields['resolution'] ? fields['resolution']['name'] : 'None'}"
        puts "Priority............: #{fields['priority']['name']}"
        puts "Assignee............: #{self.extract_person(fields['assignee'])}"
        puts "Reporter............: #{self.extract_person(fields['reporter'])}"
        puts "Created At..........: #{self.date_formatter(fields['created'])}"
        puts "Updated At..........: #{self.date_formatter(fields['updated'])}"
        puts "Fix Version.........: #{self.extract_versions(fields['fixVersions'])}"

        if fields['description']
          puts ""
          puts "#{fields['description']}"
        end
      else
        puts "[Error] Not able to extract issue information of '#{issue}'"
      end
    else
      puts "[Warning] You are currently in no branch that is related to an issue."
    end
  end

  def self.date_formatter(date)
    DateTime.parse(date).strftime("%Y-%m-%d %H:%M:%S %z")
  end

  def self.extract_person(person_object)
    me_email = `git config --get user.email`.chomp
    if me_email and person_object and me_email.eql?(person_object['emailAddress'])
      "Me"
    else
      "#{person_object['displayName']} <#{person_object['emailAddress']}>"
    end
  end

  def self.extract_versions(version_array)
    if version_array and version_array.kind_of?(Array)
      versions = ""
      version_array.each do |version|
        versions = "#{version['name']} (#{version['releaseDate']}), #{versions}"
      end
      versions
    else
      ""
    end
  end

  def self.extract_issue(branch_name = nil)
    branch_name = self.current_branch if branch_name.nil?
    project_key = self.project_key
    branch_name[/#{project_key}-\d+/]
  end

  def self.current_branch
    `git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  end

  def self.project_key
    `git config --local --get gitjira.projectkey`.chomp
  end

  def self.host
    `git config --local --get gitjira.host`.chomp
  end

  private
  def self.fetch_issue_json(issue_name)
    jira_url = "#{self.host}rest/api/2/issue/"
    credentials = self.credentials

    response = RestClient::Resource.new("#{jira_url}#{issue_name}", {
      :headers => { "Authorization" => "Basic #{credentials}" }
    }).get
    json = JSON.parse(response)
    json
  end

  def self.credentials
    `git config --local --get gitjira.credentials`.chomp
  end

end


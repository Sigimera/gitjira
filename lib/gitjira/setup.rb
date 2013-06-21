require "base64"

class Gitjira::Setup
  def self.init
    host = nil
    username = nil
    password = nil
    projectkey = nil

    host = ask("JIRA host (e.g. https://jira.example.org): ")
    host = "#{host}/" if not host.empty? and not host.end_with?("/")

    username = ask("Your JIRA username                       : ")
    password = ask("Your JIRA password                       : "){ |q| q.echo = "*" }
    base64 = Base64.strict_encode64("#{username}:#{password}")
    username = password = nil

    projectkey = ask("Related JIRA project key (e.g. PROJ)     : ")

    if not host.empty? and not projectkey.empty?
      `git config --local gitjira.host #{host}`
      `git config --local gitjira.credentials #{base64.to_s}`
      `git config --local gitjira.projectkey #{projectkey}`
    else
      STDERR.puts "[ERROR] Please fill out all needed fields."
    end

  end

  def self.setup?
    `git config --local --get gitjira.host`.empty? ? false : true
  end
end

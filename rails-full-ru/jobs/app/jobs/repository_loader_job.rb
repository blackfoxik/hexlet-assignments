# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
    queue_as :default
  
    def perform(repo)
      repo.start_fetch!
      params = fetch_params(repo)
      repo.update!(params)
      repo.finish_fetch!
    end
  
    private
  
    def fetch_params(repo)
      repository_data = retrieve_repository_data(repo.link)
      build_params(repository_data)
    rescue StandardError
      repo.fail_fetch!
    end
  
    def retrieve_repository_data(link)
      client = create_client
      octokit_repo = Octokit::Repository.from_url(link)
      client.repository(octokit_repo)
    end
  
    def build_params(repository_data)
      {
        link: repository_data[:html_url],
        owner_name: repository_data[:owner][:login],
        repo_name: repository_data[:name],
        description: repository_data[:description],
        default_branch: repository_data[:default_branch],
        watchers_count: repository_data[:watchers_count],
        language: repository_data[:language],
        repo_created_at: repository_data[:created_at],
        repo_updated_at: repository_data[:updated_at]
      }
    end
  
    def create_client
      Octokit::Client.new(credentials)
    end
  
    def credentials
      {
        login: Rails.application.credentials[:github_login],
        password: Rails.application.credentials[:github_password]
      }
    end
  end
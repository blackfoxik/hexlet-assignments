# frozen_string_literal: true

class Web::RepositoryDataBuilderService
    def build(link)
      repository_data = retrieve_repository_data(link)
      build_params(repository_data)
    end
  
    private
  
    def retrieve_repository_data(link)
      client = create_client
      octokit_repo = Octokit::Repository.from_url(link)
      client.repository(octokit_repo)
    end
  
    def build_params(repository_data)
      {
        link: repository_data['url'],
        owner_name: repository_data['owner']['login'],
        repo_name: repository_data['name'],
        description: repository_data['description'],
        default_branch: repository_data['default_branch'],
        watchers_count: repository_data['watchers_count'],
        language: repository_data['language'],
        repo_created_at: repository_data['created_at'],
        repo_updated_at: repository_data['updated_at']
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
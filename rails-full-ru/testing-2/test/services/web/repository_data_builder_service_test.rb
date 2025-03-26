# frozen_string_literal: true

require 'test_helper'

class Web::RepositoryDataBuilderServiceTest < ActiveSupport::TestCase
  def setup
    @link = 'https://api.github.com/repos/octocat/Hello-World'

    response_body = load_fixture('files/response.json')

    stub_request(:get, @link)
      .to_return(
        status: 200,
        body: response_body,
        headers: { 'Content-Type' => 'application/json' }
      )

    @params = {
      link: 'https://api.github.com/repos/octocat/Hello-World',
      owner_name: 'octocat',
      repo_name: 'Hello-World',
      description: 'This your first repo!',
      default_branch: 'master',
      watchers_count: 80,
      language: nil,
      repo_created_at: '2011-01-26T19:01:12Z',
      repo_updated_at: '2011-01-26T19:14:43Z'
    }
  end

  test '#build' do
    method_call = Web::RepositoryDataBuilderService.new.build(@link)

    assert_equal(method_call, @params)
  end
end
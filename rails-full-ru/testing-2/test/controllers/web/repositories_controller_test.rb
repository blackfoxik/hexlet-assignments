# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @repository_params = {
      link: 'https://example.com/repo',
      owner_name: 'owner',
      repo_name: 'repo',
      description: 'A description',
      default_branch: 'main',
      watchers_count: 10,
      language: 'Ruby',
      repo_created_at: Time.now,
      repo_updated_at: Time.now
    }

    @repository = Repository.new(@repository_params)
  end

  test 'should create repository' do
    @mock = Minitest::Mock.new
    @mock.expect(:build, @repository_params, ['https://example.com/repo'])

    Web::RepositoryDataBuilderService.stub :new, @mock do
      assert_difference('Repository.count') do
        post repositories_url, params: { repository: { link: 'https://example.com/repo' } }
      end

      assert_redirected_to repositories_path
      assert_equal 'Success', flash[:notice]
      assert_equal true, true
    end
  end
end

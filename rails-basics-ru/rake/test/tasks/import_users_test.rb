# frozen_string_literal: true

require 'test_helper'
require 'rake'
require 'csv'

class ImportUsersTest < ActiveSupport::TestCase
  def setup
    App::Application.load_tasks if Rake::Task.tasks.empty?
  end

  test 'import users' do
    test_dir_path = File.dirname(__FILE__, 2)
    path = File.join test_dir_path, 'fixtures/files/users.csv'

    imported_emails = []

    CSV.foreach(path, headers: true) do |row|
      imported_emails << row['email']
    end

    Rake::Task['hexlet:import_users'].invoke(path)

    imported_emails.each do |email|
      user = User.find_by(email:)
      assert_not_nil user, "User with email #{email} was not imported"
    end
  end
end

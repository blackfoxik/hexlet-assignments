# frozen_string_literal: true

require 'csv'

# bin/rails "hexlet:import_users[test/fixtures/files/users.csv]"
namespace :hexlet do
  desc 'Creates 100 users from scv file'
  task :import_users, [:file] => :environment do |_t, args|
    print "Task started\n"
    path = args[:file]

    abort 'File path is required!' unless path
    abort 'Cant find data file!' unless File.exist?(path)

    # data = File.read(path)
    # users = CSV.parse(data, headers: true)

    users = CSV.read(path, headers: true)
    users.each do |u|
      # parsed_birthday = DateTime.strptime(u['birthday'], '%m/%d/%Y')
      # User.create!(u.to_hash.merge(birthday: parsed_birthday))
      u['birthday'] = Date.strptime(u['birthday'], '%m/%d/%Y')
      User.create!(u)
      print '.'
    end
    print "Done!\n"
  end
end

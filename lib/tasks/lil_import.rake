# frozen_string_literal: true

# This rake task will help import the SQL database backup file included
# with the exercise files.
#
# If you want to make your database look exactly like mine at the
# start of a movie--and lose all of your current data in the process--
# then run this script.  It is especially useful if your data gets
# too far out of synch or if you are jumping around in the exercise files.
#
# This file should go in the lib/tasks folder of your Rails application.
# To use it, from the command line, navigate to the root of your Rails
# application and then run "rake lil:import" and enter the database
# information at each prompt.

namespace :lil do
  desc 'Import RoR Essential Training SQL data.'
  task :import do
    env_config = ENV['RAILS_ENV'] || 'development'
    project_name = 'task_manager'
    default_db_name = "#{project_name}_#{env_config}"
    default_username = 'rails_user'
    default_password = 'secretpassword'
    print_intro(default_db_name, default_username, default_password)
    response = $stdin.gets.chomp
    if !%w[y yes].include?(response.downcase)
      puts 'Exiting import without any changes.'
    else
      host, database, username, import_file = get_user_input(default_db_name, default_username)
      run_import(host, database, username, import_file)
    end
  end

  def print_intro(default_db_name, default_username, default_password)
    puts
    puts '-' * 60
    puts 'Ruby on Rails Essential Training Import Task'
    puts
    puts 'This task will help import the SQL database backup file included '
    puts 'with the exercise files.'
    puts
    puts 'You must have already created a database before using this import.'
    puts "Example: CREATE DATABASE #{default_db_name};"
    puts "         CREATE USER '#{default_username}'@'localhost' \\"
    puts "         IDENTIFIED BY '#{default_password}';"
    puts "         GRANT ALL PRIVILEGES ON #{default_db_name}.* \\"
    puts "         TO '#{default_username}'@'localhost';"
    puts 'Refer to the sections on installing MySQL and configuring the '
    puts 'the database if you need more help.'
    puts
    puts 'If you have any problems with this script the same import can '
    puts 'also be run directly from the command line using:'
    puts '  mysql -u rails_user -p task_manager_development < db/task_manager_development.sql'
    puts 'Then enter the correct MySQL password when prompted.'
    puts '-' * 60
    puts
    puts 'Importing the new database data will wipe out any existing database data.'
    puts
    print 'Proceed? (yes/no) > '
  end

  def get_user_input(default_db_name, default_username)
    puts '-' * 60
    puts "\nYou can choose the default settings by just hitting return."
    print 'Enter database hostname: (localhost) > '
    response = $stdin.gets.chomp
    host = response.empty? ? 'localhost' : response

    print "Enter database name: (#{default_db_name}) > "
    response = $stdin.gets.chomp
    database = response.empty? ? default_db_name : response

    print "Enter database username: (#{default_username}) > "
    response = $stdin.gets.chomp
    username = response.empty? ? default_username : response

    default_file = File.join('db', "#{default_db_name}.sql")
    print "Enter import file path: (#{default_file}) > "
    response = $stdin.gets.chomp
    import_file = response.empty? ? default_file : response

    [host, database, username, import_file]
  end

  def run_import(host, database, username, import_file)
    puts
    puts "Please enter the correct MySQL password for the user '#{username}'"
    puts 'and hit return (for security, you will not see what you type).'
    import_command = "mysql -h #{host} -u #{username} -p #{database} < #{import_file}"
    verbose(false) do
      sh import_command do |ok, _res|
        if ok
          puts "\nImport complete.\n\n"
        else
          puts "\nImport failed.\n\n"
        end
      end
    end
  end
end

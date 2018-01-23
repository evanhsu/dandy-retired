#require "fileutils"

namespace :db do
  desc "Dump schema and data to timestamped files in the db/backups folder"
  task :rolling_dump do
    max_stored_backups = 25
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    old_schema_file = "db/schema.rb"
    old_data_file = "db/data.yml"
    backup_folder = "db/backup"
    schema_file = File.join(backup_folder,"#{datestamp}_schema.rb")
    data_file = File.join(backup_folder, "#{datestamp}_data.yml")

    File.exists?(backup_folder)? true : Dir.mkdir(backup_folder)

    Rake::Task["db:dump"].execute # Dump schema to db/schema.rb and data to db/data.yml

    FileUtils.cp(old_schema_file,schema_file)
    FileUtils.cp(old_data_file,data_file)

    max_files = max_stored_backups * 2 # Each backup consists of 2 files (schema and data)
    extra_files = Dir.new(backup_folder).entries[2..-1].sort.reverse[max_files..-1] #Select excess backup files
    unless extra_files.nil?
      extra_files.each do |file|
        File.delete(File.join(backup_folder,file))
      end
    end

  end
end
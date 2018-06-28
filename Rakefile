# frozen_string_literal: true

require "dotenv/tasks"


namespace :db do
  # To migrate to the latest version, run:
  #   rake db:migrate
  # This Rake task takes an optional argument specifying the target version. To
  # migrate to version 42, run:
  #   rake db:migrate[42]
  desc "Run migrations"
  task :migrate, [:version] => [:dotenv] do |_, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect(ENV.fetch("DATABASE_URL")) do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end
end

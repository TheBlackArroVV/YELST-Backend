namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require 'sequel/core'
    require 'dotenv/load'

    Sequel.extension :migration
    version = args[:version]&.to_i
    Sequel.connect(ENV.fetch('DATABASE_URL')) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
  end
end

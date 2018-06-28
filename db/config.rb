# frozen_string_literal: true

require "sequel"

DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
Sequel.extension :migration
Sequel::Migrator.check_current(DB, "#{__dir__}/migrations")

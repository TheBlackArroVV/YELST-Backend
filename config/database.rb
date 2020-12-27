require 'sequel'
require 'singleton'
require 'dotenv/load'

class Database
  include Singleton

  attr_reader :db

  def initialize
    @db = Sequel.connect(ENV['DATABASE_URL'])
  end
end

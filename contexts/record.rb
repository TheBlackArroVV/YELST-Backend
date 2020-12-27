require_relative '../config/database'

class Record
  def self.db
    ::Database.instance.db
  end
end

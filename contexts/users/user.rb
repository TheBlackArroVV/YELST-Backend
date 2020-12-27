class User < Record
  def self.all
    db[:users]
  end
end

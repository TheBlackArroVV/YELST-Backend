class Package < Record
  def self.all
    db[:packages]
  end
end

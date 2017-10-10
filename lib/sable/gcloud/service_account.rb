class Sable::GCloud::ServiceAccount
  attr_reader :email, :name

  def initialize(email, name)
    @email = email
    @name = name
  end
end

class Sable::DSL::Context::ServiceAccount
  attr_reader :email, :display_name

  def initialize(email, &block)
    @email = email

    instance_eval(&block)
  end

  def name(display_name)
    @display_name = display_name
  end

  def account
    @email.split('@')[0]
  end
end

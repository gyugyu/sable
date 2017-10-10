class Sable::DSL::Context
  attr_reader :service_accounts

  def initialize(options, &block)
    @options = options
    @service_accounts = {}

    instance_eval(&block)
  end

  def service_account(email, &block)
    @service_accounts[email] = Sable::DSL::Context::ServiceAccount.new(email, &block)
  end
end

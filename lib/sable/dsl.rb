class Sable::DSL
  def initialize(options)
    @options = options
  end

  def convert(service_accounts)
    Sable::DSL::Converter.new(service_accounts).convert
  end

  def parse(dsl)
    Sable::DSL::Context.new(@options) { eval(dsl, binding) }
  end
end

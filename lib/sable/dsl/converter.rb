class Sable::DSL::Converter
  def initialize(service_accounts)
    @service_accounts = service_accounts
  end

  def convert
    @service_accounts.map do |email, service_account|
      output_service_account(service_account)
    end.join("\n")
  end

  private

  def output_service_account(service_account)
    <<-EOS
service_account '#{service_account.email}' do
  name '#{service_account.name}'
end
    EOS
  end
end

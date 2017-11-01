class Sable::GCloud
  def initialize(options)
    @options = options
  end

  def service_accounts
    out = `gcloud iam service-accounts list`
    ensure_success

    result = {}
    out.split("\n")[1..-1]
      .map do |r|
        splitted = r.split(" ")
        email = splitted.last
        name = splitted[0..-2].join(" ")
        result[email] = ServiceAccount.new(email, name)
      end

    result
  end

  def create_service_account(service_account)
    `gcloud iam service-accounts create #{service_account.account} --display-name "#{service_account.display_name}"`
    ensure_success
  end

  def update_service_account(service_account)
    `gcloud iam service-accounts update #{service_account.email} --display-name "#{service_account.display_name}"`
    ensure_success
  end

  def delete_service_account(service_account)
    `gcloud iam service-accounts delete #{service_account.email}`
    ensure_success
  end

  private

  def ensure_success
    raise "GCloud command execution failed. Check configuration of GCloud." unless $?.success?
  end
end

require "rainbow"

class Sable::Command::Apply
  def initialize(gcloud, from, to)
    @gcloud = gcloud
    @from = from
    @to = to
  end

  def execute(dry_run)
    walk_service_accounts(dry_run)
  end

  private

  def walk_service_accounts(dry_run)
    scan_service_accounts_update(dry_run)

    @from.each do |email, service_account|
      next if @to[email]

      puts Rainbow(message_for(:delete, service_account, dry_run)).red
      @gcloud.delete_service_account(service_account) unless dry_run
    end

    @to.each do |email, service_account|
      next if @from[email]

      puts Rainbow(message_for(:create, service_account, dry_run)).cyan
      @gcloud.create_service_account(service_account) unless dry_run
    end
  end

  def scan_service_accounts_update(dry_run)
    @to.each do |email, service_account|
      from = @from[email]

      next unless from

      if from.name == service_account.display_name
        puts Rainbow("No change: #{from.email}").blue
        next
      end

      puts Rainbow(message_for(:update, service_account, dry_run)).green
      @gcloud.update_service_account(service_account) unless dry_run
    end
  end

  def message_for(action, service_account, dry_run)
    message = "#{action.to_s.capitalize} service account: #{service_account.email}"
    message << " (dry-run)" if dry_run
    message
  end
end

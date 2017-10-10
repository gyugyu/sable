class Sable::Client
  def initialize(options)
    @options = options
  end

  def apply(dry_run)
    expected = load_file(@options[:file])

    Sable::Command::Apply.new(
      gcloud,
      gcloud.service_accounts,
      expected.service_accounts
    ).execute(dry_run)
  end

  def export(output)
    File.write(output, dsl.convert(gcloud.service_accounts))
  end

  private

  def load_file(file)
    open(file) do |f|
      dsl.parse(f.read)
    end
  end

  def dsl
    @dsl ||= Sable::DSL.new(@options)
  end

  def gcloud
    @gcloud ||= Sable::GCloud.new(@options)
  end
end

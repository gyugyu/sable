require "optparse"

class Sable::Runner
  DEFAULT_SAFILE = 'SAFile'

  def run(argv)
    mode = nil
    dry_run = false
    options = {
      file: DEFAULT_SAFILE
    }
    output = DEFAULT_SAFILE

    opt.on('-a', '--apply') { mode = :apply }
    opt.on('', '--dry-run') { dry_run = true }

    opt.on('-e', '--export') do
      mode = :export
      options.delete(:file)
    end
    opt.on('-o', '--output=FILE') {|v| output = v }

    opt.parse!(argv)

    client = Sable::Client.new(options)
    case mode
    when :apply
      client.apply(dry_run)
    when :export
      client.export(output)
    end

    return 0
  end

  def opt
    @opt ||= OptionParser.new
  end
end

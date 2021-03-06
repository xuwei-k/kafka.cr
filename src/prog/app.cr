require "./deps"

abstract class App
  abstract def execute

  def self.run(args)
    new(args).run
  end

  getter :args

  def initialize(@args)
  end

  def run
    parse_args!
    execute
  rescue err
    die err
  ensure
    STDOUT.flush
    STDERR.flush
  end
end

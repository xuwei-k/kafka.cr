require "../app"

class Heartbeat < App
  include Options
    
  options :broker, :verbose, :version, :help

  usage <<-EOF
Usage: kafka-heartbeat [options]

Options:

Example:
  #{$0} -b localhost
EOF

  def do_show(broker)
    req = Kafka::Protocol::HeartbeatRequest.new(0, "kafka-heartbeart", "x", -1, "cr")
    res = execute req
    print_res(res)
  end
  
  def execute
    do_show(broker)
  end

  private def print_res(res)
    head = broker.to_s
    if res.error_code == 0
      STDOUT.puts "#{head}\t#{res.error_code}"
    else
      errmsg = Kafka::Protocol.errmsg(res.error_code)
      STDERR.puts "#{head}\t#{errmsg}".colorize(:red)
    end
  end
end

require "option_parser"
require "socket"
require "../kafka"
require "./utils/*"

dump = false
usage = false
opts = OptionParser.parse(ARGV) do |parser|
  parser.on("-d", "--dump", "Dump octal data") { dump = true }
  parser.on("-h", "--help", "Show this help") { usage = true }
end

help = -> {
  puts "Usage: kafka-heartbeat [options] destination"
  puts "  A destination is `host:port` or `host` (default port: 9092)"
  puts ""
  puts "Options:"
  puts opts
  puts "\n"
  puts <<-EXAMPLE
    Example:
      #{$0} localhost
      #{$0} localhost:9092
      #{$0} -d localhost
    EXAMPLE
  exit
}

if usage || ARGV.empty?
  help.call
end

broker = Kafka::Cluster::Broker.parse(ARGV.shift.not_nil!)
socket = TCPSocket.new broker.host, broker.port

req = Kafka::Protocol::HeartbeatRequest.new
bytes = req.to_binary

spawn do
  socket.write bytes
  socket.flush
  sleep 0
end

if dump
  p Kafka::Protocol.read(socket)
else
  p Kafka::Protocol::HeartbeatResponse.from_io(socket)
end

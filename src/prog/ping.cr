require "option_parser"
require "socket"
require "../kafka"
require "./ping/*"

module Ping
  def self.run(args)
    Main.new(args).run
  end
end

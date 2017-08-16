#!/usr/bin/env ruby

require "socket"
require "byebug"
require "active_support/all"
require_relative "method_negotiation"
require_relative "request"

class SocksServer
  def main
    server = TCPServer.new("127.0.0.2", 1025)
    loop do
      puts "Waiting for connection"
      # Thread.start(server.accept) do |client|
      client = server.accept
      MethodNegotiation.new(client).run


      puts "Connection closing"
      client.close
      # end
    end
  end
end

SocksServer.new.main

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
      socket = server.accept
      MethodNegotiation.new(socket).run

      Request.new(socket).run

      puts "Connection closing"
      socket.close
      # end
    end
  end
end

SocksServer.new.main

require_relative "version_checkable"

class MethodNegotiation
  include VersionCheckable

  attr_reader :message, :socket

  def initialize(socket)
    @socket = socket
    @message = socket.read(2).bytes
    ensure_socks5
    message << socket.read(message[1]).bytes
    puts "finished reading methods"
  end

  def run
    ensure_no_auth
    send_answer
    puts "finished sending method answer"
  end

  private

  def send_answer
    socket.write([05, 00].pack("C*"))
  end

  def ensure_no_auth
    auth_methods = message[2]
    no_auth = auth_methods.any? do |byte|
      byte == 0
    end
    unless no_auth
      raise AuthMethodError
    end
  end

  class ProtocolVersionError < StandardError; end
end

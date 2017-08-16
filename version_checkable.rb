module VersionCheckable
  def ensure_socks5(version=message[0])
    unless version == 5
      raise ProtocolVersionError
    end
  end

  class ProtocolVersionError < StandardError; end
end

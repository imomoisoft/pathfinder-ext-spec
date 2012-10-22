class RequestToExt
  def initialize(path)
    @path = path
  end

  def get()
    uri = URI.join(server, @path)
    res = Net::HTTP.get_response(uri)
  end

  def get_xml()
    res = get()
    Nokogiri::XML(res.body)
  end

  protected

  def server
    @server ||= APP_CONFIG['server']
  end
end

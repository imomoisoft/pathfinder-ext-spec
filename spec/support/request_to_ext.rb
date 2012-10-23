class RequestToExt
  def initialize(path)
    @path = path
  end

  def get(params = {})
    uri = URI.join(server, @path)
    uri.query = URI.encode_www_form(params || {})
    Net::HTTP.get_response(uri)

  end

  def get_xml(params = {})
    res = get(params)
    parse_xml(res.body)
  end

  def parse_xml(str)
    Nokogiri::XML(str)
  end

  protected

  def server
    @server ||= APP_CONFIG['server']
  end
end

class RequestToExt
  RootCA = '/etc/ssl/certs/'

  def initialize(path)
    @path = path
  end

  def get(params = {})
    uri = URI.join(server, @path)
    uri.query = URI.encode_www_form(params || {})
    # Net::HTTP.get_response(uri)

    resource = RestClient::Resource.new(
      uri.to_s,
      :ca_path          =>  RootCA,
      :verify_ssl       =>  OpenSSL::SSL::VERIFY_PEER
    )

    resource.get(:params =>  @params) do |response, request, result, &block|
      return response
    end
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

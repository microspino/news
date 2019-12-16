class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.uri_get(uri, limit = 10)
    raise 'HTTP redirect too deep' if limit == 0
    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url.path, { 'User-Agent' => 'Mozilla/5.0' })
    response = Net::HTTP.start(url.host, url.port, verify_mode: OpenSSL::SSL::VERIFY_NONE, use_ssl: url.scheme == 'https') { |http| http.request(req) }
    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then uri_get(response['location'], limit - 1)
    else
      response.error!
    end
  end
end

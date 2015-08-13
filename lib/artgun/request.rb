require 'open-uri'
require 'net/http'
require 'digest/sha1'

module Artgun
  def self.request data
    uri = URI.parse Artgun.api_endpoint
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Post.new uri.request_uri
    json = data.to_json
    signature = Digest::SHA1.hexdigest(Artgun.api_secret + Artgun.api_key + json)
    request.set_form_data(
      key: Artgun.api_key,
      data: json,
      signature: signature
    )
    http.request(request)
  end
end

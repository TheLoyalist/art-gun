require 'open-uri'
require 'net/http'
require 'digest/sha1'

module ArtGun
  def self.request data
    uri = URI.parse ArtGun.api_endpoint
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Post.new uri.request_uri
    json = data.to_json
    signature = Digest::SHA1.hexdigest(ArtGun.api_secret + ArtGun.api_key + json)
    request.set_form_data(
      key: ArtGun.api_key,
      data: json,
      signature: signature
    )
    resp = http.request(request)
    ArtGun::Response.new.from_json resp.body
  end
end

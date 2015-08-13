module Artgun
  @api_key       = ENV['ARTGUN_API_KEY']
  @api_secret    = ENV['ARTGUN_API_SECRET']
  @api_endpoint  = ENV['ARTGUN_API_ENDPOINT']
  @test_mode     = !!(ENV['ARTGUN_TEST_MODE'].to_s =~ /\A(true|t|yes|y|1)\z/i)

  class << self
    attr_accessor :api_key, :api_secret, :api_endpoint, :test_mode
    alias :test_mode? :test_mode

    def config_valid?
      api_key.present? and api_secret.present? and api_endpoint.present?
    end
  end
end

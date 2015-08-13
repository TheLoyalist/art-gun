module Artgun

  @api_key       = ENV['ARTGUN_API_KEY']
  @api_signature = ENV['ARTGUN_API_SIGNATURE']
  @api_endpoint  = ENV['ARTGUN_API_ENDPOINT']
  @test_mode     = !!(ENV['ARTGUN_TEST_MODE'].to_s =~ /\A(true|t|yes|y|1)\z/i)

  class << self
    attr_accessor :api_key, :api_signature, :api_endpoint, :test_mode
    alias :test_mode? :test_mode
  end

end

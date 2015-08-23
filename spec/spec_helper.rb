$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'dotenv'
Dotenv.load

require 'factory_girl'
require 'art-gun'

include ArtGun

Dir['./spec/factories/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

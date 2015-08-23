$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'dotenv'
Dotenv.load

require 'factory_girl'
require 'art-gun'

include ArtGun

require_relative 'factories.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

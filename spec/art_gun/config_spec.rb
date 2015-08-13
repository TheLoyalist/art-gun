require 'spec_helper'

describe "configuration" do
  it 'is in production mode by default' do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with("ARTGUN_TEST_MODE").and_return(nil)
    load 'art_gun/config.rb'
    expect(ArtGun.test_mode?).to be false
  end

  it 'activates test mode' do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with("ARTGUN_TEST_MODE").and_return("true")
    load 'art_gun/config.rb'
    expect(ArtGun.test_mode?).to be true
  end
end


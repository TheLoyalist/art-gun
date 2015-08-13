require 'spec_helper'

RSpec.describe Artgun::Order do

  def o attrs = {}
    Artgun::Order.new attrs
  end

  context 'attributes' do
    it 'checks static values' do
      expect(o.type).to eq 'order'
      expect(o.time).to be_kind_of(Time)
      expect(o.method).to eq 'create'
      expect(o.mode).to eq 'debug'
      expect(o.status).to eq 'In Production'
      expect(o.status_code).to be 6
    end

    it 'supplies a shipping phone number in case nothing is set' do
      expect(o.shipping_phone).to match /\A[0\-]+\z/
      expect(o(shipping_phone: '123').shipping_phone).to eq '123'
    end
  end

  context 'validations' do
    it 'is not valid without provided attributes' do
      expect(o).to be_invalid
    end

    it 'is valid with minimal attrs set' do
      order = o(xid: 'AD2832A', items_quantity: 3, shipping_carrier: 'DHL', shipping_priority: 'GROUND', shipping_name: 'Lars', shipping_address1: '33 W 17th St', shipping_city: 'New York', shipping_state: 'NY', shipping_country: 'US', shipping_zipcode: '10010')
      expect(order).to be_valid
    end

    it 'catches a too long shipping address' do
      order = o(shipping_address1: 'x'*41)
      order.valid?
      expect(order.errors[:shipping_address1].size).to be(1)
    end
  end
end


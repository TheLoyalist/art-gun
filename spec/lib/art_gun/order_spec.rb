require 'spec_helper'

RSpec.describe Order do

  def o attrs = {}
    Order.new attrs
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
      order = build :order
      expect(order).to be_valid
    end

    it 'catches a too long shipping address' do
      order = o(shipping_address1: 'x'*41)
      order.valid?
      expect(order.errors[:shipping_address1].size).to be(1)
    end

    it 'ensures at least one item is given' do
      order = build :order, items: []
      expect(order).to be_invalid
      expect(order.errors[:items].size).to be 1
    end

    it 'ensures associated items are validated too' do
      item = OrderItem.new(name: nil)
      order = build :order, items: [item]
      expect(order).to be_invalid
      expect(order.items.first.errors.size).to be > 0
    end
  end

  context '#as_json' do
    it 'checks a complete path to be available' do
      json = build(:order).as_json
      expect(json['items'][0]['attributes'][0]['file_extension']).to eq 'png'
    end
  end
end


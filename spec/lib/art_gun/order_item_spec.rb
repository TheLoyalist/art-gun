require 'spec_helper'

RSpec.describe OrderItem do
  context 'validations' do
    it 'is not valid without provided attributes' do
      expect(OrderItem.new).to be_invalid
    end

    it 'is valid with minimal attrs set' do
      item = build :order_item
      expect(item).to be_valid
    end

    it 'catches a too long name' do
      order = build :order_item, name: 's'*65
      order.valid?
      expect(order.errors[:name].size).to be 1
    end

    it 'ensures at least one attribute is given' do
      item = build :order_item, attrs: []
      expect(item).to be_invalid
      expect(item.errors[:attrs].size).to be 1
    end

    it 'ensures associated attrs are validated too' do
      item = build :order_item
      item.attrs.first.type = 'foo'
      expect(item).to be_invalid
      expect(item.attrs.first.errors.size).to be > 0
    end
  end

  context '#as_json' do
    it 'checks #attrs is not directly included, but via #attributes' do
      json = build(:order_item).as_json
      expect(json).to_not have_key 'attrs'
      expect(json).to have_key 'attributes'
    end
  end
end


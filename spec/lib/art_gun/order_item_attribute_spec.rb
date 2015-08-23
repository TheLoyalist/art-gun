require 'spec_helper'

RSpec.describe OrderItemAttribute do
  context 'validations' do
    it 'is not valid without provided attributes' do
      expect(OrderItemAttribute.new).to be_invalid
    end

    it 'is valid with minimal attrs set' do
      attr = build :order_item_attribute
      expect(attr).to be_valid
    end

    it 'does not allow gifs' do
      attr = build :order_item_attribute, file_extension: 'gif'
      attr.valid?
      expect(attr.errors[:file_extension].size).to be 1
    end
  end
end


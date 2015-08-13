module Artgun
  class OrderItem
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    @@attrs = %i(name sku quantity unit_amount subtotal_amount necklabel_binid item_attributes)
    cattr_reader :attrs
    attr_accessor *attrs

    validates :name, :sku, :quantity, presence: true
    validates :name, length: {maximum: 64}

    def attributes
      self.class.attrs.inject({}){|h,k| h[k.to_s] = nil; h}
    end

    def as_json opts = {include: :item_attributes}
      hash = super opts
      hash['attributes'] = hash.delete('item_attributes') # to avoid name conflict in model
      hash
    end
  end
end

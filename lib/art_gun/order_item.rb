module ArtGun
  class OrderItem
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    @@attrs = %i(name sku quantity unit_amount subtotal_amount necklabel_binid attrs)
    cattr_reader :attrs
    attr_accessor *attrs

    validates :name, :sku, :quantity, presence: true
    validates :name, length: {maximum: 64}
    validates :attrs,
      length: {minimum: 1}
    validate do
      errors.add :attrs, "One or more attributes (#attrs) are not valid" if attrs and attrs.any? &:invalid?
    end

    def attributes
      self.class.attrs.inject({}){|h,k| h[k.to_s] = nil; h}
    end

    def as_json opts = {}
      hash = super opts
      hash['attributes'] = attrs.map(&:as_json) # to avoid name conflict in model
      hash
    end
  end
end

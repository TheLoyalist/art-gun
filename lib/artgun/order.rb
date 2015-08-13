module Artgun
  class Order
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    @@attrs = :xid, :notes, :shiplabel_url, :pack_url,
      :items, :items_quantity, :items_amount, :items_tax,
      :shipping_carrier, :shipping_priority, :shipping_account,
      :shipping_name, :shipping_address1, :shipping_address2, :shipping_city, :shipping_state, :shipping_country, :shipping_zipcode, :shipping_phone, :shipping_email,
      :billing_name, :billing_address1, :billing_address2, :billing_city, :billing_state, :billing_country, :billing_zipcode, :billing_phone, :billing_email
    cattr_reader :attrs
    attr_accessor *attrs

    validates :type, :time, :method, :mode, :status, :status_code, :xid, :items_quantity,
      :shipping_carrier, :shipping_priority, :shipping_name, :shipping_address1, :shipping_city, :shipping_state, :shipping_country, :shipping_zipcode, :shipping_phone,
      presence: true
    validates :shipping_name, :shipping_address1, :shipping_address2, :shipping_city, :billing_name, :billing_address1, :billing_address2, :billing_city,
      length: {maximum: 40}
    validates :shipping_zipcode, :billing_zipcode,
      length: {maximum: 10}
    validates :shipping_phone, :billing_phone,
      length: {maximum: 15}
    validates :shipping_email, :billing_email,
      length: {maximum: 65}


    def type
      'order'
    end

    def time
      @time ||= Time.now.utc
    end

    def method
      'create'
    end

    def mode
      Artgun.test_mode? ? 'debug' : 'auto'
    end

    def status
      'In Production'
    end

    def status_code
      6
    end

    def shipping_phone
      @shipping_phone or '000-000-0000'
    end

    def attributes
      (self.class.attrs + %w(type time method mode status status_code)).inject({}){|h,k| h[k.to_s] = nil; h}
    end

    def as_json opts = {include: :items}
      super opts
    end
  end
end

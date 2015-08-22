module ArtGun
  class Response
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    @@attrs = %i(code message receipt_id res time url xid raw)
    cattr_reader :attrs
    attr_accessor *attrs

    def success?
      res == 'success'
    end

    def attributes
      self.class.attrs.inject({}){|h,k| h[k.to_s] = nil; h}
    end

    def attributes= hash
      hash.each do |key, value|
        send "#{key}=", value
      end
    end
  end
end

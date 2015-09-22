module ArtGun
  class OrderItemAttribute
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    @@attrs = %i(type location thumbnail preview file_url file_extension file_size file_hash width height)
    cattr_reader :attrs
    attr_accessor *attrs

    validates :type, :location, :thumbnail, :preview, presence: true
    validates :type, inclusion: {in: %w(DigitalPrint HeatTransfer HangTag)}
    validates :location, inclusion: {in: %w(CF FB LS RS)}, if: ->(a) { a.type == 'DigitalPrint' }
    validates :location, inclusion: {in: %w(FNL)}, if: ->(a) { a.type == 'HeatTransfer' }
    validates :location, inclusion: {in: %w(FN)}, if: ->(a) { a.type == 'HangTag' }
    validates :file_url, :file_extension, presence: true, if: ->(a) { a.type == 'DigitalPrint' }
    validates :file_extension, inclusion: {in: %w(jpg png)}, if: ->(a) { a.file_extension.present? }

    def attributes
      self.class.attrs.inject({}){|h,k| h[k.to_s] = nil; h}
    end

    def as_json opts = {}
      hash = super opts
      hash.inject({}) do |h, (k,v)|
        h[k] = v unless v.nil?
        h
      end
    end
  end
end

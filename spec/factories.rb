FactoryGirl.define do
  factory :order do
    xid 'AD2832A'
    items_quantity 1
    shipping_carrier 'DHL'
    shipping_priority 'GROUND'
    shipping_name 'Lars'
    shipping_address1 '33 W 17th St'
    shipping_city 'New York'
    shipping_state 'NY'
    shipping_country 'US'
    shipping_zipcode '10010'

    after :build do |order, evaluator|
      if order.items.nil?
        order.items = build_list :order_item, 1
      end
    end
  end

  factory :order_item do
    name 'T-Shirt'
    sku  '10133604'
    quantity 3
  end
end

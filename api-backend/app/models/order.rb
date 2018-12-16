class Order < ApplicationRecord
    # associations
    belongs_to :user
    
    # validations
    validates_presence_of :device, :yearly_price, :imei
end

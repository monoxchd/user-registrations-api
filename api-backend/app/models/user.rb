class User < ApplicationRecord
    # associations
    has_many :orders, dependent: :destroy
    
    # validations
    validates_presence_of :cpf
    validates_uniqueness_of :cpf
end

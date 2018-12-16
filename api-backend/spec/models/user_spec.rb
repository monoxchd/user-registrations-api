require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  
  it { should validate_uniqueness_of(:cpf)}
  it { should validate_presence_of(:cpf) }
end
